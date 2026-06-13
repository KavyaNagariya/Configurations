# Neovim Quick Start & Shortcut Guide 🚀

Welcome to your Neovim configuration! This guide summarizes the core concepts, plugin keymaps, and LSP features that have been set up for you.

---

## 1. Core Editor Concepts

Neovim is a **modal editor**. Understanding modes is key to using it effectively:

| Mode | Purpose | How to enter |
| :--- | :--- | :--- |
| **Normal** | Navigating, editing, and running commands. | Press `<Esc>` (or press `jk` quickly while in Insert mode) |
| **Insert** | Typing code/text directly. | Press `i` (insert at cursor) or `a` (append after cursor) |
| **Visual** | Selecting blocks of text. | Press `v` (character selection) or `V` (line selection) |
| **Command**| Running editor commands. | Press `:` in Normal mode |

### Basic Navigation (Normal Mode)
* `h` / `j` / `k` / `l` : Move Left / Down / Up / Right.
* `w` / `b` : Jump forward / backward by word.
* `0` / `$` : Jump to start / end of the current line.
* `gg` / `G` : Jump to first / last line of the file.

---

## 2. Your Custom Editor Keybindings

These shortcuts have been configured in your [init.lua](file:///C:/repositories/configuration/Neovim/init.lua):

> [!NOTE]
> The **Leader Key** is set to `<Space>` (spacebar).

| Keybinding | Mode | Action |
| :--- | :--- | :--- |
| `jk` | Insert | **Quick Escape** (returns to Normal Mode) |
| `<C-q>` | Normal | **Toggle Neo-tree** (file explorer sidebar) |
| `<C-z>` | Normal | **Focus Neo-tree** |
| `<Space>s` | Normal | **Search Files** (Telescope search by filename) |
| `<Space>fg` | Normal | **Find Grep** (Telescope live search text inside files) |
| `<Space>ct` | Normal | **Cycle Color Themes** (Switches between Catppuccin, Tokyo Night, Dracula, etc.) |

---

## 3. Language Server Protocol (LSP) Shortcuts

LSP provides IDE-like features (code navigation, autocompletion diagnostics, and refactoring). These work automatically for **Python, C, C++, Lua, Rust, TypeScript, JavaScript, Vimscript, Zig, Go, HTML, and CSS**.

Press these in **Normal Mode** with your cursor on a variable, function, or class:

| Keybinding | Action |
| :--- | :--- |
| `gd` | **Go to Definition**: Jump to where the symbol is defined. |
| `K` | **Hover**: Show docstring, type signature, and info in a floating window. |
| `gr` | **Go to References**: List all places where the symbol is used in your project. |
| `<Space>rn` | **Rename**: Rename the symbol project-wide safely. |
| `<Space>ca` | **Code Actions**: List available quick-fixes or refactorings (e.g., auto-import). |

---

## 4. Package & Configuration Management

Manage your plugins and language servers using these commands in Command Mode (press `:`):

### Plugins (Lazy.nvim)
* `:Lazy` : Open the interactive plugin manager UI.
* `:Lazy update` : Update all installed plugins.

### Language Servers & Tools (Mason.nvim)
* `:Mason` : Open the graphical manager to install LSPs, formatters, and linters.
* `:checkhealth vim.lsp` : Verify native Neovim LSP configurations.
* `:checkhealth nvim-treesitter` : Check the status of your syntax highlighting parsers.

---

## 5. Advanced Editing & Window Management

### Opening Multiple Files & Terminals
Neovim can handle multiple files simultaneously using **splits** and **terminals**. Use Command Mode (`:`):

| Action | Command |
| :--- | :--- |
| **Open a new file** | `:e filename` |
| **Split Vertically** | `:vsplit filename` (or just `:vs`) |
| **Split Horizontally** | `:split filename` (or just `:sp`) |
| **Open a Terminal** | `:vsplit \| term` (or `:split \| term`) |

### Switching Between Panes (Focusing / Hovering)
Once you have multiple windows (splits or terminals) open side-by-side, you can jump between them easily:
* Press `<C-w>` (Ctrl + w) followed by a direction key:
  * `<C-w> h` : Move to the Left pane
  * `<C-w> j` : Move to the Bottom pane
  * `<C-w> k` : Move to the Top pane
  * `<C-w> l` : Move to the Right pane

### Multi-line Commenting & Editing (Visual Block Mode)
Because Windows terminals often intercept `Ctrl+v` for pasting, you have a custom mapping: press `<Space>v` in Normal Mode to enter **Visual Block Mode**.

**How to Multi-line Comment:**
1. Put your cursor on the first line you want to comment (ensure you are in Normal mode).
2. Press `<Space>v` to enter Visual Block Mode.
3. Press `j` to select downwards across the lines you want to comment.
4. Press `I` (Shift + i) to enter Insert mode at the beginning of the block.
5. Type your comment character (e.g., `# ` or `// `).
6. Press `<Esc>`. *Neovim will magically apply the comment to all selected lines!*

**How to Change Multiple Lines Simultaneously:**
1. Select the block of text you want to replace using `<Space>v` and movement keys (`h, j, k, l`).
2. Press `c` to "change" the text. The selected text will disappear and you will enter Insert mode.
3. Type your new replacement text.
4. Press `<Esc>`. *The change is instantly applied to all lines.*
