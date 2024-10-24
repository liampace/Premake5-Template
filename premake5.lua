include ".premake/project.lua"

if not pcall(workspace) then 
	include ".premake/platforms.lua"
	workspace "Workspace"
		configurations {"Test", "Development", "Profile", "Release"}
		for os, arches in pairs(PLT_SYSTEMS) do
			filter("system:"..os)
				platforms(arches)
				for _, arch in ipairs(arches) do
					filter {"system:"..os, "platforms:"..arch}
						architecture(arch)
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

	filter "configurations:Test" 
		kind "SharedLib"
		files "tests/**.cpp"
		undefines "NDEBUG"
		runtime "Debug"
		optimize "Off"

	filter "configurations:Development"
		undefines "NDEBUG"
		runtime "Debug"
		optimize "Off"
	
	filter "configurations:Profile"
		defines "NDEBUG"
		runtime "Release"
		optimize "Off"

	filter "configurations:Release"
		defines "NDEBUG"
		runtime "Release"
		optimize "On"