#!/usr/bin/env bash

set -e
set -o pipefail

FORCE_BUILD=false
if [[ "$1" == "--force" ]]; then
    FORCE_BUILD=true
    echo "⚠️ Force mode enabled: All versions will be rebuilt!"
fi

DOCKER_REPO="danzigergeist/archy"
VERSIONS_URL="https://sdk-cdn.mypurecloud.com/archy/versions.json"

AVAILABLE_VERSIONS=$(curl -s "$VERSIONS_URL" | jq -r '.[].version')

LATEST_VERSION=$(echo "$AVAILABLE_VERSIONS" | tail -n 1)

function docker_tag_exists() {
    local version="$1"
    curl --silent -f -lSL "https://hub.docker.com/v2/repositories/$DOCKER_REPO/tags/$version" > /dev/null
}

docker buildx create --use || true

for VERSION in $AVAILABLE_VERSIONS; do
    if [[ "$FORCE_BUILD" == false ]] && docker_tag_exists "$VERSION"; then
        echo "🟢 Version $VERSION already exists on Docker Hub. Skipping..."
    else
        echo "🔵 Building version $VERSION..."
        docker buildx build --platform linux/amd64 --build-arg ARCHY_VERSION="$VERSION" -t "$DOCKER_REPO:$VERSION" -q --push .
        if [ "$VERSION" == "$LATEST_VERSION" ]; then
            echo "🔵 Tagging $LATEST_VERSION as latest..."
            docker tag "$DOCKER_REPO:$VERSION" "$DOCKER_REPO:latest"
            docker push "$DOCKER_REPO:latest"
        fi
    fi
done

echo "✅ Build process completed!"
