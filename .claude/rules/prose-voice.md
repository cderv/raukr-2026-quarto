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

## Troubleshooting and comments

- State the observable symptom, a useful cause when needed, and the exact action.
- Describe software behavior literally. Do not personify tools or label warnings `harmless` and
  errors `bogus`; state their effect.
- Keep comments local to the next command or setting. Put diagnostic history in a reference file.

Before finishing, review each changed sentence and comment for unclear subjects, duplicated
explanations, inconsistent terminology, and text that belongs in presenter notes or nowhere.
