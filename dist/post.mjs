process.argv.push(new URL("action.mjs", import.meta.url).pathname, "post")
await import("./host.mjs")
