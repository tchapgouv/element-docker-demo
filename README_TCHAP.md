## To run

1. Install [Docker Compose](https://docs.docker.com/compose/install/).
2. If you're running on your local workstation, then [install mkcert](https://github.com/FiloSottile/mkcert#installation) to manage TLS.

Then:

```````
./setup.sh

# Type your domain ie. : `tchapgouv.com`

# Point DNS for *.domain at your docker host,
# Or if running on localhost with mkcert:
# source .env; sudo sh -c "echo 127.0.0.1 $DOMAINS >> /etc/hosts"

docker compose up
# go to https://element.tchapgouv.com on your domain.
```