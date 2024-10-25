WKS_SYSTEMS = {
	["windows"] = {"x86", "x86_64"},
	["linus"] = {"ARM", "ARM64"},
	["macosx"] = {"universal"}
}

WKS_CONFIGS = {
	["Development"] = {
		undefines = {"NDEBUG"},
		runtime = "Debug",
		symbols = "On",
		optimize = "Off"
	},
	["Profile"] = {
		undefines = {"NDEBUG"},
		runtime = "Release",
		symbols = "On",
		optimize = "On"
	},
	["Release"] = {
		defines = {"NDEBUG"},
		runtime = "Release",
		symbols = "Off",
		optimize = "On"
	}
}