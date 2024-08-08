git fetch --prune --unshallow --tags
from=$(git describe --tags --abbrev=0)
version=$(cat pubspec.yaml | grep -o 'version:[^:]*' | cut -f2 -d":" | xargs)
changelog=$(git log $from..HEAD --pretty=format:"* %s by %an")
echo "## What's Changed\n$changelog\n\n**Full Changelog**: https://github.com/o-ifeanyi/cardflix-app/compare/$from...v$version" > release_notes.txt