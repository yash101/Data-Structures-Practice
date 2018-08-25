#!/bin/bash
find . -name "build.sh" -exec echo "Building " {} \; -exec bash {} \;
