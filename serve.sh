#!/bin/bash

# Open URL with default browser
# TODO Change URL eventually
open http://localhost:8000/demo.html

# Start web server (script does not exit until server stops)
python -m http.server -d out 8000
