#!/bin/bash
set -x
set -o errexit
# Create a container
container=$(buildah from --name "buildah-nginx" alpine)
mount=$(buildah mount $container)
# Labels are part of the "buildah config" command
buildah config --label maintainer="manintheit <manintheit@gmail.com>" $container
buildah run $container  apk add --no-cache nginx
buildah run $container  mkdir /www
buildah run $container  mkdir -p /run/nginx
buildah run $container  adduser -D -g 'www' www
buildah run $container  chown -R www:www /var/lib/nginx
buildah run $container  chown -R www:www /www
mv $mount/etc/nginx/nginx.conf $mount/etc/nginx/nginx.conf.orig
cp ./conf/nginx.conf $mount/etc/nginx/nginx.conf
cp ./www/index.html $mount/www/index.html
buildah config --port 8080  $container
buildah config --entrypoint 'nginx -g "daemon off;"' $container
#Uncomment it if you need a debugging...
#buildah config --cmd ["/bin/sleep 36000"] $container
#For docker format use it --format docker
#buildah commit --format docker $container hello:latest
buildah commit  $container buildah-nginx
buildah unmount $container