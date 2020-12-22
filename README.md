# Nginx upstream

Nginx configuration to test out how Nginx works with backend servers and to use
the [nginx-module-vts](https://github.com/vozlt/nginx-module-vts) module.

## Implementation

Run `docker-compose up` to run a frontend server with two backend servers. One
will work as a `backup` and the other one as the main server. The main server
will return a `500` when `/error` is requested. This way we can test how Nginx
will behave when configured to treat a 500 as an error.
