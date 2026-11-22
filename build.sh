#!/bin/sh -e
# Compiles the action into dist/: action.mjs bundled with its packages, bober's host.mjs that runs it, and main.mjs and
# post.mjs, which start it for each step.
bober build -js -o build/action.mjs src/action.bob
npx esbuild build/action.mjs --bundle --platform=node --format=esm --log-level=warning --outfile=dist/action.mjs \
	--banner:js="import { createRequire } from 'node:module'; const require = createRequire(import.meta.url);"
cp "$(dirname "$(readlink -f "$(command -v bober)")")/../lib/host.mjs" dist/
for step in main post; do
	printf 'process.argv.push(new URL("action.mjs", import.meta.url).pathname, "%s")\nawait import("./host.mjs")\n' \
		$step >dist/$step.mjs
done
