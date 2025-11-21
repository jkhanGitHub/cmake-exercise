cmake_minimum_required(VERSION 3.16)
project(cmake_exercise CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find Boost
find_package(Boost REQUIRED COMPONENTS filesystem system container)

# Find deal.II
find_package(deal.II REQUIRED)
deal_ii_initialize_cached_variables()

# Find yaml-cpp
find_package(yaml-cpp REQUIRED)

add_executable(main
    main.cpp
    flatset/flatset.cpp
    filesystem/filesystem.cpp
    fem/fem.cpp
    yamlParser/yamlParser.cpp
)

# Add your own include dirs
target_include_directories(main PRIVATE
    flatset
    filesystem
    fem
    yamlParser
    ${YAML_CPP_INCLUDE_DIRS}
)

deal_ii_setup_target(main)

# Link external libs
target_link_libraries(main
    Boost::filesystem
    Boost::system
    ${YAML_CPP_LIBRARIES}
)