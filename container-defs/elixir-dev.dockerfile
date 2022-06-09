ARG UBI_BASE
FROM $UBI_BASE

RUN dnf -y install https://packages.erlang-solutions.com/erlang-solutions-2.0-1.noarch.rpm && \
    dnf -y update

ENV ERLANG_MAJOR_VERSION 24
ENV ERLANG_SEMVER ${ERLANG_MAJOR_VERSION}.0

RUN dnf -y install \
    erlang-compiler-${ERLANG_SEMVER} \
    erlang-crypto-${ERLANG_SEMVER} \
    erlang-erts-${ERLANG_SEMVER} \
    erlang-inets-${ERLANG_SEMVER} \
    erlang-kernel-${ERLANG_SEMVER} \
    erlang-mnesia-${ERLANG_SEMVER} \
    erlang-parsetools-${ERLANG_SEMVER} \
    erlang-runtime_tools-${ERLANG_SEMVER} \
    erlang-sasl-${ERLANG_SEMVER} \
    erlang-ssl-${ERLANG_SEMVER} \
    erlang-stdlib-${ERLANG_SEMVER} \
    erlang-tools-${ERLANG_SEMVER} \
    erlang-xmerl-${ERLANG_SEMVER}

# # install elixir
ENV PATH=/usr/local/elixir/bin:"$PATH"
RUN mkdir -p /app/{_build,deps,source}
RUN echo "export PATH=$PATH:/usr/local/elixir/bin" > /etc/profile.d/elixir-path.sh
RUN chmod 755 /etc/profile.d/elixir-path.sh

ENV MIX_ENV dev

ENV ELIXIR_VERSION 1.13.0
ENV VERSION_ID=v${ELIXIR_VERSION}-otp-${ERLANG_MAJOR_VERSION}

# TODO: Where is this link referenced from?  i.e. how do we know what to do if/when it's updated or dropped?
# This allows Docker to track hashes of the upstream:
RUN curl --output elixir-${VERSION_ID}.zip --proto '=https' --tlsv1.2 -sSf https://repo.hex.pm/builds/elixir/${VERSION_ID}.zip

RUN mkdir -p /usr/local/elixir && \
    unzip -d /usr/local/elixir -x elixir-${VERSION_ID}.zip && \
    rm -f elixir-${VERSION_ID}.zip

RUN mix local.hex --force
RUN mix local.rebar --force
