return {
  {
    "oil.nvim",
    before = function(_)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    after = function(_)
      require("oil").setup({
        default_file_explorer = true,

        view_options = {
          show_hidden = true,
        },

        columns = {
          "icon",
          "permissions",
          "size",
          -- "mtime",
        },

        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
      })

      -- Keybindings
      vim.keymap.set(
        "n",
        "-",
        "<cmd>Oil<CR>",
        { noremap = true, desc = "Open parent directory" }
      )

      vim.keymap.set(
        "n",
        "<leader>-",
        "<cmd>Oil .<CR>",
        { noremap = true, desc = "Open Neovim root directory" }
      )
    end,
  },
}
