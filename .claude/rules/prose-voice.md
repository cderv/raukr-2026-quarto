---
paths:
  - setup.qmd
  - index.qmd
  - labs/**/*.qmd
  - slides/**/*.qmd
  - README.md
  - LICENSE.md
---

# Participant prose and presenter notes

Use the full voice profile and examples in `.claude/references/house-voice.md` when a wording task
needs them. Apply this short list whenever you edit participant-facing prose.

## Written prose

- State the point directly. Use a short declarative sentence with at most one useful aside.
- Prefer plain, concrete words, direct `you`, and verb-first instructions.
- Use parentheses for a brief aside, a colon before an example or list, or a new sentence.
- Gloss unfamiliar terms on first use. Keep slide wording reusable; put domain-specific examples in
  presenter notes when possible.
- Use US English. Remove French spacing before `?`, `!`, `:`, and `;`.
- Use bold only for a load-bearing concept.
- Use one name per thing. A YAML fragment is a `block`, or name the `key`. Before introducing a new
  noun for something the material already names, grep for the name already in use.

Avoid:

- mid-sentence em-dash or `--` asides
- semicolons
- participial commentary such as `..., making it easy to ...`
- reassurance or narration of the reader's thoughts
- corporate verbs, vague intensifiers, signposting, and antithesis flips
- idioms that are less clear than a literal statement
- narrative cross-day language such as `story`, `teased`, or `foreshadowed`

## Slides and notes

- Slide bodies are terse. Move spoken explanation, correction, and classroom rationale to
  `::: notes`.
- Presenter notes use short `Say`, `Do`, `Ask`, `Watch for`, `Timing`, or `Catch-up` cues. Keep one
  idea per bullet and do not repeat the slide.

## Where a sentence belongs

Before adding a sentence, decide who reads it and when.

| The reader is | It goes |
|---|---|
| someone who would ask the question | `::: notes` |
| someone who just hit this error | the lab's Troubleshooting block |
| someone who needs it before the day | `setup.qmd` |
| nobody, but it is true and you just found it out | nowhere |

Writing up a mechanism you just discovered feels like thoroughness and lands as clutter. Three
added clauses turn a scannable step into a wall. Do not add a FAQ page to escape this test: the
three destinations above already cover before, during, and if-asked, each with an owner and a
moment.

## Troubleshooting and comments

- State the observable symptom, a useful cause when needed, and the exact action.
- Describe software behavior literally. Do not personify tools or label warnings `harmless` and
  errors `bogus`; state their effect.
- Keep comments local to the next command or setting. Put diagnostic history in a reference file.

## Final pass

Before finishing, review each changed sentence and comment for unclear subjects, duplicated
explanations, inconsistent terminology, and text that belongs in presenter notes or nowhere.
Treat generated prose and accepted reviewer suggestions as drafts: both need this same review.
Keep the pass to wording. Do not widen it into a technical or pedagogical rewrite.

Compressing to avoid the tells produces its own failure: strained wording no plain writer would
use. A plain subject-verb-purpose sentence beats a compressed clever one.

## Find the tics

A match is a candidate, not a defect. Read each one in context. Ripgrep is regex by default, so do
not add `-E`, which ripgrep reads as `--encoding` and not as extended-regex.

```bash
rg -n --glob '*.qmd' --glob '!_*.qmd' -- '—|--' setup.qmd index.qmd labs slides   # em-dashes
rg -n --glob '*.qmd' -- ' [?!]' setup.qmd index.qmd labs slides                   # French spacing
rg -ni '\b(leverage|utilize|facilitate|streamline|seamless|robust)\b' --glob '*.qmd' setup.qmd index.qmd labs slides
rg -ni '\bstanza\b' --glob '*.qmd' setup.qmd index.qmd labs slides                # say "block" or "key"
# Cross-day pointers: a plain schedule pointer is fine, a narrated one is not. Judge each in context.
rg -ni '\b(story|saga|chapter|teas(e|ed|er)|foreshadow\w*|yesterday|tomorrow)\b' --glob '*.qmd' slides labs
# Troubleshooting and comment metaphors. Quoted counterexamples in the rules are expected matches.
rg -ni '\b(gotcha|bogus|harmless|silently|clobber\w*|starv\w*|strand\w*|happily|fight\w*|bites?)\b|sharp edge|worked blind' \
  --glob '*.qmd' --glob '*.md' --glob '*.sh' --glob '*.scss' --glob '*.yml' --glob '*.yaml' \
  setup.qmd index.qmd labs slides .claude
```

A word used once where a synonym carries the rest of the material is the tell. Compare counts
before adding a noun.
