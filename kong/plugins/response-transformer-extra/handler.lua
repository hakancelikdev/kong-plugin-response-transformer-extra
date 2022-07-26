local body_transformer = require "kong.plugins.response-transformer-extra.body_transformer"
local header_transformer = require "kong.plugins.response-transformer-extra.header_transformer"

local is_body_transform_set = header_transformer.is_body_transform_set
local is_json_body = header_transformer.is_json_body
local kong = kong


local ResponseTransformerExtraHandler = {
  PRIORITY = 902,  -- NOTE: default 800,  to make it work before the plugin response-ratelimiting
  VERSION = "2.8.1",
}


function ResponseTransformerExtraHandler:header_filter(conf)
  header_transformer.transform_headers(conf, kong.response.get_headers())
end


function ResponseTransformerExtraHandler:body_filter(conf)
  if not is_body_transform_set(conf)
    or not is_json_body(kong.response.get_header("Content-Type"))
  then
    return
  end

  local body = kong.response.get_raw_body()
  if body then
    return kong.response.set_raw_body(body_transformer.transform_json_body(conf, body))
  end
end


return ResponseTransformerExtraHandler
