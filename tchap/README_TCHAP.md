## To run

1. Install [Docker Compose](https://docs.docker.com/compose/install/).
2. If you're running on your local workstation, then [install mkcert](https://github.com/FiloSottile/mkcert#installation) to manage TLS.

Build the tchap web v4 image locally : 
- checkout develop_tchap in repo [tchap-web-v4](https://github.com/tchapgouv/tchap-web-v4)
- build the image from the root folder

`docker build -t develop_tchap .`

Then:

```
./setup.sh

# NOTE: it is important to use tchapgouv.com as a domain / our sydent mock is configure with this
# Type your domain : `tchapgouv.com`

# Point DNS for *.domain at your docker host,
# Or if running on localhost with mkcert:
# source .env; sudo sh -c "echo 127.0.0.1 $DOMAINS >> /etc/hosts"

./start_tchap.sh
# go to https://element.tchapgouv.com on your domain.
```

if containers do not start, start them manually

## Local dev

If you want to start your own MAS, change the variable in the start_tchap.sh to remove the `with_mas` value. 

Same with tchap-web

`export COMPOSE_PROFILES="tchap,with_mas,with_web"`

Then you can start your component, with the configuration files in `data` folder.

For instance for mas, you need to use the configuration file `data/mas/config.yaml`

## Mailhog

you can access mailhog at this url : https://mail.tchapgouv.com:8025