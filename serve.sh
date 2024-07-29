#!/bin/bash
set -e

# Open URL with default browser
open http://localhost:8000/

# Start web server (script does not exit until server stops)
python -m http.server -d out 8000
