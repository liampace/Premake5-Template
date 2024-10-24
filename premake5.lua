include ".premake/project.lua"

if not pcall(workspace) then 
	function filter_block(names, func)
		filter(names)
		func()
		filter({})
	end

	include ".premake/workspace.lua"
	workspace "Workspace"
		configurations {"Test", "Development", "Profile", "Release"}
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

	filter_block("configurations:Test", function() 
		kind "SharedLib"
		files "tests/**.cpp"
		undefines "NDEBUG"
		runtime "Debug"
		optimize "Off"
	end)
	filter_block("configurations:Development", function() 
		undefines "NDEBUG"
		runtime "Debug"
		optimize "Off"
	end)
	filter_block("configurations:Profile", function() 
		defines "NDEBUG"
		runtime "Release"
		optimize "Off"
	end)
	filter_block("configurations:Release", function() 
		defines "NDEBUG"
		runtime "Release"
		optimize "On"
	end)