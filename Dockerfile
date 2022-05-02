FROM alpine:3

# Ref: https://github.com/postmanlabs/httpbin/blob/master/Dockerfile

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

RUN set -xe; \
    apk add --no-cache coreutils binutils findutils curl python3 alpine-sdk libffi libffi-dev python3-dev; \
    MAKEFLAGS="$MAKEFLAGS -j $(nproc)"; \
    export MAKEFLAGS; \
    python3 -m venv /usr/local/httpbin; \
    cd /usr/local/httpbin; \
    mkdir src; \
    curl -sSL https://github.com/postmanlabs/httpbin/archive/refs/heads/master.tar.gz | tar -C src --strip-components 1 -xz; \
    source bin/activate; \
    pip install --upgrade pip; \
    pip install --upgrade setuptools; \
    pip install --upgrade wheel; \
    pip install --upgrade gunicorn 'flask<2' 'werkzeug<2' 'markupsafe<2'; \
    pip install -e src; \
    pip uninstall -y pip wheel; \
    deactivate; \
    find -type f -name '*.so*' -exec strip -s '{}' +; \
    rm /root/.cache -rf; \
    apk del --no-network coreutils binutils findutils curl alpine-sdk libffi-dev python3-dev

EXPOSE 80

CMD ["/usr/local/httpbin/bin/gunicorn", "-b", "0.0.0.0:80", "httpbin:app", "-k", "gevent"]
