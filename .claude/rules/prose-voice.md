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
lives in `::: notes`.** Notes can sound spoken, but they are not exempt from concision. If a line
reads like something you'd *say to soften or sell* the point, it belongs in notes or nowhere.

## Do

- **Short declarative spine** — one main clause + at most one parenthetical tail. Ballooning? Split it.
- **Asides in parentheses** (his primary device), **colon** into an example/list/code/answer,
  or a separate short "But …" / "Note that …" sentence. Callouts pin the un-missable caveats.
- **Direct "you"** and verb-first imperatives; personal "I"/"let's" is fine; "we/us" for Posit/rationale.
- **Plain warm words** — name the tool; "benefit from" not "leverage"; `handy`/`nice`/`fresh`, not hype.
  Gloss jargon inline `(i.e. …)` or by analogy (`Like git, …`).
- **Bold surgical and semantic** — the one load-bearing concept, never decoration.

## Presenter notes

- Keep notes glanceable in presenter mode: normally one line per **Say**, **Do**, **Ask**,
  **Watch for**, or **Catch-up** item.
- Do not repeat the slide or lab text. Record only the prompt, action, or warning needed live.
- Split unrelated actions into separate bullets. Remove narration and background explanation.
- Add a duration only when a rehearsal supports it.

## Don't (the tells that keep re-introducing the problem)

- **Em-dash asides — #1 offender.** No mid-sentence `—`/`--` interjection, *especially* two dashes
  splitting subject from verb (`The way — X, Y, Z — is …`) or a dramatic trailing `— punch.`
  Replace with `(…)`, a `:`, or a full stop + new sentence. (A plain `term — gloss` slide bullet is OK.)
- **No `;` semicolons** — split or parenthesise. Sentence bullets end with periods, not semicolons.
- **No participial voice-over tail** (`…, making it easy to X`, `…, so you never have to think about it`).
- **No reassurance narration** (`(don't worry)`, `so nothing surprises you`, `no magic here`).
- **No corporate verbs** (leverage/utilize/facilitate/streamline) or **vague intensifiers**
  (really/very/simply/just-as-filler).
- **No antithesis flip** (`not just X, it's Y`) or **signposting** (`It's worth noting that`, `In short`).
- **No narrated cross-day pointers.** A pointer to another day states the schedule: `We'll see it in
  Day 2.` / `That's part of Day 2.` / `X was one line in Day 1.` Never a narrative noun (`That's the
  Day 2 **story**`) or presenter-jargon for the act of pointing (`Day 1 I **teased** freeze`) — those
  are `::: notes` register. And keep `yesterday`/`tomorrow` for the actual adjacent day, never for a
  generic future (`Add a page tomorrow?` → `later?`).
- **No idiomatic English** in body prose. Christophe writes English as a second language (French first);
  colloquial figures of speech read as not-his-voice ("nobody is stranded", "goes sideways", "hit the
  ground running", "low-hanging fruit", "ship it", "payoff", "the output lands", "to hand",
  "tips & tricks"). Say it plainly and literally: "publish", "result", "is written to", "have the
  file", "practical techniques". (Near-literal metaphors he does use — "batteries included", "under
  the hood" — are fine.)

## Compression is not the goal (banked from the 2026-08-06 copy-edit)

Avoiding the tells by compressing produces a different failure: strained wording no plain writer
would use. What an external copy-edit fixed in one day's additions, as the patterns to recognise:

- **Strained verb phrase from over-compression.** "Writing the line keeps the folder you will
  publish named in the config" → "We write it explicitly here so the publishable folder is visible
  in the configuration." A plain subject-verb-purpose sentence beats a compressed clever one. Same
  class: "the minimum to leave with" (a stranded-preposition tail).
- **A checkpoint opens with the action or the observable, never a slogan.** "Three renders, three
  different outcomes." → "Check the label and timestamp after each render." And name what changes
  ("the label and timestamp both update"), not a quality word ("both are fresh"): in an acceptance
  test the concrete observable wins, even over the allowed warm words.
- **Name the exact change in a guided step.** "switch the value:" → "change `freeze` from `auto`
  to `true`:". The instruction sentence stands alone, even when the code block below repeats it.
- **Don't narrate the reader's cognition.** "The loop to remember: …" → "With `freeze: true`, the
  workflow is: …". Stating the workflow is the page's job. Remembering it is the reader's.

Counter-lesson: **reviewer wording is not house wording.** The same review round introduced
"minimum finish line" (an idiom, caught one pass later). Accepted suggestions get the same tic
greps as fresh prose.

## Before adding a sentence: who reads it, and when?

The tells above catch bad *phrasing*. This one catches text that should not be on the page at
all — the more common failure once the phrasing is under control.

| If the reader is… | it goes… |
|---|---|
| someone who **would ask the question** | `::: notes` (presenter ready, page unchanged) |
| someone who **just hit this error** | the lab's Troubleshooting block |
| someone who needs it **before the day** | `setup.qmd` |
| **nobody** — but it's true and you just found it out | nowhere |

The failure mode is writing up the mechanism you just discovered instead of what the reader needs
at that moment. It feels like thoroughness and lands as clutter, and it compounds: three "useful"
clauses turn a scannable step into a wall.

Two from the 2026-08-03 cycle, both cut: a parenthetical explaining that brand *fonts* arrive
whatever the `theme:` order is (true, and already covered by the Troubleshooting bullet a reader
hits only when it bites them), and a Troubleshooting entry for a font-download failure that mimics
a missing `_brand.yml` (real, rare, needs network to reproduce — it belongs in `::: notes`, where
the presenter has it if someone asks).

**Don't add a FAQ page to escape this test.** The three tiers above already cover before / during /
if-asked, each with an owner and a moment. A fourth surface duplicates two of them and sits one
click away at exactly the moment someone is stuck.

## Copy-edit (English, not French typography)

- **No space before `?` `!` `:` `;`** — `publications ?` → `publications?`. French *espace insécable*
  leaking in; an error to fix, not a voice trait to keep. Grep: `rg -n ' [?!]' --glob '*.qmd'`.
- Keep punctuation **ASCII** where the repo does; don't "upgrade" `--` to `—`.

## Find the tics

```bash
rg -n --glob '*.qmd' --glob '!_*.qmd' -- '—|--' setup.qmd index.qmd labs slides   # em-dashes
rg -n --glob '*.qmd' -- ' [?!]'                                                    # French spacing
rg -niE '\b(leverage|utilize|facilitate|streamline|seamless|robust)\b' --glob '*.qmd'
# Cross-day pointers -- judge each in context (a real callback is fine, a narrated one is not)
rg -niE '\b(story|saga|chapter|teas(e|ed|er)|foreshadow\w*|yesterday|tomorrow)\b' --glob '*.qmd' slides labs
```
