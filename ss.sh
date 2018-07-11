#!/bin/bash

case $1 in
  install)
    wget https://github.com/jedisct1/libsodium/releases/download/1.0.16/libsodium-1.0.16.tar.gz
    tar xf libsodium-1.0.16.tar.gz && cd libsodium-1.0.16
    ./configure && make -j2 && make install
    ldconfig
    
    wget https://github.com/xtaci/kcptun/releases/download/v20180316/kcptun-linux-amd64-20180316.tar.gz
    tar xf kcptun-linux-amd64-20180316.tar.gz
    chmod +x server_linux_amd64
    
    wget https://github.com/vennsong/wq/releases/download/shadowsocks/ss-server
    chmod +x ss-server
    
    wget https://github.com/vennsong/wq/releases/download/shadowsocks/91yunserverspeeder.tar.gz
  ;;
  start)
    /root/ss-server -s 0.0.0.0 -p 443 -l 1080 -m 'chacha20-ietf-poly1305' -k 'yourkey' \
       > /dev/null 2>&1 &
    
    key='yourkey'
    /root/server_linux_amd64 \
      -t "127.0.0.1:443" \
      -l ":443" \
      --key $key \
      --mode fast2 \
      --crypt xor \
      --quiet > /dev/null 2>&1 &
  ;;
  *)
    echo "Ignorant"
  ;;
esac
