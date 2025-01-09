-- Fuzzy Finder (files, lsp, etc)
local icons = require("core/icons")

-- local function normalize_path(path)
--   return path:gsub("\\", "/")
-- end
--
-- local function normalize_cwd()
--   return normalize_path(vim.loop.cwd()) .. "/"
-- end
--
-- local function is_subdirectory(cwd, path)
--   return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
-- end
--
-- local function split_filepath(path)
--   local normalized_path = normalize_path(path)
--   local normalized_cwd = normalize_cwd()
--   local filename = normalized_path:match("[^/]+$")
--
--   if is_subdirectory(normalized_cwd, normalized_path) then
--     local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
--     return stripped_path, filename
--   else
--     local stripped_path = normalized_path:sub(1, -(#filename + 1))
--     return stripped_path, filename
--   end
-- end
--
-- local function path_display(_, path)
--   local stripped_path, filename = split_filepath(path)
--   if filename == stripped_path or stripped_path == "" then
--     return filename
--   end
--   return string.format("%s ~ %s", filename, stripped_path)
-- end

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",

    -- Useful for getting pretty icons, but requires a Nerd Font.
    "nvim-tree/nvim-web-devicons",
    "nvim-telescope/telescope-symbols.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin")

    require("telescope").setup({
      defaults = {
        -- Full
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --   horizontal = {
        --     prompt_position = "top",
        --     width = { padding = 0 },
        --     height = { padding = 0 },
        --     preview_width = 0.5,
        --   },
        -- },

        -- Center
        layout_config = {
          height = 0.8,
          width = 0.9,
          prompt_position = "top",
          bottom_pane = {
            height = 0.5,
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          center = {
            height = 0.4,
            preview_cutoff = 40,
          },
          cursor = {
            preview_cutoff = 40,
            preview_width = 0.6,
          },
          horizontal = {
            preview_width = 0.6,
            preview_cutoff = 120,
          },
          vertical = {
            preview_cutoff = 40,
          },
        },
        -- path_display = path_display,
        path_display = { "absolute" },
        sorting_strategy = "ascending",
        prompt_prefix = icons.ui.Telescope .. icons.ui.ChevronRight .. " ",
        selection_caret = icons.ui.Play,
        multi_icon = icons.ui.Check,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-p>"] = actions.cycle_history_prev,

            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<C-l>"] = actions.complete_tag,
          },
          n = {
            ["q"] = actions.close,
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      },
      pickers = {
        find_files = {
          file_ignore_patterns = { "node_modules", ".git", ".venv" },
          hidden = true,
        },
        buffers = {
          initial_mode = "normal",
          sort_lastused = true,
          -- sort_mru = true,
          mappings = {
            n = {
              ["d"] = actions.delete_buffer,
              ["l"] = actions.select_default,
            },
          },
        },
      },
      live_grep = {
        file_ignore_patterns = { "node_modules", ".git", ".venv" },
        additional_args = function(_)
          return { "--hidden" }
        end,
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
      git_files = {
        previewer = false,
      },
    })

    -- Enable telescope fzf native, if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent [f]iles" })
    -- vim.keymap.set("n", "<leader>sm", builtin.marks, { desc = "[S]earch [M]arks" })
    -- vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search [G]it [F]iles" })
    -- vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Search [G]it [C]ommits" })
    -- vim.keymap.set("n", "<leader>gcf", builtin.git_bcommits, { desc = "Search [G]it [C]ommits for current [F]ile" })
    -- vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Search [G]it [B]ranches" })
    -- vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Search [G]it [S]tatus (diff view)" })
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find file in project" })
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find [f]ile in project" })
    vim.keymap.set("n", "<leader>hh", builtin.help_tags, { desc = "[h]elp" })
    vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "Find current [w]ord" })
    vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Search project" })
    vim.keymap.set("n", "<leader>cx", builtin.diagnostics, { desc = "LSP: List errors [x]" })
    -- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]resume" })
    vim.keymap.set("n", "<leader>si", function()
      builtin.lsp_document_symbols({
        symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Property" },
      })
    end, { desc = "Jump to symbol [i]" })
    vim.keymap.set("n", "<leader>bo", function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      })
    end, { desc = "[s]each buffer" })
    vim.keymap.set("n", "<leader>bb", function()
      builtin.buffers(require("telescope.themes").get_dropdown({
        previewer = false,
      }))
    end, { desc = "Switch [b]uffer" })
    vim.keymap.set("n", "<leader>ss", function()
      builtin.current_buffer_fuzzy_find({
        previewer = false,
      })
    end, { desc = "[s]earch buffer" })
  end,
}
