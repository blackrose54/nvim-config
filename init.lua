vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/custom/snippets/" }
require "options"
require "nvchad.autocmds"
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "solidity_ls",
    "clangd",
    "tailwindcss",
  },
  automatic_installation = true,
}

require("nvim-tree").setup {
  view = {
    side = "right",
  },
}

require("telescope").setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
    },
  },
}

vim.schedule(function()
  require "mappings"
end)

require("nvim-ts-autotag").setup {
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = true, -- Auto close on trailing </
  },
  per_filetype = {
    ["tsx"] = {
      enable_close = true,
    },
    ["jsx"] = {
      enable_close = true,
    },
  },
}

require("dressing").setup {
  format_item_override = {
    codeaction = function(action_tuple)
      local title = action_tuple[2].title:gsub("\r\n", "\\r\\n")
      local client = vim.lsp.get_client_by_id(action_tuple[1])
      return string.format("%s\t[%s]", title:gsub("\n", "\\n"), client.name)
    end,
  },
}
