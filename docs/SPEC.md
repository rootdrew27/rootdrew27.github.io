# SPEC.md

## Tech Stack

- **Astro** (static site generator) — the blog starter template.
- Markdown / MDX for content, with typed content collections.
- Node toolchain for building.

## Hosting

- **GitHub Pages**, served as a *root user site* at
  `https://rootdrew27.github.io/`.
- Because it is a root user site, Astro's `base` stays `/` and
  `site` is set to `https://rootdrew27.github.io` in `astro.config.mjs`.
- The GitHub repository must be named exactly `rootdrew27.github.io`.

## Content

- Essays live as Markdown/MDX files in `src/content/blog/`.
- Each entry's frontmatter is schema-validated by `src/content.config.ts`:
  - `title` (string, required)
  - `description` (string, required)
  - `pubDate` (date, required)
  - `updatedDate` (date, optional)
  - `heroImage` (image, optional)
- Image assets are committed alongside the site (e.g. `src/assets/`) and
  optimized at build time, rather than fetched from GitHub at request time.

## Deployment

- A GitHub Actions workflow (`.github/workflows/deploy.yml`) builds the site
  with `withastro/action` and publishes it via `actions/deploy-pages` on every
  push to `master`. Pages "Source" must be set to **GitHub Actions**.
