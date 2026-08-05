#!/usr/bin/env python3
"""Validate every YAML block shown in the decks and labs by actually rendering it.

Why this exists: slide/lab YAML lives in **non-executable** display blocks
(```yaml, ```{.yaml filename="_quarto.yml"}), so Quarto renders the page happily
whatever is inside them. Nothing validates the config a participant is about to
type, and the slide-shot fit-check measures pixels, not syntax. See
`.claude/rules/slides.md` section 8.

Each block is written into a throwaway project in the shape its filename says it
is -- document front matter, `_quarto.yml`, `_metadata.yml`, or `_brand.yml` --
and rendered. Stub assets (references.bib, custom.scss) are created so a missing
file does not masquerade as a schema error; errors are split into schema
failures (what we care about) and everything else.

    python3 .claude/scripts/check-yaml-blocks.py        # exit 1 on any schema failure
"""

import os
import pathlib
import re
import shutil
import subprocess
import sys
import tempfile

REPO = pathlib.Path(__file__).resolve().parents[2]
FENCE = re.compile(r'^(`{3,})[ ]*\{?\.?(?:yaml|yml)\b([^}]*)\}?\s*$')
# The signatures Quarto emits for a schema problem, as opposed to a missing asset.
SCHEMA = re.compile(
    r'Validation of YAML|is of type|must instead be|has empty value|did not match|Expected',
    re.I,
)


def blocks():
    files = sorted(REPO.glob('slides/**/*.qmd')) + sorted(REPO.glob('labs/**/*.qmd'))
    for f in files:
        lines = f.read_text().split('\n')
        i = 0
        while i < len(lines):
            m = FENCE.match(lines[i])
            if m:
                fence, attrs = m.group(1), m.group(2)
                j = i + 1
                while j < len(lines) and not re.match(fence + r'\s*$', lines[j]):
                    j += 1
                yield (f.relative_to(REPO), i + 1, attrs, '\n'.join(lines[i + 1:j]))
                i = j
            i += 1


def kind_of(attrs, body):
    """What file is this block claiming to be?"""
    m = re.search(r'filename="([^"]+)"', attrs)
    name = os.path.basename(m.group(1)) if m else None
    if name in ('_quarto.yml', '_metadata.yml', '_brand.yml'):
        return name
    # some blocks name themselves in a leading comment instead of a filename attr
    first = body.lstrip().split('\n', 1)[0].strip()
    for candidate in ('_quarto.yml', '_metadata.yml', '_brand.yml'):
        if first.startswith('#') and candidate in first:
            return candidate
    return 'front matter'


def scaffold(d, kind, body):
    d = pathlib.Path(d)
    # stubs, so only the schema is under test
    (d / 'references.bib').write_text(
        '@article{gorman2014,\n title={T}, author={A}, year={2014}, journal={J}\n}\n')
    (d / 'custom.scss').write_text('/*-- scss:rules --*/\n')
    if kind == 'front matter':
        (d / 'index.qmd').write_text(
            f'---\n{body}\n---\n\nHi. [@gorman2014]\n\n::: {{#refs}}\n:::\n')
        return
    (d / 'index.qmd').write_text('---\ntitle: I\n---\nHi.\n')
    if kind == '_metadata.yml':
        (d / 'analysis').mkdir()
        (d / 'analysis' / '_metadata.yml').write_text(body + '\n')
        (d / 'analysis' / 'page.qmd').write_text('---\ntitle: P\n---\nHi.\n')
        (d / '_quarto.yml').write_text('project:\n  type: website\n')
    else:
        (d / kind).write_text(body + '\n')
        if kind == '_brand.yml':
            (d / '_quarto.yml').write_text('project:\n  type: website\n')


def main():
    failures = 0
    checked = 0
    for (f, line, attrs, body) in blocks():
        kind = kind_of(attrs, body)
        d = tempfile.mkdtemp()
        try:
            scaffold(d, kind, body)
            p = subprocess.run(['quarto', 'render'], cwd=d,
                               capture_output=True, text=True, timeout=300)
            log = p.stdout + p.stderr
        finally:
            shutil.rmtree(d, ignore_errors=True)
        checked += 1
        bad = [l.strip() for l in log.split('\n') if SCHEMA.search(l)]
        if bad:
            failures += 1
            print(f'SCHEMA FAIL  {f}:{line}  (as {kind})')
            for b in bad[:4]:
                print('    ' + b)
        else:
            print(f'ok           {f}:{line}  (as {kind})')
    print(f'\n{checked} YAML blocks checked, {failures} schema failures')
    return 1 if failures else 0


if __name__ == '__main__':
    sys.exit(main())
