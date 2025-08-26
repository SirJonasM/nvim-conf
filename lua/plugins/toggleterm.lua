local toggleterm = require("toggleterm")
toggleterm.setup({
  size = 10,
  open_mapping = [[<C- >]],
  shading_factor = 2,
  direction = "float",
  float_opts = {
  border = "curved",
  highlights = {
	  border = "Normal",
	  background = "Normal",
  },
  },
})
