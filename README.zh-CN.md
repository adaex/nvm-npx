# nvm-npx

> 轻量级 Shell 封装，让你用一行命令执行 `nvm exec <版本> npx …`，无需额外依赖。

📘 若需要英文说明，请查看 [README.md](./README.md)。

## ✨ 特性亮点

- 第一个参数指定 Node.js 版本，其余参数原样传给 `npx`。
- 纯 Bash 实现，在自动化或 MCP 等前置步骤里也能运行。
- 支持 `nvm-npx-22` 这类带版本后缀的符号链接或别名。
- 通过 `--nvm-dir` 自定义 nvm 安装路径。

## 🚀 快速开始

### 临时使用

```bash
npx nvm-npx@latest 22 -y chrome-devtools-mcp@latest
```

### 全局安装

```bash
npm install -g nvm-npx
nvm-npx 20 -y chrome-devtools-mcp@latest
```

### MCP `mcpServers` 配置示例

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

请确保 `nvm-npx` 已在 PATH 中（例如全局安装或创建到 PATH 目录的符号链接）。

## 🛠️ 使用方式

```bash
nvm-npx [选项] <Node版本> [npx 参数...]
```

如果通过 `nvm-npx-18` 这类名称调用，可省略 `<Node版本>` 参数，程序会自动解析 `-18` 部分。

### 常用选项

| 选项               | 说明                                                 |
| ------------------ | ---------------------------------------------------- |
| `-h, --help`       | 显示帮助信息                                         |
| `-V, --version`    | 输出当前 `nvm-npx` 版本                              |
| `--nvm-dir <路径>` | 指定 nvm 安装位置（默认读取 `$NVM_DIR` 或 `~/.nvm`） |
| `--`               | 停止解析选项，后续参数全部传给 `npx`                 |

## ⚙️ 工作原理

1. 从参数或可执行文件名解析目标 Node.js 版本。
2. 按优先级 `--nvm-dir` → `$NVM_DIR` → `~/.nvm` 查找并加载 `nvm.sh`。
3. 调用 `nvm exec <版本> npx …` 完成执行。

## 💡 示例

```bash
# 在 Node 22 环境下安装 chrome-devtools MCP
nvm-npx 22 -y chrome-devtools-mcp@latest

# 指定自定义的 nvm 安装目录
nvm-npx --nvm-dir /opt/nvm 18 create-vite@latest my-app -- --template react

# 借助符号链接省略版本参数
ln -s $(which nvm-npx) ~/.local/bin/nvm-npx-lts
nvm-npx-lts -y typescript@latest -- --init
```

## ❗ 常见问题

### 提示找不到 `nvm.sh`

示例输出：

```text
nvm-npx: nvm.sh not found at /Users/you/.nvm/nvm.sh
```

请检查：

1. 机器上已正确安装 nvm。
2. `nvm.sh` 位于 `$NVM_DIR`（默认 `~/.nvm`）目录下。
3. 如果使用了自定义路径，请通过 `--nvm-dir` 明确指定。

## 📄 许可证

MIT
