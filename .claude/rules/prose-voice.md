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
  # Troubleshooting and operational wording also lives in comments.
  - .claude/**/*.sh
  - .claude/**/*.mjs
  - .claude/**/*.yaml
  - theme*.scss
  - '**/_brand*.yml'
  - '**/_quarto.yml'
  - '**/_metadata.yml'
  - .github/**/*.yml
  - justfile
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
- **The split is two-way.** Notes do not repeat the slide, and the slide does not carry the notes'
  explanation. Record only the prompt, action, or warning needed live. When the same point sits in
  both, cut it from the slide and keep it in the notes.
- Split unrelated actions into separate bullets. Remove narration and background explanation.
- Add a duration only when a rehearsal supports it.

## Troubleshooting, recovery instructions, and code comments

Apply the same plain-language standard to lab Troubleshooting blocks, setup references, reviewer
recipes, speaker warnings, and explanatory comments in shell/YAML/SCSS. Technical prose may name the
mechanism, but it must not dramatize or personify it.

- Lead with the **observable symptom**, then give the **cause** only when it helps, then the exact
  **action**. A short entry may need only the symptom and action.
- Describe software behaviour literally. A tool does not *bite*, *fight*, *starve*, *strand* a page,
  *happily* accept input, *invent* failures, or wear a problem "as a mask". State what fails, what is
  omitted, what is overridden, or which mode remains active.
- Do not label a warning **harmless** or an error **bogus**. State its impact: "The warning does not
  stop the PDF from building" or "The dependency error is misleading."
- Avoid unexplained shorthand in comments (`seed it`, `stages atomically`, `load-bearing fix`). Name
  the operation and outcome (`restore it separately`, `renv discards the restore if one package
  fails`, or `required before either install path`).
- Prefer headings that name the condition: **Prerequisite**, **Known failure**, **Windows shebang
  constraint**, or **If rendering fails**. Do not use **Gotcha** as a catch-all heading.
- Keep comments local. Record what the next command requires or prevents, not the investigation
  history. Put durable diagnostic detail in a reference file.

Examples from the 2026-08-09 troubleshooting audit:

| Avoid | Write |
|---|---|
| `a bogus mutual dependency failure` | `a misleading dependency error involving gt` |
| `the failed update starves later installs` | `later installs fail because the repository was not indexed` |
| `the file alone doesn't reach ggplot` | ``_brand.yml` alone does not apply the palette to ggplot figures` |
| `the toggle strands the page in dark mode` | `the page remains in dark mode with no way to switch back` |
| `Harmless warning` | `The warning does not stop the PDF from building` |

## Don't (the tells that keep re-introducing the problem)

- **Em-dash asides — #1 offender.** No mid-sentence `—`/`--` interjection, *especially* two dashes
  splitting subject from verb (`The way — X, Y, Z — is …`) or a dramatic trailing `— punch.`
  Replace with `(…)`, a `:`, or a full stop + new sentence. (A plain `term — gloss` slide bullet is OK.)
- **On a slide body, no explaining parenthesis.** The line above sends you to `(…)`, which is right in
  a lab or in notes. On a **slide**, an aside that explains, corrects, or justifies is what you *say*,
  so it belongs in `::: notes`. The test: if the clause would also fit in the notes, it goes only
  there. A short gloss (`(i.e. …)`) and a `term — gloss` bullet still stand. (2026-08-10: a Day-2
  brand slide read `(that is why your HTML changed too, not only the PDF)` while the note beneath it
  said the same thing.)
- **No `;` semicolons** — split or parenthesise. Sentence bullets end with periods, not semicolons.
- **One name per thing.** A YAML fragment is a **block**, or name the **key**. Never a *stanza*
  (borrowed config jargon, and not a French cognate either, so it reads as not-his-voice). Before
  introducing a noun for something the material already names, grep for the name in use.
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

## Final language pass

Before finishing any participant-facing change, review every added or modified sentence and comment
against this rule. Treat generated prose and accepted reviewer suggestions as drafts: both require
the same wording review.

Check for:

- unnatural, dramatic, personified, or idiomatic wording
- narration that belongs in presenter notes or nowhere
- vague subjects, causes, actions, or outcomes
- duplicated explanations
- comments that record the work instead of explaining the adjacent setting
- terminology that differs from the rest of the material

Do not broaden this pass into a technical or pedagogical rewrite. Preserve the intended meaning and
instructional structure.

## Find the tics

```bash
rg -n --glob '*.qmd' --glob '!_*.qmd' -- '—|--' setup.qmd index.qmd labs slides   # em-dashes
rg -n --glob '*.qmd' -- ' [?!]'                                                    # French spacing
rg -niE '\b(leverage|utilize|facilitate|streamline|seamless|robust)\b' --glob '*.qmd'
rg -niE '\bstanza\b' --glob '*.qmd' setup.qmd index.qmd labs slides   # say "block" / "key"
# One-off vocabulary: a word used once where a synonym carries the rest of the repo is the tell.
# Compare counts before adding a noun -- e.g. block(9) vs stanza(1) is how the stanza slipped in.
# Cross-day pointers -- judge each in context (a real callback is fine, a narrated one is not)
rg -niE '\b(story|saga|chapter|teas(e|ed|er)|foreshadow\w*|yesterday|tomorrow)\b' --glob '*.qmd' slides labs
# Troubleshooting/comment metaphors (inspect matches; quoted counterexamples are expected).
rg -niE '\b(gotcha|bogus|harmless|silently|clobber\w*|starv\w*|strand\w*|happily|fight\w*|bite|bites)\b|sharp edge|worked blind' \
  --glob '*.qmd' --glob '*.md' --glob '*.sh' --glob '*.scss' --glob '*.yml' --glob '*.yaml'
```
