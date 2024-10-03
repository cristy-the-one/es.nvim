# es.nvim

A Neovim plugin that integrates the `es.exe` command-line tool from [Voidtools Everything Search](https://www.voidtools.com/) with [`fzf-lua`](https://github.com/ibhagwan/fzf-lua) and [`neo-tree.nvim`](https://github.com/nvim-neo-tree/neo-tree.nvim). This plugin allows you to search and open files or directories across your entire system directly from Neovim.

## Features

- **Global File and Directory Search**: Utilize the powerful `es.exe` CLI to perform fast searches across your entire system.
- **Fuzzy Finder Integration**: Presents search results using `fzf-lua` for intuitive fuzzy finding.
- **File Explorer Integration**: Opens directories using `neo-tree.nvim`, a modern and highly customizable file explorer.
- **Seamless Workflow**: Quickly navigate and access files or directories without leaving the Neovim environment.
- **Compatibility**: Designed to work smoothly with [LazyVim](https://www.lazyvim.org/) and [Noice](https://github.com/folke/noice.nvim) for enhanced Neovim experiences.

## Prerequisites

- **Neovim 0.7 or higher**
- **[es.exe](https://www.voidtools.com/support/everything/command_line_interface/)**: Ensure it's installed and added to your system's PATH.
- **[fzf-lua](https://github.com/ibhagwan/fzf-lua)**: A Lua-based fuzzy finder for Neovim.
- **[neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)**: A modern file explorer for Neovim written in Lua.
- **[plenary.nvim](https://github.com/nvim-lua/plenary.nvim)**: Utility functions required by many Neovim plugins.
- **[nui.nvim](https://github.com/MunifTanjim/nui.nvim)**: UI component library for Neovim.
- **[nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)** (Optional): For file icons in `neo-tree.nvim`.

## Installation

### Using `lazy.nvim` Plugin Manager

Add the following to your `plugins.lua` or equivalent configuration file:

```lua
return {
  -- Other plugins
  {
    'cristy-the-one/es.nvim',
    dependencies = {
      'ibhagwan/fzf-lua',
      'nvim-neo-tree/neo-tree.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- Optional, for file icons
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('es').setup()
    end,
  },
}
```

### Install Dependencies

Ensure that `fzf-lua` and `neo-tree.nvim` are installed along with their dependencies as listed above.

## Configuration

You can configure `neo-tree.nvim` and `fzf-lua` according to your preferences.

**Example Neo-tree Configuration:**

```lua
-- neo-tree setup
require('neo-tree').setup({
  filesystem = {
    follow_current_file = true, -- Focus on the current file
    use_libuv_file_watcher = true, -- Auto-refresh when files change
  },
})
```

**Example fzf-lua Configuration (Optional):**

```lua
-- fzf-lua setup
require('fzf-lua').setup({
  -- Customize fzf-lua options here
})
```

## Usage

- **Command**: Run `:EsSearch` in Neovim to trigger the search prompt.
- **Key Mapping (Optional)**: Set up a custom key binding in your Neovim configuration:

  ```lua
  vim.keymap.set("n", "<leader>se", "<cmd>EsSearch<CR>", { noremap = true, silent = true, desc = "Search Everything" })
  ```

### Search and Open Files or Directories

1. **Initiate Search**: Use the command `:EsSearch` or your custom key mapping.
2. **Enter Query**: Input your search term when prompted.
3. **Browse Results**: `fzf-lua` will display matching files and directories.
4. **Select an Item**:
   - **File**: Opens the file in the current buffer.
   - **Directory**: Opens the directory in `neo-tree.nvim` for browsing.

## How It Works

- **Search Prompt**: The plugin uses `vim.ui.input` to prompt for a search query.
- **Executing Search**: Runs `es.exe` with your query to retrieve matching files and directories.
- **Displaying Results**: Uses `fzf-lua` to present search results in a fuzzy finder interface.
- **Opening Selection**:
  - **Files**: Opened directly in the current Neovim buffer.
  - **Directories**: Opened in `neo-tree.nvim` for an enhanced file browsing experience.

## Dependencies

- **es.exe**: The Everything Search CLI tool.
  - **Installation**:
    - Download from the [official website](https://www.voidtools.com/downloads/).
    - Add `es.exe` to your system's PATH environment variable.
- **fzf-lua**: Fuzzy finder for Neovim.
- **neo-tree.nvim**: File explorer for Neovim.
- **plenary.nvim**: Utility functions required by `neo-tree.nvim`.
- **nui.nvim**: UI components for Neovim, required by `neo-tree.nvim`.
- **nvim-web-devicons** (Optional): Provides file icons.

## Compatibility

- **LazyVim**: Fully compatible; uses standard Neovim APIs and Lua-based plugins.
- **Noice**: Interactions via `vim.ui.input` and `fzf-lua` are enhanced by Noice automatically.

## Customization

### Adjusting fzf-lua Options

Customize `fzf-lua` within the `fzf_exec` function to modify behavior such as keybindings, layout, and preview windows.

**Example:**

```lua
require('fzf-lua').fzf_exec(output, {
  prompt = 'Everything Search> ',
  actions = {
    -- Define custom actions here
  },
  -- Additional options
  winopts = {
    height = 0.5,
    width = 0.9,
  },
})
```

### Modifying neo-tree Settings

Adjust `neo-tree.nvim` settings to change appearance and functionality.

**Example:**

```lua
require('neo-tree').setup({
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 1,
    },
    icon = {
      folder_closed = "📁",
      folder_open = "📂",
    },
  },
  window = {
    position = "left",
    width = 30,
  },
})
```

## Troubleshooting

- **"No results found" Error**: Ensure your search query is correct and that `es.exe` is functioning properly.
- **es.exe Not Recognized**: Confirm that `es.exe` is installed and added to your system's PATH.
- **Plugin Errors**: Check that all dependencies are installed and up-to-date.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request on the [GitHub repository](https://github.com/cristy-the-one/es.nvim).

## License

This project is licensed under the [MIT License](LICENSE).
