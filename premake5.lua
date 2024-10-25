include ".premake/project.lua"

if not pcall(workspace) then 
	function filter_block(names, func)
		filter(names)
		func()
		filter({})
	end
	function get_table_value(table, key, default)
		return iif(iif(table ~= nil, table, {})[key] ~= nil, table[key], default)
	end

	include ".premake/workspace.lua"
	workspace "Workspace"
		configurations(table.keys(WKS_CONFIGS))
		for os, arches in pairs(WKS_SYSTEMS) do
			filter_block("system:"..os, function() platforms(arches) end)
			for _, arch in ipairs(arches) do
				filter_block({"system:"..os, "platforms:"..arch}, function() architecture(arch) end)
			end
		end
		systemversion "latest"
		startproject(PRJ_NAME)

	BUILD_DIR = "%{prj.location}/build/"
	OUTPUT_DIR = "%{cfg.buildcfg}/%{cfg.system}-%{cfg.architecture}/"
end

project(PRJ_NAME)
	kind(PRJ_KIND)
	language "C++"
	cppdialect(PRJ_DIALECT)
	targetdir(BUILD_DIR.."bin/"..OUTPUT_DIR)
	objdir(BUILD_DIR.."bin-int/"..OUTPUT_DIR)
	files {"src/**.cpp", "include/**.h"}
	includedirs "include"

	for name, cfg in pairs(WKS_CONFIGS) do
		filter_block("configurations:"..name, function() 
			defines(get_table_value(cfg, "defines", {}))
			undefines(get_table_value(cfg, "undefines", {}))
			runtime(cfg.runtime)
			symbols(cfg.symbols)
			optimize(cfg.optimize)
		end)
	end