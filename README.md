# ryanjeong.github.io

Personal site built with [Quarto](https://quarto.org). Posts support MathJax and embedded Python whose results (values, charts) are computed at build time and baked into the static HTML.

## Run locally (Docker)

```bash
docker compose up --build
```

Open <http://localhost:4444>. The preview hot-reloads as you edit.

## Write a post

Create `posts/<slug>/index.qmd`:

````markdown
---
title: "My Post"
date: 2026-06-20
categories: [math, python]   # these become tags on the home page
description: "One-line summary."
---

Inline math $a^2 + b^2 = c^2$ and a Python chart:

```{python}
import matplotlib.pyplot as plt
plt.plot([1, 2, 3], [1, 4, 9])
plt.show()
```
````

Code runs during `docker compose up` (or `quarto render`); its output is cached in `_freeze/`. **Commit the `_freeze/` directory** so builds are reproducible.

## Publish

Merge `dev` into `main`. The GitHub Actions workflow renders the site and deploys it to GitHub Pages. The `dev` branch is for work and does not publish.

## Layout

| Path                       | Purpose                                  |
| -------------------------- | ---------------------------------------- |
| `_quarto.yml`              | Site config: navbar, theme, search       |
| `index.qmd`                | Home page (post listing + tag filter)    |
| `about.qmd`                | About page                               |
| `posts/`                   | One folder per post                       |
| `posts/_metadata.yml`      | Shared post defaults (freeze, toc)       |
| `_freeze/`                 | Cached Python execution results (commit) |
| `.github/workflows/`       | Build + deploy on push to `main`         |
