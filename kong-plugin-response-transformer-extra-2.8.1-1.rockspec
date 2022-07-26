local plugin_name = "response-transformer-extra"
local package_name = "kong-plugin-" .. plugin_name
local package_version = "2.8.1"
local rockspec_revision = "1"

local github_account_name = "hakancelikdev"
local github_repo_name = package_name
local git_checkout = package_version == "dev" and "master" or package_version


package = package_name
version = package_version .. "-" .. rockspec_revision
supported_platforms = { "linux", "macosx" }
source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = git_checkout,
}


description = {
  summary = "Kong plugin response transformer extra; Transformations can be restricted to responses with specific status codes using various config.*.if_status configuration parameters.",
  homepage = "https://"..github_account_name..".github.io/"..github_repo_name,
  license = "Apache 2.0",
}


dependencies = {
}


build = {
  type = "builtin",
  modules = {
    -- TODO: add any additional code files added to the plugin
    ["kong.plugins."..plugin_name..".handler"] = "kong/plugins/"..plugin_name.."/handler.lua",
    ["kong.plugins."..plugin_name..".schema"] = "kong/plugins/"..plugin_name.."/schema.lua",
    ["kong.plugins."..plugin_name..".body_transformer"] = "kong/plugins/"..plugin_name.."/body_transformer.lua",
    ["kong.plugins."..plugin_name..".header_transformer"] = "kong/plugins/"..plugin_name.."/header_transformer.lua",
  }
}
