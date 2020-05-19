FROM scratch

# Blocked by https://github.com/gitpod-io/gitpod/issues/39
COPY gitpod/scripts/root-access.sh /usr/bin/root-access
RUN true "7a8fhs1g" \
	&& chmod +x /usr/bin/root-access \
	&& /usr/bin/root-access \
	&& rm /usr/bin/root-access

# Blocked by https://github.com/gitpod-io/gitpod/issues/1265
COPY gitpod/scripts/vm-support.sh /usr/bin/vm-support
RUN true "dg798sda7h" \
	&& chmod +x /usr/bin/vm-support \
	&& /usr/bin/vm-support \
	&& rm /usr/bin/vm-support