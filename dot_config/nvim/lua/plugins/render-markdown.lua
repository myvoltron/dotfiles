return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      heading = {
        width = "block",
        left_pad = 1,
        right_pad = 1,
        border = true,
      },
      code = {
        style = "full",
        width = "block",
        border = "thick",
      },
      bullet = {
        icons = { '◆', '•', '○', '▪' },
      },
      checkbox = {
        checked = { icon = '✔ ', highlight = 'RenderMarkdownSuccess' },
        unchecked = { icon = '✘ ', highlight = 'RenderMarkdownError' },
      },
    },
  },
}
