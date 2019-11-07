#!/bin/sh

cat << EOF
╔══════════════════════════════════════════════════════════════════════════════╗
║                                                                              ║
║           ██╗      ██████╗  ██████╗ █████╗ ██╗                               ║
║           ██║     ██╔═══██╗██╔════╝██╔══██╗██║                               ║
║           ██║     ██║   ██║██║     ███████║██║                               ║
║           ██║     ██║   ██║██║     ██╔══██║██║                               ║
║           ███████╗╚██████╔╝╚██████╗██║  ██║███████╗                          ║
║           ╚══════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝                          ║
║                                                                              ║
║           ██████╗ ███████╗██╗   ██╗    ███████╗███╗   ██╗██╗   ██╗           ║
║           ██╔══██╗██╔════╝██║   ██║    ██╔════╝████╗  ██║██║   ██║           ║
║           ██║  ██║█████╗  ██║   ██║    █████╗  ██╔██╗ ██║██║   ██║           ║
║           ██║  ██║██╔══╝  ╚██╗ ██╔╝    ██╔══╝  ██║╚██╗██║╚██╗ ██╔╝           ║
║           ██████╔╝███████╗ ╚████╔╝     ███████╗██║ ╚████║ ╚████╔╝            ║
║           ╚═════╝ ╚══════╝  ╚═══╝      ╚══════╝╚═╝  ╚═══╝  ╚═══╝             ║
║                                                                              ║
║            * github.com/paperwork * twitter.com/paperworkcloud *             ║
║                                                                              ║
╚══════════════════════════════════════════════════════════════════════════════╝

README:
-------

In order for the local development environment to function, you need to have the
following dependencies installed:

- Docker (https://www.docker.com)
- Caddy (https://caddyserver.com)

Also, you need to add the following entries to your /etc/hosts file:

127.0.0.1              localhost dev.api.paperwork.local dev.www.paperwork.local

If you already haven other entries set for 127.0.0.1, simply *append*
"dev.api.paperwork.local" and "dev.www.paperwork.local" to that line!

The local dev env won't detach automatically fron the command line. Hence, if
you would like your prompt back, make sure to run this inside screen/tmux.

When local dev env successfully started, it will show you something like this:

Serving HTTP on port 8000
http://dev.www.paperwork.local:8000
http://dev.api.paperwork.local:8000

From that point on you'll be able to work with the local dev environment. All
there's left to do then is to start the services you're working on/with.

Simply run 'make local-run-develop' inside each service's directory and it will
automatically start using the local dev env.

NOTE: You *need* to run 'service-gatekeeper' in order for this to function.

EOF

read -n 1 -s -r -p "Press any key to continue"
echo ""
echo ""

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Dependency checks                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝
type docker > /dev/null \
|| (echo "Docker could not be found!" && exit 1)

type caddy > /dev/null \
|| (echo "Caddy could not be found!" && exit 1)

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Collections (database)                                                       ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Updating MongoDB ..."
docker pull mongo:latest

echo "Launching MongoDB ..."
docker run -itd --rm --name service_collections --hostname service_collections -p 27017:27017 mongo:latest

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Storages back-end                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Updating Minio ..."
docker pull minio/minio

echo "Launching Minio ..."
docker run -itd --rm --name service_storages_backend --hostname service_storages_backend -e 'MINIO_ACCESS_KEY=root' -e 'MINIO_SECRET_KEY=roooooot' -p 9000:9000 minio/minio server /data

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Message broker                                                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Updating RabbitMQ ..."
docker pull rabbitmq:alpine

echo "Launching RabbitMQ ..."
docker run -itd --rm --name service_events --hostname service_events -e RABBITMQ_ERLANG_COOKIE='D]v!y;>nR!796v)S,R9J,J!zb^,a;m{:I0u^{2;{{82FV5p9YtUisT&,<4L$KC(^' -p 5672:5672 -p 15672:15672 rabbitmq:alpine

echo "Waiting for RabbitMQ to become available ..."
sleep 10 #TODO: fake it till you make it
echo "Enabling plugins ..."
docker exec -it service_events /opt/rabbitmq/sbin/rabbitmq-plugins enable rabbitmq_management
echo ""
echo "RabbitMQ management interface should not be available at:"
echo ""
echo "http://localhost:15672"
echo ""

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Proxy (attached)                                                           ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Checking Caddyfile ..."
caddy -validate -conf Caddyfile \
|| exit 1

echo "Launching Caddy and keeping it attached ..."
echo "(use Ctrl + C to shut down local dev env)"
echo ""
caddy -conf Caddyfile

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Proxy terminated, running shut-down procedure at this point                ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo ""

echo "Stopping RabbitMQ ..."
docker stop service_events

echo "Stopping Minio ..."
docker stop service_storages_backend

echo "Stopping MongoDB ..."
docker stop service_collections

echo "Local dev env has stopped."
exit 0
