local load = function(mod)
	package.loaded[mod] = nil
	require(mod)
end

load("sam.options")
load("sam.keymaps")
load("sam.commands")
require("sam.plugins")
