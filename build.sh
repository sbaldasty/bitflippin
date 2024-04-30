#!/bin/bash

# Remove the output directory
rm -rf out

# Create or recreate the output directory
mkdir out

# Build homepage
python home.py

# Build common resources the output directory
python assets.py
python logo.py
python headshot.py
python codesnippets.py

# Build articles
for f in article/*.mako; do
    bn=$(basename -- $f)
    python article.py "${bn%.*}"
done