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
| `<Space>ct` | Normal | **Telescope Theme Picker** (Live preview and select installed themes) |
| `Shift + h` | Normal | **Previous Tab (Buffer)** |
| `Shift + l` | Normal | **Next Tab (Buffer)** |
| `<Space>c` | Normal | **Close Current Tab (Buffer)** |

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

### Autocompletion (Insert Mode)
When typing code, the autocomplete menu will appear automatically. Use these keys to interact with it:
* `<Tab>` : Select the next suggestion or expand a snippet.
* `<Shift + Tab>` : Select the previous suggestion.
* `<Enter>` : Confirm and insert the currently selected suggestion.
* `Ctrl + Space` : Manually trigger the autocomplete menu if it was closed.
* `Ctrl + e` : Close/Abort the autocomplete menu.

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
Neovim can handle multiple files simultaneously using **splits** and **terminals**. 

**1. Using the Neo-tree Sidebar:**
When hovering over a file in Neo-tree:
* Press `v` to open it in a **Vertical Split**.
* Press `s` to open it in a **Horizontal Split**.

**2. Using Telescope (`<Space>s` or `<Space>fg`):**
When selecting a file in the search results:
* Press `Ctrl + v` to open it in a **Vertical Split**.
* Press `Ctrl + x` to open it in a **Horizontal Split**.

**3. Using Command Mode:**
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

### Multi-line Commenting & Uncommenting

Neovim has built-in language-aware commenting (`gc`), which automatically knows which comment symbols to use for each language (`#` for Python/Bash, `//` for C/JS/Rust/Go, `--` for Lua, `<!-- -->` for HTML).

#### The Fastest Way (Visual Selection):
1. Press `V` (Shift + v) in Normal Mode to enter **Visual Line Mode**.
2. Use `j` and `k` to select the lines you want to comment or uncomment.
3. Press `gc`:
   * If the lines are uncommented, it **comments** all of them.
   * If the lines are already commented, it **uncomments** all of them!

#### From Normal Mode:
* `gcc` : Toggle comment/uncomment for the current line.
* `gc3j` : Comment/uncomment current line plus 3 lines down (4 lines total).
* `gcap` : Comment/uncomment the entire current paragraph/block.
* `gbc` : Toggle a block comment on the current line.

#### Alternative: Visual Block Mode (`<Space>v`)
If you want to manually insert or delete specific characters in a column:
1. Put cursor on the first line and press `<Space>v` to enter Visual Block Mode.
2. Press `j` to highlight down the column.
3. **To Comment**: Press `I` (Shift + i), type your comment prefix (e.g. `# `), then press `<Esc>`.
4. **To Uncomment**: Select the comment characters with `j` and `l`, then press `x` or `d` to delete them.

---

### Tabbing & Untabbing Multiple Lines (Indenting / Outdenting)

You can easily shift indentation of single or multiple lines:

#### 1. In Visual Mode (Multiple Lines at Once)
1. In Normal Mode, press `V` (Shift + v) to enter **Visual Line Mode**.
2. Select lines using `j` (down) and `k` (up).
3. **To Tab (Indent Right)**: Press `>`.
4. **To Untab (Indent Left)**: Press `<`.
> [!TIP]
> Your configuration keeps the visual selection active after pressing `>` or `<`. This allows you to press `>` or `<` repeatedly to tab or untab by multiple levels without having to reselect the lines! Press `<Esc>` when done.

#### 2. In Normal Mode
* `>>` : Tab / indent the current line.
* `<<` : Untab / unindent the current line.
* `>3j` : Tab / indent 4 lines (current line + 3 lines below).
* `<3j` : Untab / unindent 4 lines.
* `.` : Repeat the last indent / untab command on another line.

#### 3. In Insert Mode (While Typing)
* `Ctrl + t` : Tab / indent the current line forward.
* `Ctrl + d` : Untab / unindent the current line backward.

---

### Multi-line Column Editing (Visual Block Mode)
Because Windows terminals often intercept `Ctrl+v` for pasting, you have a custom mapping: press `<Space>v` in Normal Mode to enter **Visual Block Mode**.

**How to Change / Replace Multiple Lines Simultaneously:**
1. Select the block of text you want to replace using `<Space>v` and movement keys (`h, j, k, l`).
2. Press `c` to "change" the text. The selected text will disappear and you will enter Insert mode.
3. Type your new replacement text.
4. Press `<Esc>`. *The change is instantly applied across all selected lines.*

