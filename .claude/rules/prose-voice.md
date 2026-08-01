---
paths:
  - setup.qmd
  - index.qmd
  - labs/**/*.qmd
  - slides/**/*.qmd
  # Repo-facing prose is public too, and drifts out of voice without this.
  - README.md
  - LICENSE.md
  - .claude/**/*.md
---

# Rule — house voice (write like Christophe; strip the machine tells)

Operational short list for participant-facing prose. Full profile + before/after examples:
`.claude/references/house-voice.md`. One principle: **written prose states; the presenter's voice
lives in `::: notes`.** If a line reads like something you'd *say to soften or sell* the point, it's
spoken register leaking onto the page.

## Do

- **Short declarative spine** — one main clause + at most one parenthetical tail. Ballooning? Split it.
- **Asides in parentheses** (his primary device), **colon** into an example/list/code/answer,
  or a separate short "But …" / "Note that …" sentence. Callouts pin the un-missable caveats.
- **Direct "you"** and verb-first imperatives; personal "I"/"let's" is fine; "we/us" for Posit/rationale.
- **Plain warm words** — name the tool; "benefit from" not "leverage"; `handy`/`nice`/`fresh`, not hype.
  Gloss jargon inline `(i.e. …)` or by analogy (`Like git, …`).
- **Bold surgical and semantic** — the one load-bearing concept, never decoration.

## Don't (the tells that keep re-introducing the problem)

- **Em-dash asides — #1 offender.** No mid-sentence `—`/`--` interjection, *especially* two dashes
  splitting subject from verb (`The way — X, Y, Z — is …`) or a dramatic trailing `— punch.`
  Replace with `(…)`, a `:`, or a full stop + new sentence. (A plain `term — gloss` slide bullet is OK.)
- **No `;` semicolons** — split or parenthesise.
- **No participial voice-over tail** (`…, making it easy to X`, `…, so you never have to think about it`).
- **No reassurance narration** (`(don't worry)`, `so nothing surprises you`, `no magic here`).
- **No corporate verbs** (leverage/utilize/facilitate/streamline) or **vague intensifiers**
  (really/very/simply/just-as-filler).
- **No antithesis flip** (`not just X, it's Y`) or **signposting** (`It's worth noting that`, `In short`).
- **No idiomatic English** in body prose. Christophe writes English as a second language (French first);
  colloquial figures of speech read as not-his-voice ("nobody is stranded", "goes sideways", "hit the
  ground running", "low-hanging fruit"). Say it plainly and literally. (Near-literal metaphors he does
  use — "batteries included", "under the hood" — are fine.)

## Copy-edit (English, not French typography)

- **No space before `?` `!` `:` `;`** — `publications ?` → `publications?`. French *espace insécable*
  leaking in; an error to fix, not a voice trait to keep. Grep: `rg -n ' [?!]' --glob '*.qmd'`.
- Keep punctuation **ASCII** where the repo does; don't "upgrade" `--` to `—`.

## Find the tics

```bash
rg -n --glob '*.qmd' --glob '!_*.qmd' -- '—|--' setup.qmd index.qmd labs slides   # em-dashes
rg -n --glob '*.qmd' -- ' [?!]'                                                    # French spacing
rg -niE '\b(leverage|utilize|facilitate|streamline|seamless|robust)\b' --glob '*.qmd'
```
