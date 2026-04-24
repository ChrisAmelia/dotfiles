if vim.g.markdown_loaded then
  return
end

vim.g.markdown_loaded = true

-- Rendermarkdown {{{

autocmd("BufEnter", {
  once = true,
  pattern = { "*.md" },
  callback = function()
    vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })

    require('render-markdown').setup({
      checkbox = {
        enabled = true,
        render_modes = false,
        right_pad = 1,
        unchecked = {
          icon = '󰄱 ',
          highlight = 'RenderMarkdownUnchecked',
          scope_highlight = nil,
        },
        checked = {
          icon = '󰱒 ',
          highlight = 'RenderMarkdownChecked',
          scope_highlight = nil,
        },
        custom = {
          todo = { raw = '[-]', rendered = '󰥔 ', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
        },
      },
    })

    vim.api.nvim_command("RenderMarkdown disable")
  end
})

-- }}}
