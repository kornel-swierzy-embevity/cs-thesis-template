FROM debian:bookworm as gosu

# Docker setup for proper permission management without root login
ENV GOSU_URL https://github.com/tianon/gosu/releases/download/1.12/gosu

RUN apt-get update \
    && apt-get -y install \
        gnupg2 \
        ca-certificates \
        curl \
    && gpg --keyserver keys.openpgp.org --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "$GOSU_URL-$(dpkg --print-architecture)" \
    && curl -o /usr/local/bin/gosu.asc -SL "$GOSU_URL-$(dpkg --print-architecture).asc" \
    && gpg --verify /usr/local/bin/gosu.asc \
    && rm /usr/local/bin/gosu.asc \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x /usr/local/bin/gosu

FROM debian:bookworm

# non interactive frontend for locales
ENV DEBIAN_FRONTEND=noninteractive

# installing texlive and utils
RUN apt-get update && \
	apt-get -y install --no-install-recommends --fix-missing \
        pandoc \
        texlive \
        texlive-latex-extra \
        texlive-extra-utils \
        texlive-fonts-extra \
        texlive-bibtex-extra \
        texlive-lang-polish \
        biber \
        latexmk \
        make \
        git \
        procps \
        locales \
        curl \
        zsh \
        && \
    rm -rf /var/lib/apt/lists/*

COPY --from=gosu /usr/local/bin/gosu /usr/local/bin/gosu

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

COPY tools/docker/files/entrypoint.sh /usr/bin/local/entrypoint.sh
RUN chmod +x /usr/bin/local/entrypoint.sh

RUN mkdir -p /opt/src
WORKDIR /opt/src
ENTRYPOINT ["/usr/bin/local/entrypoint.sh"]
CMD ["zsh"]
