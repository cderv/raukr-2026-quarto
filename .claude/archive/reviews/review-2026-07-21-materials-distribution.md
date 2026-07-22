# Review — how participants *get* the lab materials (starters, solutions, assets)

Date: 2026-07-21 · Scope: distribution mechanism only (not lab content) · Author: research agent

Question: for ~40 people (Windows included) on conference wifi, no reliable git/SSH, TAs roaming,
some falling behind and needing the solution at the right moment — **how should participants obtain
the starter files, the citation/image assets, and the solutions?** Judged against our constraints:
Windows-native, no-auth, wifi-resilient, assets-travel-with-files, solution-timing, folds into
`NBISweden/raukr-2026`, low maintenance.

---

## 1. What each prior workshop actually does

| Workshop | Starters / assets — mechanism | Solutions — mechanism | Auth cliff? |
|---|---|---|---|
| **Ours today** (`setup.qmd:54-57`, `:68`) | `git clone https://github.com/cderv/raukr-2026-quarto.git` (whole repo, **HTTPS**) then `renv::restore()` (`setup.qmd:68`). Assets (`references.bib`, `apa.csl`, `starter/`) ride inside the repo. | Inline `code-fold: true` + `eval: false` in lab pages (`labs/quarto/index.qmd:115-117`, `:228-230`); plus a separate self-contained `labs/quarto-projects/solution/` project (own `_brand.yml` + `_quarto.yml`). | HTTPS clone — low, but still "install/know git". |
| **NBIS 2026** (`raukr-nbis`) | README is contributor-facing ("Fork/clone", `README.md:14,23`). The **quarto-site lab opens with SSH clone** — `git clone git@github.com:username/site.git` (`labs/quarto-site/index.qmd:39`) → the flagged room-killer. Individual assets use **per-file download buttons**: `<a class="btn btn-primary btn-sm" href="https://raw.githubusercontent.com/NBISweden/raukr-2026/.../profile.webp">{{< fa download >}}` (`labs/quarto-site/index.qmd:153,213,303,340`). Data pulled in-code via `download.file(url=…zip)` (`labs/projects/index.qmd:122-125`). | (No timed-reveal system; labs are build-from-scratch.) | **Yes** — the SSH opener. |
| **NBIS 2025** (`NBISweden_raukr-2025`) | Three tiers (`home_precourse.qmd`): **Conda/Miniforge** env (`:47-55`); **Docker container** `ghcr.io/nbisweden/workshop-raukr:latest` with RStudio Server, "easiest way" (`:141-150`); or **Download ZIP / `git clone https://…`** via the green Code button (`:162-170`). Per-asset **download buttons to Dropbox** (`?dl=1`) for CSVs (`labs/ggplot/index.qmd:456,831`). | (No timed-reveal system.) | No (Docker/conda/HTTPS-zip all avoid SSH). |
| **cderv user2024** | Two site-relative **zips**: `exercises.zip` (starters/resources) and `examples-correction.zip` (solutions), downloaded from the site (`_pre-tutorial-files.qmd`). Built by `Makefile:59-66` (`Compress-Archive` on Windows / `zip` on unix). Two Quarto profiles `_quarto-pretuto.yml` / `_quarto-tuto.yml` split the "before" and "during" sites. | The **`examples-correction.zip`** with an explicit warning: *"Do not look in advance if you really want to practice on the day."* | **No** — pure zip download. |
| **cderv tuto-2023** | Same as user2024: `exercices.zip` + `exemples-correction.zip`, `_preparatif-files.qmd`, pretuto/tuto profiles. | `exemples-correction.zip`. | No. |
| **cderv tuto-quarto-typst-rr-2026** | **Companion R package `tutoquartotypst`** (installed from r-universe: `install.packages("tutoquartotypst", repos=…)`, pulls all 8 R deps). `installer_exercices()` (`pkg/R/installer-exercices.R:27`) **copies the bundled `starter/` files** (starters only — solutions excluded via `.copier_dossier(exclure="correction")`) into a **user-chosen** folder (RStudio `selectDirectory()` picker, else `readline`; default `exercices-typst`). `verifier_installation()` checks R/Quarto/pkgs + test-render. Manual fallback (`preparatifs.qmd:105`): download the **repo zip** `…/archive/refs/heads/main.zip`, material in `exercises/`, each starter carries an `.Rproj`. `creer_projet_typst()` *generates* a fresh reuse skeleton (post-course), not exercise files. | **Timed, no-spoiler, on demand:** `ouvrir_correction("01")` (`pkg/R/correction.R:23`) opens the solution **online on GitHub** after a confirmation prompt; `recuperer_correction("01")` (`:68`) copies it **locally on demand**, after confirmation. Solutions are deliberately **not** laid down by `installer_exercices()`. | **No** — package install + local copy; zip fallback. |
| **cderv raukr-2025-quarto** | Slides-only talk repo — no starter/solution distribution (the "Posit Cloud" hit at `index.qmd:737` is a `quarto publish` target list, not a delivery mechanism). | — | — |

**Two clear lineages:** NBIS leans on **environment images + per-asset download buttons**; Christophe's
own workshops have evolved **zip → zip → companion-package with `installer_exercices()` + timed
`ouvrir/recuperer_correction()`**. The typst-2026 package is the most refined solution-timing design in
the corpus, and it's Christophe's own.

---

## 2. Mechanism-by-mechanism, against our constraints

**(1) Clone the whole repo (current).**
+ One source of truth; assets travel; `renv.lock` present so `renv::restore()` works. + Folds into NBIS trivially (it *is* a repo).
− Assumes git installed + a mental model of clone; on Windows that's a real filter. − "clone the workshop repo" hands people the *entire* site incl. solutions and slides up front (no solution timing). − The SSH variant (NBIS's opener) is a hard room-killer; even HTTPS clone stalls a fraction of a 40-person room.
Verdict: fine as the *alternative* for git-comfortable folks; wrong as the *only* front door.

**(2) `usethis::use_course()` / downloaded zip (Jenny's way).**
+ **No git, no auth, no SSH** — download + native unzip + opens the project, one line. + Windows-native (uses R's own unzip). + Assets travel (they're in the zip). + **another guest instructor is in the room** teaching this exact call — social proof + a shared vocabulary across sibling sessions. + Christophe already shipped the zip-download variant twice (user2024, 2023).
− A whole-repo zip includes solutions/slides unless you point it at a curated subset zip. − Static snapshot: re-fetch to get fixes (fine for a fixed workshop). − One conference-wifi download of a few MB (do it before arrival).
Verdict: **best fit for starters+assets.**

**(3) Per-file download buttons (`downloadthis` / raw links / `{{< embed >}}`).**
+ Perfect **TA recovery path** — "you're missing `references.bib`? click here." + Exactly the NBIS house pattern (`{{< fa download >}}` raw.githubusercontent buttons), so it folds into their tree unchanged. + `downloadthis` **embeds the file in the HTML**, so the click works even on flaky wifi once the page loaded.
− Doesn't scale to a whole folder tree; tedious as the *primary* channel. − Raw-link buttons need network at click-time (wifi risk); `downloadthis` inflates the page.
Verdict: **excellent complement** (recovery + single-asset), not the primary channel.

**(4) Companion R package with a laydown function (typst-2026 model).**
+ The most polished single-namespace UX: dep-install + toolchain-check + **starter laydown** + **timed solution reveal**, all no-auth, cross-platform, folder-picker. + Best-in-class solution timing (`ouvrir/recuperer_correction`).
− **Maintenance**: build/maintain a package, r-universe, keep `inst/` in sync with `exercises/` (they run a CI check for exactly this). − **Does not fold into the NBIS site** — NBIS won't ship a personal R package; it's a parallel artifact. − Heavy for a 2×2h session with two small labs.
Verdict: gold standard we **borrow the *ideas* from** (starters-only laydown; online-first, on-demand solutions) without taking on the package.

**(5) Posit Cloud / cloud project.**
+ Zero local install; identical env for all. − Needs accounts/seats; org buy-in; drifts from "run it on your own laptop," which is the point of teaching the local toolchain. Not used by any prior here as a *delivery* channel.
Verdict: out of scope for this cohort.

**(6) Solutions — inline `code-fold` vs separate `solution/` vs timed reveal.**
- Inline `code-fold: true` (collapsed) — travels with the page, renders on the published site, self-paced, TA-cueable ("unfold when ready"). **No file to distribute.** We already do this.
- Separate `solution/` project — needed for the *projects* lab (a whole working project is the payoff). Keep it, but **online-first**: browsable/downloadable, **not** in the starter payload.
- Timed reveal (typst-2026's `ouvrir_correction` online-first) — the principle to adopt: solutions live **online / behind a click**, never pre-seeded into the participant's working folder.

---

## 3. Recommendation

### Starters + assets → `usethis::use_course()` (no-auth zip), clone demoted to an alternative

Make the no-git zip the **default** front door; keep `git clone` for git-comfortable folks; keep
`renv::restore()` for the toolchain (the zip carries `renv.lock` + `DESCRIPTION`, so restore works
from the unzipped folder).

Rewrite `setup.qmd` § "Get the materials" to lead with:

```r
# install.packages("usethis")
usethis::use_course("cderv/raukr-2026-quarto")
```

That downloads the default-branch zip, unpacks it to your Desktop, opens the project in RStudio, and
deletes the zip — **no git, no SSH, no account.** (v1 zero-effort: point at the whole repo. If we
later want to hand participants a *lean* payload without slides/solutions, publish a curated
`raukr-quarto-materials.zip` as a GitHub **Release asset** and call
`usethis::use_course("https://github.com/cderv/raukr-2026-quarto/releases/download/vX/raukr-quarto-materials.zip")`
— `use_course()` accepts any zip URL. Include `renv.lock` + `DESCRIPTION` + `labs/**` + assets in it.)

Then, unchanged: `renv::restore()`, `quarto check`, and the font pre-warm (`quarto render
labs/quarto/sample-typst.qmd`) — all run from the unzipped folder exactly as today.

**Coexistence with the clone page:** the repo stays the single source of truth; `use_course()` and
`git clone https://…` both fetch the same tree, so keep clone as a one-line "Prefer git? …"
alternative right below. When this folds into `NBISweden/raukr-2026`, swap the `owner/repo` (or the
release-asset URL) — the mechanism is unchanged and matches Jenny's sibling session.

### Solutions → online-first + inline `code-fold`, never in the starter payload

1. **In-room timed reveal:** keep the inline `code-fold: true` collapsed solution in each lab page
   (already present in `labs/quarto/index.qmd`). It renders on the published site, is self-paced, and
   a TA can say "unfold it now" — no file changes hands, nothing to spoil in the starter folder.
2. **The `projects` solution project** (`labs/quarto-projects/solution/`): keep it, but publish it to
   the site and expose it as a **"browse online / download the finished project"** link — mirroring
   typst-2026's `ouvrir_correction()` (online-first, behind an intentional click), so it isn't sitting
   in the participant's working tree tempting them early.

### Add download buttons as the TA recovery path

For the individual assets that must travel with a file (`references.bib`, `apa.csl`, `starter.qmd`),
add **per-file download buttons** — the exact NBIS pattern so it folds in cleanly:

```markdown
<a class="btn btn-primary btn-sm"
   href="https://raw.githubusercontent.com/cderv/raukr-2026-quarto/main/labs/quarto/references.bib"
   role="button" target="_blank">{{< fa download >}} references.bib</a>
```

Or, for wifi resilience (embeds the file into the page so the click works offline once loaded), the
`downloadthis` extension:

```r
#| echo: false
downloadthis::download_file(
  path = "references.bib", output_name = "references",
  button_label = "Download references.bib", button_type = "primary"
)
```

This turns "I arrived without the materials / I deleted a file" from a re-clone into one click — the
roaming-TA failure mode we most need to cover.

---

## ~7-line summary

- **Priors:** NBIS = environment images (2025 Docker/conda) + SSH-clone opener (2026, the room-killer)
  + per-asset download buttons; Christophe's own = zip→zip→a companion R package `tutoquartotypst`
  whose `installer_exercices()` lays down **starters only** and `ouvrir_correction()`/`recuperer_correction()`
  reveal solutions **online-first, on demand** (the best timing design in the corpus, but package-heavy
  and doesn't fold into NBIS).
- **Starters + assets:** switch the default from `git clone` to **`usethis::use_course("cderv/raukr-2026-quarto")`**
  — no git/SSH/account, Windows-native unzip, assets bundled, `renv.lock` included, and it's Jenny
  Bryan's canonical mechanism (she's a sibling instructor). Keep `git clone https://…` as the alt; keep
  `renv::restore()`.
- **Solutions:** keep them **out of the starter payload** — inline collapsed `code-fold` in the lab
  pages for the in-room timed reveal, and the `projects` solution project published **online / behind a
  click**, never pre-seeded.
- **Top 3 concrete changes:** (1) rewrite `setup.qmd` § "Get the materials" to lead with `use_course()`,
  demote clone to an alternative; (2) publish `labs/quarto-projects/solution/` to the site + link it as
  browse/download instead of shipping it in what people fetch up front; (3) add NBIS-style
  `{{< fa download >}}` (or `downloadthis`) buttons for `references.bib` / `apa.csl` / `starter.qmd` as
  the TA recovery path.
