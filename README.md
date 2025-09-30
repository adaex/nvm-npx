# nvm-npx

> Tiny shell wrapper around `nvm exec <version> npx …`. Pure Bash, zero runtime dependencies.

📚 Looking for the Chinese guide? See [README.zh-CN.md](./README.zh-CN.md).

## Features

- First argument picks the Node.js version; everything else is passed straight to `npx`.
- Pure shell implementation, perfect for automation or MCP configurations that run before Node is available.
- Understands symlinks such as `nvm-npx-22`, treating the suffix as the default version.
- Optional `--nvm-dir` flag lets you override the nvm installation path.

## Quick start

### Run once

```bash
npx nvm-npx@latest 22 -y chrome-devtools-mcp@latest
```

### Install globally

```bash
npm install -g nvm-npx
nvm-npx 20 -y chrome-devtools-mcp@latest
```

### MCP `mcpServers` snippet

```json
{
  "mcpServers": {
    "chrome-devtools": {
      "command": "nvm-npx",
      "args": ["22", "-y", "chrome-devtools-mcp@latest"]
    }
  }
}
```

Make sure `nvm-npx` is on your `PATH` (for example by installing it globally or symlinking the binary).

## Usage

```bash
nvm-npx [options] <node version> [npx arguments...]
```

If you invoke the binary through a name like `nvm-npx-18`, the trailing `-18` is used as the default version and the `<node version>` parameter becomes optional.

### Options

| Option             | Description                                                         |
| ------------------ | ------------------------------------------------------------------- |
| `-h, --help`       | Show usage information                                              |
| `-V, --version`    | Print the current `nvm-npx` version                                 |
| `--nvm-dir <path>` | Point to your nvm installation (defaults to `$NVM_DIR` or `~/.nvm`) |
| `--`               | Stop parsing flags; the rest is forwarded to `npx` verbatim         |

## How it works

1. Resolve the desired Node.js version from the arguments or the executable name.
2. Load `nvm.sh` (preferring `--nvm-dir`, otherwise `$NVM_DIR`, falling back to `~/.nvm`).
3. Delegate to `nvm exec <version> npx …`.

## Examples

```bash
# Bootstrap chrome-devtools MCP with Node 22
nvm-npx 22 -y chrome-devtools-mcp@latest

# Use a custom nvm directory
nvm-npx --nvm-dir /opt/nvm 18 create-vite@latest my-app -- --template react

# Skip the version argument via a symlink
ln -s $(which nvm-npx) ~/.local/bin/nvm-npx-lts
nvm-npx-lts -y typescript@latest -- --init
```

## Troubleshooting

### `nvm.sh` not found

Example error message:

```text
nvm-npx: nvm.sh not found at /Users/you/.nvm/nvm.sh
```

Double-check that:

1. nvm is installed on the machine.
2. `nvm.sh` exists under the directory reported by `$NVM_DIR` (or `~/.nvm`).
3. If you use a custom location, pass it via `--nvm-dir`.

## License

MIT
