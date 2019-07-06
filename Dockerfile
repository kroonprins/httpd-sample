FROM debian:stretch-slim

RUN apt-get update                                                  && \
    apt-get install -y libtool pkg-config autoconf libssl-dev check libjansson-dev apache2 apache2-dev libz-dev git && \
    git clone https://github.com/benmcollins/libjwt                 && \
    cd libjwt                                                       && \
    git checkout tags/v1.8.0                                        && \
    autoreconf -i                                                   && \
    ./configure                                                     && \
    make                                                            && \
    make install                                                    && \
    cd ..                                                           && \
    git clone https://github.com/AnthonyDeroche/mod_authnz_jwt      && \
    cd mod_authnz_jwt                                               && \
    autoreconf -ivf                                                 && \
    ./configure                                                     && \
    make                                                            && \
    make install

FROM httpd:2.4

COPY --from=0 /usr/lib/apache2/modules/mod_authnz_jwt.so /usr/local/apache2/modules/mod_authnz_jwt.so
COPY --from=0 /usr/local/lib/ /usr/local/lib/
ENV LD_LIBRARY_PATH /usr/local/lib