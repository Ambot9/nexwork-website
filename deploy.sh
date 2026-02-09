#!/usr/bin/env sh

# Abort on errors
set -e

# Build
echo "Building..."
npm run build

# Navigate into the build output directory
cd dist

# Create a new git repo in dist
git init
git add -A
git commit -m 'Deploy to GitHub Pages'

# Push to gh-pages branch
git push -f git@github.com:Ambot9/nexwork-website.git main:gh-pages

cd -

echo "Deployed successfully!"
