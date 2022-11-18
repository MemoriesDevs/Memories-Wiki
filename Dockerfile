FROM ubuntu:latest

WORKDIR /app

COPY ./docs ./docs
COPY ./mkdocs.yml ./

RUN apt update

RUN apt-get install ssh \ 
    git \ 
    python3 \
    python3-dev \
    python3-pip -y
  
RUN pip install --upgrade pip && \
    pip install mkdocs && \
    pip install mkdocs-minify-plugin && \
    pip install mkdocs-drawio-exporter && \
    pip install mkdocs-material && \
    pip install mkdocs-ko-fi-button-plugin && \
    pip install mkdocs-windmill && \
    pip install mkdocs-git-revision-date-localized-plugin && \
    pip install mkdocs-windmill-dark && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

RUN python3 -m mkdocs build

EXPOSE 8000

ENTRYPOINT [ "python3" ]

CMD ["-m", "mkdocs", "serve", "--dev-addr=0.0.0.0:8000"]
