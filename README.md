# Neovim Configuration

This repository contains a modular Neovim configuration built around
[lazy.nvim](https://github.com/folke/lazy.nvim). The active configuration is
loaded from `nvim/lua/moise-dev`; `nvim/init.lua` delegates startup with:

```lua
require("moise-dev")
```

The older `nvim/lua/pygaiwan` tree may still exist in the repository, but it is
not the active entry point.

## Layout

```text
.
|-- README.md
|-- build
|   `-- docker
|       |-- Dockerfile.nvim-base
|       |-- Dockerfile.nvim-builder
|       |-- Dockerfile.nvim-essential
|       `-- Dockerfile.nvim-full
`-- nvim
    |-- init.lua
    |-- lazy-lock.json
    `-- lua
        `-- moise-dev
            |-- init.lua
            |-- lazy_init.lua
            |-- vim_autosave.lua
            |-- vim_keymaps.lua
            |-- vim_options.lua
            `-- lazy
                |-- languages
                |   |-- formatting.lua
                |   |-- lsp.lua
                |   |-- repls.lua
                |   |-- testing.lua
                |   |-- treesitter.lua
                |   |-- vimdev.lua
                |   `-- python
                |       |-- debugger.lua
                |       |-- debugger_ui.lua
                |       `-- venvselect.lua
                |-- ui
                |   |-- colors.lua
                |   |-- key_suggestion.lua
                |   |-- linenumber_toggle.lua
                |   |-- lualine.lua
                |   |-- markdown_renderer.lua
                |   |-- mini_icons.lua
                |   |-- nord.lua
                |   |-- todo_comments.lua
                |   |-- trouble.lua
                |   `-- twilight.lua
                `-- vim_utils
                    |-- cloak.lua
                    |-- csv_rainbow.lua
                    |-- gitdiff.lua
                    |-- harpoon.lua
                    |-- telescope.lua
                    |-- toggler.lua
                    |-- undotree.lua
                    `-- zenmode.lua
```

## Startup

The configuration loads in this order:

1. `moise-dev.vim_autosave`: enables a toggleable autosave command.
2. `moise-dev.vim_options`: applies editor defaults.
3. `moise-dev.vim_keymaps`: defines global mappings and filetype additions.
4. `moise-dev.lazy_init`: bootstraps `lazy.nvim` and imports plugin modules.

`lazy_init.lua` imports four plugin groups:

- `moise-dev.lazy.ui`
- `moise-dev.lazy.vim_utils`
- `moise-dev.lazy.languages`
- `moise-dev.lazy.languages.python`

## Core Behavior

- Leader key: space.
- Autosave is enabled by default and can be controlled with `:AutoSave on`,
  `:AutoSave off`, or `:AutoSave toggle`.
- Formatting runs on save through Conform with LSP fallback.
- Diagnostics can be opened inline, navigated with `[d` and `]d`, or sent to
  the location list.
- `mdx` files are treated as Markdown.
- Project-specific Astro authoring snippets are available under `<leader>m`.

## Plugins

### Plugin Management

- [lazy.nvim](https://github.com/folke/lazy.nvim): plugin manager.
- [mason.nvim](https://github.com/williamboman/mason.nvim): external LSP and
  DAP tooling management.
- [mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim):
  bridge between Mason and `nvim-lspconfig`.

### UI

- [nord.nvim](https://github.com/shaunsingh/nord.nvim): color scheme.
- [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): status line.
- [which-key.nvim](https://github.com/folke/which-key.nvim): keybinding hints.
- [todo-comments.nvim](https://github.com/folke/todo-comments.nvim): TODO-style
  comment highlighting and navigation.
- [trouble.nvim](https://github.com/folke/trouble.nvim): diagnostics, symbols,
  references, and quickfix views.
- [twilight.nvim](https://github.com/folke/twilight.nvim): focused editing.
- [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):
  Markdown rendering.
- [nvim-colorizer.lua](https://github.com/catgoose/nvim-colorizer.lua): inline
  color previews.
- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons): icon
  support for UI integrations.

### Vim Utilities

- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim): fuzzy
  finding for files, buffers, diagnostics, keymaps, and LSP results.
- [harpoon](https://github.com/ThePrimeagen/harpoon): quick project file marks.
- [diffview.nvim](https://github.com/sindrets/diffview.nvim): Git diff views.
- [undotree](https://github.com/mbbill/undotree): undo history browser.
- [zen-mode.nvim](https://github.com/folke/zen-mode.nvim): distraction-free
  editing.
- [cloak.nvim](https://github.com/laytan/cloak.nvim): hides configured secret
  values.
- [rainbow_csv.nvim](https://github.com/cameron-wags/rainbow_csv.nvim): CSV
  highlighting.
- [nvim-toggler](https://github.com/nguyenvukhang/nvim-toggler): toggles common
  word pairs.

### Languages

- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): LSP setup.
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): completion engine.
- [cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp): LSP completion
  capabilities.
- [conform.nvim](https://github.com/stevearc/conform.nvim): formatters and
  format-on-save.
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):
  language parsers and syntax highlighting.
- [neotest](https://github.com/nvim-neotest/neotest): test runner framework.
- [neotest-python](https://github.com/nvim-neotest/neotest-python): pytest
  adapter.
- [neotest-jest](https://github.com/nvim-neotest/neotest-jest): Jest adapter.
- [lazydev.nvim](https://github.com/folke/lazydev.nvim): Lua development
  helpers for Neovim configuration work.
- [nvim-repl](https://github.com/moise-dev/nvim-repl): LSP-aware REPL launcher.

### Python

- [nvim-dap](https://github.com/mfussenegger/nvim-dap): debug adapter support.
- [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui): debugger UI.
- [venv-selector.nvim](https://github.com/linux-cultist/venv-selector.nvim):
  virtual environment selection.

## Language Tooling

Mason installs these LSP servers:

- `clangd`
- `lua_ls`
- `pyright`
- `ts_ls`
- `biome`
- `gopls`
- `astro`
- `typos_lsp`
- `ruff`

Treesitter installs parsers for Astro, Assembly, Bash, C, Diff, HTML,
JavaScript, JSDoc, JSON, JSONC, Lua, LuaDoc, Lua patterns, Markdown, Python,
TOML, TSX, TypeScript, Vim, and Vimdoc.

Conform formatters are configured as follows:

- `biome`: Astro, CSS, HTML, JavaScript, JSX, JSON, Svelte, TypeScript, TSX,
  and YAML.
- `stylua`: Lua.
- `ruff`: Python.

## Common Keymaps

- `<leader>fe`: open the file explorer.
- `<leader>cf`: format the current buffer or selection.
- `<leader>as`: toggle autosave.
- `<leader>sh`: search help with Telescope.
- `<leader>sf`: search files with Telescope.
- `<leader>sg`: live grep with Telescope.
- `<leader>sG`: search Git-tracked files with Telescope.
- `<leader>sd`: search diagnostics with Telescope.
- `<leader>a`: add the current file to Harpoon.
- `<C-e>`: open the Harpoon quick menu.
- `<leader>1` through `<leader>5`: jump to Harpoon entries.
- `<leader>rr`: open a REPL for the current LSP context.
- `<leader>tr`: run the nearest test.
- `<leader>tR`: run all tests in the current file.
- `<leader>td`: debug the nearest test.
- `<leader>ts`: toggle the Neotest summary.
- `<leader>ti`: open detailed Neotest output.

LSP mappings are registered per buffer on `LspAttach`:

- `gd`: go to definition.
- `gD`: go to declaration.
- `K`: hover documentation.
- `<leader>la`: code action.
- `<leader>li`: go to implementation.
- `<leader>lr`: find references.
- `<leader>lt`: go to type definition.
- `<leader>ln`: rename symbol.

## Installing Locally

Clone this repository and point Neovim at the `nvim` directory:

```sh
git clone https://github.com/moise-dev/neovim.git
mkdir -p ~/.config
cp -r neovim/nvim ~/.config/nvim
nvim
```

On first launch, `lazy.nvim` is bootstrapped automatically. Run `:Lazy sync` if
you want to force plugin installation, and `:Mason` to inspect managed language
tools.

## Adding Language Support

1. Add the parser to `ensure_installed` in `languages/treesitter.lua`.
2. Add the language server to `ENSURE_INSTALLED` in `languages/lsp.lua`.
3. Add a custom LSP handler in `languages/lsp.lua` if the server needs
   non-default settings.
4. Add formatters to `formatters_by_ft` in `languages/formatting.lua`.
5. Add a Neotest adapter in `languages/testing.lua` if test integration is
   available.
6. Add language-specific plugins under `languages/<language>` when the setup
   needs dedicated modules, then import that module group in `lazy_init.lua`.

## Docker

Dockerfiles live under `build/docker`:

- `Dockerfile.nvim-builder`: build dependencies for compiling Neovim.
- `Dockerfile.nvim-base`: builds and installs Neovim 0.12 on Alpine by
  default.
- `Dockerfile.nvim-full`: copies the full configuration and syncs plugins.
- `Dockerfile.nvim-essential`: intended for a reduced plugin set.
