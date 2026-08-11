---
paths:
  - .claude/**/*.md
  - .claude/**/*.sh
  - .claude/**/*.mjs
  - .claude/**/*.yml
  - .claude/**/*.yaml
  - theme*.scss
  - '**/_brand*.yml'
  - '**/_quarto.yml'
  - '**/_metadata.yml'
  - .github/**/*.yml
  - .github/**/*.yaml
  - justfile
---

# Maintainer prose and configuration comments

When editing a matching file, use plain, literal language in operational documentation and comments.
Preserve technical terms, commands, paths, and configuration keys. Participant-facing conventions
such as direct address and presenter-note routing do not apply here.

## Instructions and troubleshooting

- State the required action and expected outcome directly.
- For a failure, give the observable symptom, a useful cause when needed, and the exact recovery
  action.
- Describe software behavior literally. State what fails, is omitted, or is overridden. Do not
  personify tools or dramatize failures.
- Use one term per concept. Search the repository before introducing a synonym.

## Comments and internal documentation

- Keep comments local to the adjacent command or setting.
- Do not record investigation history, rejected alternatives, review transcripts, or commit
  summaries in source comments.
- Keep rationale only when it changes how a maintainer should interpret or modify the artifact.
- Prefer a complete plain sentence to wording made awkward by over-compression.
