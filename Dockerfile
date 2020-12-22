FROM nginx:1.19.6 as build

RUN apt-get update && \
    apt-get install -y \
        openssh-client \
        git \
        wget \
        libxml2 \
        libxslt1-dev \
        libpcre3 \
        libpcre3-dev \
        zlib1g \
        zlib1g-dev \
        openssl \
        libssl-dev \
        libtool \
        automake \
        gcc \
        g++ \
        make && \
    rm -rf /var/cache/apt

RUN wget -q "http://nginx.org/download/nginx-1.15.0.tar.gz" && \
    tar -C /usr/src -xzf nginx-1.15.0.tar.gz

RUN wget -q "https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz" && \
    tar -C /usr/src -xzf v0.1.18.tar.gz

WORKDIR /usr/src/nginx-1.15.0
#RUN NGINX_ARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') && \
#    ./configure --add-module=/usr/src/nginx-module-vts-0.1.18 "${NGINX_ARGS}"
RUN ./configure --add-module=/usr/src/nginx-module-vts-0.1.18
#RUN ./configure --add-module=/usr/src/nginx-module-vts-0.1.18 --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.15.0/debian/debuild-base/nginx-1.15.0=. -specs=/usr/share/dpkg/no-pie-compile.specs -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-specs=/usr/share/dpkg/no-pie-link.specs -Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'
RUN make
RUN make install
RUN cp -f objs/nginx /usr/sbin/nginx

#FROM nginx:1.15.0
#COPY --from=build /usr/src/nginx-1.15.0/objs/* /usr/lib/nginx/modules/
#COPY --from=build /usr/sbin/nginx /usr/sbin/nginx


###


# NGINX_ARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p')
# ./configure --with-compat --with-http_ssl_module --add-dynamic-module=/src/ngx_devel_kit --add-dynamic-module=/src/set-misc-nginx-module ${NGINX_ARGS} && \
#     make modules


# ./configure --add-module=/usr/src/nginx-module-vts-0.1.18 --add-dynamic-module=/usr/src/nginx-module-vts-0.1.18 ${NGINX_ARGS}
# ./configure --add-module=/usr/src/nginx-module-vts-0.1.18 --add-dynamic-module=/usr/src/nginx-module-vts-0.1.18 --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-compat --with-file-aio --with-threads --with-http_addition_module --with-http_auth_request_module --with-http_dav_module --with-http_flv_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_mp4_module --with-http_random_index_module --with-http_realip_module --with-http_secure_link_module --with-http_slice_module --with-http_ssl_module --with-http_stub_status_module --with-http_sub_module --with-http_v2_module --with-mail --with-mail_ssl_module --with-stream --with-stream_realip_module --with-stream_ssl_module --with-stream_ssl_preread_module --with-cc-opt='-g -O2 -fdebug-prefix-map=/data/builder/debuild/nginx-1.19.6/debian/debuild-base/nginx-1.19.6=. -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -fPIC' --with-ld-opt='-Wl,-z,relro -Wl,-z,now -Wl,--as-needed -pie'
# make
# make modules
# make
# make install

###

# sudo apt-get update
# sudo apt-get install -y openssh-client git wget libxml2 libxslt1-dev libpcre3 libpcre3-dev zlib1g zlib1g-dev openssl libssl-dev libtool automake gcc g++ make

# wget -q "http://nginx.org/download/nginx-1.15.0.tar.gz"
# sudo tar -C /usr/src -xzf nginx-1.15.0.tar.gz

# wget -q "https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz" && \
# sudo tar -C /usr/src -xzf v0.1.18.tar.gz

# cd /usr/src/nginx-1.15.0
# sudo ./configure --add-module=/usr/src/nginx-module-vts-0.1.18
# sudo make
# sudo make install

###

# # syntax=docker/dockerfile:experimental
# ARG NGINX_VERSION
# FROM nginx:${NGINX_VERSION} as build

# RUN apt-get update && \
#     apt-get install -y \
#         openssh-client \
#         git \
#         wget \
#         libxml2 \
#         libxslt1-dev \
#         libpcre3 \
#         libpcre3-dev \
#         zlib1g \
#         zlib1g-dev \
#         openssl \
#         libssl-dev \
#         libtool \
#         automake \
#         gcc \
#         g++ \
#         make && \
#     rm -rf /var/cache/apt

# RUN wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" && \
#     tar -C /usr/src -xzvf nginx-${NGINX_VERSION}.tar.gz

# RUN mkdir -p -m 0600 ~/.ssh && \
#     ssh-keyscan github.com >> ~/.ssh/known_hosts

# WORKDIR /src/ngx_devel_kit
# RUN --mount=type=ssh git clone git@github.com:simpl/ngx_devel_kit .

# WORKDIR /src/set-misc-nginx-module
# RUN --mount=type=ssh git clone git@github.com:openresty/set-misc-nginx-module.git .

# WORKDIR /usr/src/nginx-${NGINX_VERSION}
# RUN NGINX_ARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
#     ./configure --with-compat --with-http_ssl_module --add-dynamic-module=/src/ngx_devel_kit --add-dynamic-module=/src/set-misc-nginx-module ${NGINX_ARGS} && \
#     make modules

# FROM nginx:${NGINX_VERSION}

# COPY nginx.conf /etc/nginx/nginx.conf
# COPY --from=build /usr/src/nginx-${NGINX_VERSION}/objs/ngx_http_set_misc_module.so /usr/src/nginx-${NGINX_VERSION}/objs/ndk_http_module.so /usr/lib/nginx/modules/
