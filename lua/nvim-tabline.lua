require('tabline').setup{
  enable = true,
  options = {
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    -- section_separators = {'', ''},
    -- component_separators = {'', ''},
    max_bufferline_percent = nil,  -- set to nil by default, and it uses vim.o.columns * 2/3
    show_tabs_always = true,       -- this shows tabs only when there are more than one tab or if the first tab is named
    show_devicons = false,         -- this shows devicons in buffer section
    show_bufnr = false,            -- this appends [bufnr] to buffer section,
    show_filename_only = true,     -- shows base filename only instead of relative path in filename
    show_tabs_only = false,
    modified_italic = false,
  }
}

