Docker image for httpbin.org
============================

The [official image](https://hub.docker.com/r/kennethreitz/httpbin) is based on
Ubuntu, which is unnecessarily huge (> 400MiB), and it hasn't been updated
since 2018.

This version is based on alpine, the total size is under 100MiB.

Usage
-----

```sh
# Start
docker run -d --rm --name=httpbin -p 8000:80 kanna5/httpbin

# Test it
curl http://127.0.0.1:8000/anything

# Stop
docker stop httpbin
```
