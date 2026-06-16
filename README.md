# personal-site

A static personal site built with [Astro](https://astro.build), documenting
completed projects and technical challenges. Hosted on GitHub Pages.

See [SPEC.md](./SPEC.md) for architecture and [IDEA.md](./IDEA.md) for intent.

## Develop

```sh
npm install      # install dependencies
npm run dev      # start the dev server at http://localhost:4321
npm run build    # build the production site to ./dist
npm run preview  # preview the built site locally
```

## Writing content

Essays are Markdown/MDX files in `src/content/blog/`. Frontmatter is validated
against the schema in `src/content.config.ts` (`title`, `description`,
`pubDate`, optional `updatedDate` and `heroImage`).

## Deploy

Pushing to `master` triggers `.github/workflows/deploy.yml`, which builds the
site and publishes it to GitHub Pages. Set the repository's Pages **Source** to
**GitHub Actions** once, and ensure the repo is named `rootdrew27.github.io`.

## Tooling note

`pyproject.toml` / `uv.lock` exist only to provide the `tether` dev tool via
`uv run tether`; they are not part of the site build.
