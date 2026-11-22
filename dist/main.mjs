process.argv.push(new URL("action.mjs", import.meta.url).pathname, "main")
await import("./host.mjs")
