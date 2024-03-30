#!/bin/bash

# Remove the output directory
rm -rf out

# Create or recreate the output directory
mkdir out

# Build common resources the output directory
python assets.py
python logo.py
python headshot.py

# Build articles
for f in article/*.mako; do
    bn=$(basename -- $f)
    python article.py "${bn%.*}"
done