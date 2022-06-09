ARG ELIXIR_DEV
FROM $ELIXIR_DEV

RUN dnf -y install nodejs
RUN npm install -g webpack webpack-cli

RUN mix archive.install hex phx_new
