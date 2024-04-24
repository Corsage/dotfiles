#!/usr/bin/env nu

# Defined in custom.nu
let projects = ls $env.PROJECT_DIR | where type == "dir" | get name | each { |folder| $folder | split row '\' | last };

let escaped_projects_dir = $env.PROJECT_DIR | str replace --all "\\" "\\\\";

let lua_start = "return { ";
let lua_end = " }";

let arr = $lua_start + ($projects | each { |p| "{ id = " + "\"" + $escaped_projects_dir + "\"" + " .. " +  "\"\\\\" + $p + "\"" + ", label = " + "\"" + $p + "\"" + " }" } | str join ", ") + $lua_end;

$arr | save -f projects.lua

"Updated projects.lua using directory " + $env.PROJECT_DIR | print