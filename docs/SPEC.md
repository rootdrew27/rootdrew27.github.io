# SPEC.md

## Tech Stack

- **Astro** (static site generator).
- Markdown / MDX for content, with typed content collections.
- Node toolchain for building.

## Hosting

- **GitHub Pages**, served as a *root user site* at
  `https://rootdrew27.github.io/`.
- Because it is a root user site, Astro's `base` stays `/` and
  `site` is set to `https://rootdrew27.github.io` in `astro.config.mjs`.
- The GitHub repository must be named exactly `rootdrew27.github.io`.

## Pages

- **Home** (`src/pages/index.astro`) — a minimal landing page: short greeting
  and links into the resume and blog.
- **Resume** (`src/pages/resume.astro`) — an extended resume with a link to
  download the abridged one-page PDF served from `public/` (path set by
  `pdfPath` in the resume YAML).
- **Blog** (`src/pages/blog/`) — an index of essays and per-post pages.
- Navigation lives in `src/components/Header.astro`; the site title links home,
  and the nav links to Resume and Blog.

## Content

- Content lives in typed collections defined in `src/content.config.ts`.
- **Blog essays** (`blog` collection) are Markdown/MDX files in
  `src/content/blog/`. Each entry's frontmatter is schema-validated:
  - `title` (string, required)
  - `description` (string, required)
  - `pubDate` (date, required)
  - `updatedDate` (date, optional)
  - `heroImage` (image, optional)
  - The blog index renders a fallback "nothing here yet" state when the
    collection is empty.
- **Resume** (`resume` collection) is a single YAML file in
  `src/content/resume/` (profile, experience, projects, leadership, skills,
  education, honors, and `pdfPath`), schema-validated like the blog. The resume
  page renders from this data; editing the resume means editing the YAML, not
  markup. The downloadable one-page PDF is an abridged version maintained
  separately in `public/`.
- Image assets are committed alongside the site (e.g. `src/assets/`) and
  optimized at build time, rather than fetched from GitHub at request time.

## Quality checks

- `npm run check` runs `astro check` (type-checking plus content-collection
  schema validation). The deploy workflow runs it before building, so a schema
  or type error fails the deploy rather than shipping.

## Deployment

- A GitHub Actions workflow (`.github/workflows/deploy.yml`) builds the site
  with `withastro/action` and publishes it via `actions/deploy-pages` on every
  push to `master`. Pages "Source" must be set to **GitHub Actions**.
