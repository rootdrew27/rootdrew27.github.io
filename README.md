# personal-site

A static personal site built with [Astro](https://astro.build), documenting
completed projects and technical challenges. Hosted on GitHub Pages.

See [docs/SPEC.md](./docs/SPEC.md) for architecture.

## Develop

```sh
npm install      # install dependencies
npm run dev      # start the dev server at http://localhost:4321
npm run check    # type-check and validate content collections (astro check)
npm run build    # build the production site to ./dist
npm run preview  # preview the built site locally
```

## Writing content

Blog essays are Markdown/MDX files in `src/content/blog/`. Frontmatter is
validated against the schema in `src/content.config.ts` (`title`, `description`,
`pubDate`, optional `updatedDate` and `heroImage`). When the collection is
empty, the blog index renders a "nothing here yet" fallback.

The resume page is driven by a single YAML file in `src/content/resume/`,
validated against the `resume` collection schema in `src/content.config.ts`.
Edit that file to update the resume — sections (experience, projects,
leadership, skills, education, honors) are arrays. The downloadable one-page PDF
is an abridged version kept in `public/` and linked from the YAML's `pdfPath`.

## Deploy

Pushing to `master` triggers `.github/workflows/deploy.yml`, which builds the
site and publishes it to GitHub Pages. Set the repository's Pages **Source** to
**GitHub Actions** once, and ensure the repo is named `rootdrew27.github.io`.
