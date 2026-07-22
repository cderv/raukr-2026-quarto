# Archive — design notes & reviews

This folder keeps the **build history** of the workshop material, in the open ("dev in the
open"). Nothing sensitive lives here: these are working notes and review reports about the
**material**, not about people.

It is a **snapshot store** — the past is never rewritten. An obsolete note is kept as-is (a
witness to a stage), not corrected.

## Contents

- **`plans/`** — closed work plans and design notes. The *in-progress* plan lives in
  `../plans/`; it is moved here once done.
- **`reviews/`** — dated review reports, mostly produced by the `workshop-reviewer-*` agents
  (`../agents/`): technical (Quarto), pedagogy, beginner participant, language. Naming:
  `review-YYYY-MM-DD[-tag]-[type].md`.
- **`issues/`** — drafts of issues to file upstream (e.g. `quarto-dev/quarto-cli`).

## Not archived here

Secrets, links to private documents, third-party personal information. Those stay out of the
repo (`.gitignore`). Full rules in [`../CLAUDE.md`](../CLAUDE.md) (section *Working-note
archiving*).
