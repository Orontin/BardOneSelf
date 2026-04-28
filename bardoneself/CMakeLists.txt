cmake_minimum_required(VERSION 3.20)
project(bardoneself VERSION 1.0.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Quick)

qt_standard_project_setup()

qt6_add_resources(APP_RESOURCES bardoneself.qrc)

qt6_add_executable(bardoneself
    main.cpp
    ${APP_RESOURCES}
)

target_link_libraries(bardoneself PRIVATE Qt::Core Qt::Quick)
