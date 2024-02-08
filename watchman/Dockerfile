# Stage I: Runtime =============================================================

# Step 1: Begin with Alpine 3.9:
FROM alpine:3.17 AS runtime

# Step 2: Install watchman runtime dependencies:
RUN apk add --no-cache libcrypto1.1 libgcc libstdc++

# Stage II: Builder ============================================================

# Step 3: Begin from runtime stage image:
FROM runtime AS builder

# # Step 4: Install the watchman build dependencies' dependencies :)
RUN apk add --no-cache --update ca-certificates openssl

# # Step 5: Install the watchman build dependencies:
RUN apk add --quite --no-cache \
    automake \
    autoconf \
    bash \
    build-base \
    libtool \
    linux-headers \
    openssl-dev \
    python3-dev \
    tar

# # Step 6: Set environment variables:
ENV WATCHMAN_VERSION=2023.10.09.00

# # Step 7: Download watchman source code:
RUN cd /tmp \
 && wget -O watchman.tar.gz "https://github.com/facebook/watchman/archive/refs/tags/v${WATCHMAN_VERSION}.tar.gz" \
 && tar -xz -f watchman.tar.gz -C /tmp/ \
 && rm -rf watchman.tar.gz

# # Step 8: Build watchman from source:
WORKDIR /tmp/watchman-${WATCHMAN_VERSION}
# RUN cd /tmp/watchman-${WATCHMAN_VERSION}
RUN ./install-system-packages.sh
RUN ./autogen.sh
RUN ./configure --enable-lenient
RUN make
RUN make install

WORKDIR $HOME
RUN rm -rf /tmp/*

# Stage III: Release ===========================================================

# Step 9: Begin with the runtime stage image:
FROM runtime AS release

# Step 10: Copy the compiled executable:
COPY --from=builder /usr/local/bin/watchman* /usr/local/bin/

# Step 11: Copy the documentation:
# COPY --from=builder /usr/local/share/doc/watchman-4.9.0 /usr/local/share/doc/watchman-4.9.0

# Step 12: Copy the runtime directories:
COPY --from=builder /usr/local/var/run/watchman /usr/local/var/run/watchman
