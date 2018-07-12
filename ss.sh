#!/bin/bash
key=""
case $1 in
  install)
    apt-get install make gcc libev-dev libc-ares-dev libpcre3 libpcre3-dev rng-tools

    wget https://github.com/jedisct1/libsodium/releases/download/1.0.12/libsodium-1.0.12.tar.gz
    tar xf libsodium-1.0.12.tar.gz && cd libsodium-1.0.12
    ./configure && make -j2 && make install
    ldconfig

    cd /root
    
    wget https://github.com/xtaci/kcptun/releases/download/v20180316/kcptun-linux-amd64-20180316.tar.gz
    tar xf kcptun-linux-amd64-20180316.tar.gz
    chmod +x server_linux_amd64
    
    wget https://github.com/vennsong/wq/releases/download/shadowsocks/ss-server
    chmod +x ss-server
    
    wget https://github.com/vennsong/wq/releases/download/shadowsocks/91yunserverspeeder.tar.gz
  ;;
  kernel)
    wget http://security-cdn.debian.org/pool/updates/main/l/linux/linux-image-3.16.0-4-amd64_3.16.43-2+deb8u5_amd64.deb
    dpkg -i linux-image-3.16.0-4*.deb
    update-grub
  ;;
  start)
    /root/ss-server -s 0.0.0.0 -p 443 -l 1080 -m 'chacha20-ietf-poly1305' -k "$key" \
       > /dev/null 2>&1 &
    
    /root/server_linux_amd64 \
      -t "127.0.0.1:443" \
      -l ":443" \
      --key $key \
      --mode fast2 \
      --crypt aes-128 \
      --quiet > /dev/null 2>&1 &
  ;;
  *)
    echo "Ignorant"
  ;;
esac
