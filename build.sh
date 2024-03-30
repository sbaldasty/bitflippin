#!/bin/bash

# Remove the output directory
rm -rf out

# Create or recreate the output directory
mkdir out

# Build the site in the output directory
python assets.py
python logo.py
python headshot.py

# TODO This is temporary
python article.py information-theory-in-history-and-museums