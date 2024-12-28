local handler = function(virtText, lnum, endLnum, width, truncate)
  local newVirtText = {}
  local foldedLines = endLnum - lnum
  local suffix = (" 󰁂  %d"):format(foldedLines)
  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0

  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end
  local rAlignAppndx = math.max(math.min(vim.opt.textwidth["_value"], width - 1) - curWidth - sufWidth, 0)
  suffix = (" "):rep(rAlignAppndx) .. suffix
  table.insert(newVirtText, { suffix, "MoreMsg" })
  return newVirtText
end

require("ufo").setup {
  fold_virt_text_handler = handler,
}

vim.keymap.set("n", "<leader>zo", function()
  local _ = require("ufo").openAllFolds()
end, {
  desc = "Open all",
})

vim.keymap.set("n", "<leader>zc", function()
  local _ = require("ufo").closeAllFolds()
end, {
  desc = "Close all",
})

vim.keymap.set("n", "<leader>ze", function()
  local _ = require("ufo").openFoldsExceptKinds()
end, {
  desc = "Except kinds",
})

vim.keymap.set("n", "<leader>zp", function()
  local _ = require("ufo").peekFoldedLinesUnderCursor()
end, {
  desc = "Preview",
})
