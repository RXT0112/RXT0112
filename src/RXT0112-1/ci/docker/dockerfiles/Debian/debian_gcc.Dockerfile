FROM debian/debian:testing

USER root

# Define libraries
RUN sh -c " \
fixme() { printf 'FIXME: %s\n' "$1" ;} \
warn() { printf 'WARN: %s\n' "$1" ;} \
die() { \
    printf 'FATAL: %s\n' "$1" \
    exit 1 \
}"

# Install dependencies
RUN apt install -y meson cppcheck gcc libfuse3-dev gcc libcap-devgit ninja-build bison libtool autoconf pkg-config libcap-dev indent libattr1-dev  fakeroot uthash-dev gzip rsync autopoint shellcheck || die "Unable to install all dependencies"

# Install shfmt (Hack!)
RUN sh -c " \
if [ "$(apt-cache search libfuse3-dev | grep -o "shfmt")" != "shfmt" ]; then \
    if [ ! -e /usr/bin/shfmt ]; then \
        wget https://github.com/mvdan/sh/releases/download/v3.0.0-beta1/shfmt_v3.0.0-beta1_linux_amd64 -O /usr/bin/shfmt \
        [ ! -x /usr/bin/shfmt ] && chmod +x /usr/bin/shfmt \
    elif [ ! -e /usr/bin/shfmt ]; then \
    fi \
elif [ "$(apt-cache search libfuse3-dev | grep -o "shfmt")" = "shfmt" ]; then \
    apt install -y shfmt || die "Unable to install shfmt" \
else \
    die "Unexpected happend in shfmt hack" \
fi"