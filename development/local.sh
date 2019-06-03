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
# ║ Database                                                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Updating MongoDB ..."
docker pull mongo:latest

echo "Launching MongoDB ..."
docker run -itd --rm --name mongodb -p 27017:27017 mongo:latest

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║ Storages back-end                                                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝
echo "Updating Minio ..."
docker pull minio/minio

echo "Launching Minio ..."
docker run -itd --rm --name minio -e 'MINIO_ACCESS_KEY=root' -e 'MINIO_SECRET_KEY=roooooot' -p 9000:9000 minio/minio server /data

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
echo "Stopping Minio ..."
docker stop minio

echo "Stopping MongoDB ..."
docker stop mongodb

echo "Local dev env has stopped."
exit 0
