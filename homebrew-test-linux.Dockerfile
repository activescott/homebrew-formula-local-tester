FROM homebrew/ubuntu16.04

VOLUME /mnt/homebrew
WORKDIR /mnt/homebrew

ARG FORMULA_NAME

# Below here based on https://github.com/Homebrew/homebrew-core/runs/7022865709?check_suite_focus=true#step:7:20
RUN brew fetch --retry alsa-lib aom apr apr-util asciidoctor attr autoconf autoconf@2.69 automake bdw-gc berkeley-db binutils bison brotli byacc bzip2 ca-certificates cairo cmake coreutils cups curl docbook docbook-xsl docutils doxygen elfutils expat flex fontconfig freeglut freetype fribidi gcc gd gdbm gdk-pixbuf gettext ghostscript giflib glib glibc@2.13 gmp gnu-getopt gnu-sed gnupg gnutls gobject-introspection gpatch gperf graphite2 graphviz gts guile gzip harfbuzz help2man icu4c intltool isl itstool jasper jbig2dec jinja2-cli jpeg json-c krb5 libassuan libatomic_ops libavif libcap libdrm libedit libevent libffi libgcrypt libgpg-error libice libidn libidn2 libksba libmpc libnghttp2 libpciaccess libpng libpthread-stubs librsvg libsecret libsm libssh2 libtasn1 libtiff libtool libunistring libusb libva libvdpau libx11 libxau libxcb libxcrypt libxdamage libxdmcp libxext libxfixes libxi libxinerama libxml2 libxrandr libxrender libxshmfence libxslt libxt libxtst libxv libxvmc libxxf86vm libyaml linux-headers@4.4 little-cms2 llvm lm-sensors lz4 lzo m4 mawk mesa mesa-glu meson mpdecimal mpfr nasm ncurses netpbm nettle ninja npth openjdk openjpeg openldap openssl@1.1 p11-kit pango pcre perl pinentry pixman pkg-config popt python python@3.10 python@3.8 python@3.9 readline rsync rtmpdump ruby rust scons shared-mime-info six sqlite subversion swig systemd tcl-tk unbound unixodbc unzip utf8proc util-linux util-macros vala wayland wayland-protocols webp xcb-proto xinput xmlto xorgproto xtrans xxhash xz yasm zip zlib zstd

### copy formula in place ##
# '/home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core' from `brew --repository homebrew/core`
COPY staging/${FORMULA_NAME}.rb /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/
RUN stat /home/linuxbrew/.linuxbrew/Homebrew/Library/Taps/homebrew/homebrew-core/Formula/${FORMULA_NAME}.rb

RUN brew fetch --retry ${FORMULA_NAME} --build-bottle --force

RUN HOMEBREW_NO_AUTO_UPDATE=1 brew install --only-dependencies --verbose --build-bottle ${FORMULA_NAME}

RUN HOMEBREW_NO_AUTO_UPDATE=1 brew install --verbose --build-bottle ${FORMULA_NAME}

RUN HOMEBREW_NO_AUTO_UPDATE=1 brew test ${FORMULA_NAME}

