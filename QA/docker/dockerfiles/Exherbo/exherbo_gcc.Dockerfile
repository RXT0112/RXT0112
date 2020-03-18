FROM exherbo/exherbo_ci:latest

USER root

# Export paludis-config
RUN rm -r /etc/paludis && git clone https://github.com/Kreyrock/paludis-config.git /etc/paludis

# Sync repos
RUN cave sync

# Add required repositories
RUN [ ! -e /etc/paludis/repositories/alip.conf ] && cave resolve -x1 repository/alip
RUN [ ! -e /etc/paludis/repositories/compnerd.conf ] && cave resolve -x1 repository/compnerd
RUN [ ! -e /etc/paludis/repositories/virtualization.conf ] && cave resolve -x1 repository/virtualization
RUN [ ! -e /etc/paludis/repositories/danyspin97.conf ] && cave resolve -x1 repository/danyspin97
RUN [ ! -e /etc/paludis/repositories/python.conf ] && cave resolve -x1 repository/python
RUN [ ! -e /etc/paludis/repositories/perl.conf ] && cave resolve -x1 repository/perl
RUN [ ! -e /etc/paludis/repositories/hasufell.conf ] && cave resolve -x1 repository/hasufell

# Install build dependencies
RUN cave resolve sys-devel/meson sys-devel/gcc sys-fs/fuse dev-scm/git sys-devel/ninja sys-devel/bison sys-devel/libtool sys-devel/autoconf dev-util/pkg-config sys-apps/fakeroot app-arch/gzip net-misc/rsync sys-devel/autoconf -x

# Install test dependencies
RUN cave resolve  dev-util/cppcheck  dev-util/indent  dev-util/shellcheck -x

# Purge unwanted packages
RUN cave purge -x

# Remove build instructions
RUN rm -r /var/db/paludis