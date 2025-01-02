local telescope = require('telescope')
local actions = require('telescope.actions')
local icons = require('config/icons')

local function normalize_path(path)
  return path:gsub("\\", "/")
end

local function normalize_cwd()
  return normalize_path(vim.loop.cwd()) .. "/"
end

local function is_subdirectory(cwd, path)
  return string.lower(path:sub(1, #cwd)) == string.lower(cwd)
end

local function split_filepath(path)
  local normalized_path = normalize_path(path)
  local normalized_cwd = normalize_cwd()
  local filename = normalized_path:match("[^/]+$")

  if is_subdirectory(normalized_cwd, normalized_path) then
    local stripped_path = normalized_path:sub(#normalized_cwd + 1, -(#filename + 1))
    return stripped_path, filename
  else
    local stripped_path = normalized_path:sub(1, -(#filename + 1))
    return stripped_path, filename
  end
end

local function path_display(_, path)
  local stripped_path, filename = split_filepath(path)
  if filename == stripped_path or stripped_path == "" then
    return filename
  end
  return string.format("%s ~ %s", filename, stripped_path)
end

local function flash(prompt_bufnr)
    require('flash').jump({
        pattern = '^',
        label = { after = { 0, 0 } },
        search = {
            mode = 'search',
            exclude = {
                function(win)
                    return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
                end,
            },
        },
        action = function(match)
            local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
            picker:set_selection(match.pos[1] - 1)
        end,
    })
end

telescope.setup({
    defaults = {
        layout_config = {
            height = 0.8,
            width = 0.9,
            prompt_position = 'top',
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
        prompt_prefix = icons.ui.Telescope .. icons.ui.ChevronRight .. " ",
        selection_caret = icons.ui.Play,
        multi_icon = icons.ui.Check,
        -- path_display = path_display,
        path_display = { 'absolute' },
        sorting_strategy = 'ascending',

        mappings = {
            i = {
                ['<esc>'] = actions.close,
                ['<C-n>'] = actions.cycle_history_next,
                ['<C-p>'] = actions.cycle_history_prev,

                ['<C-j>'] = actions.move_selection_next,
                ['<C-k>'] = actions.move_selection_previous,

                ['<C-c>'] = actions.close,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>'] = actions.move_selection_previous,

                ['<CR>'] = actions.select_default,
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,
                ['<C-s>'] = flash,

                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-d>'] = actions.preview_scrolling_down,

                ['<PageUp>'] = actions.results_scrolling_up,
                ['<PageDown>'] = actions.results_scrolling_down,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                ['<C-l>'] = actions.complete_tag,
            },

            n = {
                ['q'] = actions.close,
                ['<esc>'] = actions.close,
                ['<CR>'] = actions.select_default,
                ['<C-x>'] = actions.select_horizontal,
                ['<C-v>'] = actions.select_vertical,
                ['<C-t>'] = actions.select_tab,
                ['s'] = flash,

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

                ['j'] = actions.move_selection_next,
                ['k'] = actions.move_selection_previous,
                ['H'] = actions.move_to_top,
                ['M'] = actions.move_to_middle,
                ['L'] = actions.move_to_bottom,

                ['<Down>'] = actions.move_selection_next,
                ['<Up>'] = actions.move_selection_previous,
                ['gg'] = actions.move_to_top,
                ['G'] = actions.move_to_bottom,

                ['<C-u>'] = actions.preview_scrolling_up,
                ['<C-d>'] = actions.preview_scrolling_down,

                ['<PageUp>'] = actions.results_scrolling_up,
                ['<PageDown>'] = actions.results_scrolling_down,

                ['?'] = actions.which_key,
            },
        },
    },
    pickers = {
        find_files = { mappings = multi_open_mappings },
        git_files = { mappings = multi_open_mappings },
        oldfiles = { mappings = multi_open_mappings },
    },
})
