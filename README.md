# Premake5-Template
A template project for Premake5

## File Structure
```
.premake/       Premake Configuration Scripts
|-----project.lua          Set project name, kind, C++ version, and dependency information here
|-----workspace.lua        Set supported platforms and project configurations here
|
build/          Project build files are generated here
|-----/bin                 Project binaries are generated here
|-----/bin-int             Project intermediates are generated here
|
doc/            Documentation for your project goes heres
|
lib/            Dependencies and Submodules go here
|
include/        Header (.h) files go here
|-----<ProjectName>/         Platform independent code goes here
|-----platform/            Platform dependent code goes here
|
src/            Source (.cpp) files go here
|-----<ProjectName>/       Platform independent code goes here
|-----platform/            Platform dependent code goes here
|
premake5.lua    Main Premake Script
|
README.md       Change this to match the needs of your project
```
## Prerequsites
You will need to have premake5 installed on your system.
You will need a project generation system like Visual Studio, GNU Make, Xcode, or CodeLite.

## Additional Info
Currently this repo has only been tested on Windows 10. 
Theoretically it should work on both Linux and MacOSX. 
If you experience any bugs or wish to provide feed back let me know.