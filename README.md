Kong plugin response transformer extra
====================

Transformations can be restricted to responses with specific status codes using various config.*.if_status configuration parameters.

## Extras

### Priortiy
[Priortiy: 902](https://github.com/hakancelikdev/kong-plugin-response-transformer-extra/blob/main/kong/plugins/response-transformer-extra/handler.lua#L10) [Default 800 on kong.](https://github.com/Kong/kong/blob/c54a2e99d95fd890c7a30ec072b20d72344bb8fc/kong/plugins/response-transformer/handler.lua#L12)
to make it work before the plugin response-ratelimiting response-ratelimiting's [priorty is 900](https://github.com/Kong/kong/blob/c54a2e99d95fd890c7a30ec072b20d72344bb8fc/kong/plugins/response-ratelimiting/handler.lua#L30)
## if_status
Response Transformer Extra includes the following additional configurations: add.if_status, append.if_status, remove.if_status, replace.if_status and rename.if_status.

| Config  |  Type |  Description | 
|---|---|---|
| config.remove.if_status [ Optional ]  |  array of string elements | List of response status codes or status code ranges to which the transformation will apply. Empty means all response codes.  | 
| config.rename.if_status [ Optional ]  |  array of string elements | List of response status codes or status code ranges to which the transformation will apply. Empty means all response codes.  | 
| config.replace.if_status [ Optional ]  |  array of string elements | List of response status codes or status code ranges to which the transformation will apply. Empty means all response codes.  | 
| config.add.if_status [ Optional ]  |  array of string elements | List of response status codes or status code ranges to which the transformation will apply. Empty means all response codes.  | 
| config.append.if_status [ Optional ]  |  array of string elements | List of response status codes or status code ranges to which the transformation will apply. Empty means all response codes.  | 

-----

## Test with pongo

```
pongo shell

kong migrations bootstrap --force
kong start


curl -i -X POST \
 --url http://localhost:8001/services/ \
 --data 'name=example-service' \
 --data 'url=http://konghq.com'

curl -i -X POST \
 --url http://localhost:8001/services/example-service/routes \
 --data 'hosts[]=example.com'

curl -X POST http://localhost:8001/services/example-service/plugins/ \
  --header 'content-type: application/json' \
  --data '{"name": "response-transformer-extra", "config": {"add": {"headers": ["h1:v2", "h2:v1"], "if_status": ["200", "301"]}}}'


curl -I -H "Host: example.com" http://localhost:8000/
```
