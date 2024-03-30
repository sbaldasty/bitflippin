# bitflippin.com

This repository contains everything to build the website from scratch, except external images.

## Dependencies

### PIP

These are the pip-installable packages used to build the website.

- **Mako**: HTML templating engine.
- **PIL**: Image manipulation.

### Filesystem

Some of the scripts rely on raw images being present in a `~/CAMERA` directory. These are too big for a git repository so I keep them locally and on external media for backup.

## Scripts

These scripts can be run from the command line.

- **article.py**: Builds an article in the output directory, given a mako template path.
- **assets.py**: Builds static assets by copying them to the output directory.
- **build.sh**: Recreates the entire site from scratch in the output directory.
- **headshot.py**: Builds the headshot that appears in the footer of every page.
- **logo.py**: Builds the site logo in the output directory.
- **serve.sh**: Starts a local web server on port 8000 based in the output directory.