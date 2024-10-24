workspace "Workspace"
	configurations {"Test", "Development", "Profile", "Release"}
	architecture "x86_64"
	system "windows"
	systemversion "latest"
	startproject "Demo"

BUILD_DIR = "%{prj.location}/build/"
OUTPUT_DIR = "%{cfg.buildcfg}/%{cfg.system}-%{cfg.architecture}/"

project "Demo"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++11"
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