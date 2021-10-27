# CMakeList.txt : CMake project for cmake-project
cmake_minimum_required (VERSION 3.8)

project ("cmake-project")
set(CMAKE_CXX_STANDARD 20)

# Add source to this project's executable.
add_executable (cmake-project "main.cpp")