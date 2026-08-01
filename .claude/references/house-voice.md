# Reference — house voice (how Christophe writes; strip the machine tells)

The concrete profile behind the "spoken-but-professional English" line in CLAUDE.md. Distilled from
Christophe's own hand across four prior workshops (`raukr-2025-quarto`, `raukr-2023-quarto`,
`user2024-tutorial-quarto`, `raukr-2021-rmd-boost`), plus the LLM-tell list that keeps re-introducing
the thing he flagged. Applies to **all participant-facing prose** — for authoring and for review.
The operational short list is the path-scoped rule `.claude/rules/prose-voice.md`; this is the depth.

## The one principle

**Written prose states. The presenter's voice lives in `::: notes`.**

The recurring problem: spoken emphasis crammed into written text — mid-sentence dashed asides, little
reassurances, "and that's the point" flourishes. If a line reads like something you'd *say to soften or
sell* the point, it's the spoken register leaking onto the page. Say it in `::: notes`; on the page,
state the thing.

## Registers (know which one you're in)

| Surface | Register | Dashes / asides |
|---|---|---|
| Website pages (`setup.qmd`, `index.qmd`, lab prose) | **Written.** State it. | Parenthesis / colon / split sentence. No em-dash asides. |
| Slide **bodies** | Terse, built to be said over. Fragments fine. | A `term — gloss` bullet is fine; no stacked or voice-over asides. |
| `::: notes` / `::: {.notes}` | Fully spoken. Relaxed. **Exempt.** | Anything goes — this is where the voice-over belongs. |

## Christophe's voice — what to do

- **Short declarative spine.** One main clause, at most one parenthetical tail. When you explain *why*
  and the sentence starts to balloon, **split it**, don't stack subordinate clauses.
- **Asides go in parentheses** — his primary device, and he'll stack two per sentence
  (`command line interface (CLI)`; `built over nearly a decade (resulting in lots of duplication)`).
- **Colon introduces** an example, a list, code, or the answer to a heading
  (`Assumption for the tutorial: you know R Markdown`). Very frequent, especially trailing before a code
  block.
- **Direct second person.** "you" carries the teaching; verb-first imperatives (`add`, `render`,
  `note that`). Personal "I" / "let's" is fine in written prose ("I'll come help you"); institutional
  "we/us" for Posit and rationale. No cold third-person "the user".
- **Rhetorical-question heading, answered on the next line** — a signature move
  (`## Like R Markdown then?` → `Yes — built on 10 years of knitr + rmarkdown`).
- **Plain, warm, concrete words.** Name the actual tool (`knitr`, `_quarto.yml`, `#|`, TinyTeX).
  "benefit from", not "leverage". Mild homely positives carry the enthusiasm (`handy`, `nice`, `fresh`,
  `elegantly formatted`), not hype adjectives.
- **Gloss jargon inline** — a parenthetical `(i.e. …)` / `(e.g. …)`, or an analogy that does the work
  (`Like git, this is a system-level component…`; `Extensions … like R packages with R Markdown`).
- **Caveats hedge and reassure**, they don't dramatize: a parenthetical `(should never be necessary!)`,
  a short "But …" / "Note that …" sentence, or a typed callout to pin the un-missable ones. Prefer
  "should continue to work" over "always works".
- **Bold is surgical and semantic** — the one load-bearing concept or a two-term contrast
  (`**unifies** + **extends**`), never decoration, never a whole sentence.

## Punctuation — his kit vs. what to avoid

| Mark | Verdict | Instead |
|---|---|---|
| `—` em-dash aside | **Avoid in prose.** Zero in ~2600 lines of his writing. | Parenthesis (aside), colon (before example/list), or a full stop + new sentence. |
| Two dashes splitting subject from verb (`The way — X, Y, Z — is …`) | **The signature offender. Never.** | Rewrite: state the subject-verb, put the qualifiers in a `(…)` tail or a following sentence. |
| Dramatic trailing `— punch.` | Avoid. Spoken punctuation. | Full stop, or a colon if a list/example follows. |
| `;` semicolon | Avoid. Essentially absent from his prose. | Split the sentence, or use a parenthesis. |
| `:` colon | **Yes** — into an example, list, code, or answer. | — |
| `(…)` parenthesis | **Yes** — his primary aside; up to two per sentence. | — |
| `…` ellipsis | Sparingly — open sets, suspense between slides. | — |
| Space before `?` `!` `:` `;` (` ?`, ` !`) | **Error in English.** French typography (*espace insécable*) leaking in — it is NOT a voice trait to keep. | Remove the space: `?`, `!`. Copy-edit fix. |
| ASCII vs smart punctuation | Keep it ASCII where the repo does. | Straight quotes; `--`→ rewrite, don't "upgrade" to `—`. |

## Machine tells to strip (these keep re-introducing the problem)

1. **Em-dash asides — #1.** Any mid-sentence `—`/`--` interjection, especially stacked. (See table.)
2. **Participial voice-over tail** — sentence + comma + "-ing" editorial: "…, making it easy to X",
   "…, ensuring Y", "…, so you never have to think about it". Cut it or make it a plain clause.
3. **Dramatic colon payoff** — "The result: magic." (Colons introduce *examples*, not one-word punches.)
4. **Reflexive rule-of-three** — every list three balanced items for rhythm. Vary the count.
5. **Antithesis flip** — "not just X, it's Y" / "not only … but …" / "isn't about X, it's about Y".
   State the thing directly.
6. **Signposting / throat-clearing** — "It's worth noting that", "Keep in mind", "That said",
   "Here's the thing", "Let's dive in", "At the end of the day", reflexive "In short".
7. **Reassurance narration in parens** — "(don't worry)", "(so nothing surprises you)",
   "(no magic here)". Spoken hand-holding. Delete or make concrete.
8. **Inflated verbs/adjectives** — leverage, utilize, facilitate, streamline, unlock, empower, delve,
   robust, seamless, powerful/elegant as filler, effortless, game-changing.
9. **Vague intensifiers** — really, very, quite, incredibly, simply, "just" as filler, actually.
10. **Scattered bold** for rhythm rather than the one load-bearing concept.
11. **Mechanical symmetry** — every paragraph the same length, every section the same shape. Real
    writing has uneven beats.

## No idiomatic English (Christophe writes English as a second language)

Christophe's first language is French. **Idiomatic English figures of speech read as not-his-voice** —
a native-speaker or LLM flourish he would never write. In participant-facing **body** prose, say the
thing plainly and literally; skip the colloquial idiom. This is not about "dumbing down" — his English
is precise and warm — it is about not putting words in his mouth that he wouldn't use.

Flagged and removed, as the pattern to recognise:
- "nobody is stranded by the break" → the fallback is already stated ("a finished reference is in
  `solutions/…`"); cut the reassurance idiom.
- "if an attempt goes sideways" → "if an attempt goes wrong".

Others in the same class to avoid (non-exhaustive): "hit the ground running", "the whole nine yards",
"a room-killer", "back to square one", "your mileage may vary", "piece of cake", "on the same page",
"reinvent the wheel", "low-hanging fruit", "moving the needle". Plain replacements always exist.
(Mild, near-literal metaphors he *does* use are fine — "batteries included", "under the hood" appear in
his own decks. The test: would a precise non-native writer produce this, or is it a native-speaker
idiom? When unsure, prefer the literal statement.) `::: notes` are spoken cues he adapts live, so a
relaxed idiom there matters less — but body prose that renders to the page should stay literal.

## Before / after (the worked examples)

- `The easiest way to get it — **no git, no GitHub account, nothing to unzip by hand**, identical on
  Windows/macOS/Linux — is **`use_course()`** from R:`
  → `The easiest way to get it is **`use_course()`** from R. No git, no GitHub account, nothing to unzip
  by hand, and the same on Windows, macOS, and Linux:`
  *(two dashes splitting subject from verb → state subject-verb, move the qualifiers to a following
  sentence + colon into the code.)*

- `**What it does**, so nothing surprises you:`
  → `**What it does:**`
  *(strip the reassurance narration; colon into the list.)*

- `…a small **exercises folder** (…) — the starter documents, the reference solutions, and the citation
  assets (…).`
  → `…a small **exercises folder** (…): the starter documents, the reference solutions, and the citation
  assets (…).`
  *(dashed appositive → colon.)*

## Retire these recurring beats (they read as a verbal tic once you notice them)

- `— no LaTeX` / `— no data to download` (appears in setup, both labs, the Day-1 deck) — state it once,
  plainly, where it first matters; drop the trailing-dash echo elsewhere.
- `nobody is stranded by the break` — say "a finished reference is in `solutions/…` if you fall behind".
- `is a reference, not a checklist` (3×) — keep once; vary or cut the repeats.

## What NOT to codify

Christophe's hand has ESL tells — the French space before `?`/`!`, agreement slips ("features
requires"), spellings ("themeing", "accomodate", "juts"). **Reproduce the voice, not the typos.** The
copy-editing half of the language review exists to catch these; they are errors, not style.
