wget -c http://dl.teddysun.com/shadowsocks/shadowsocks-server-linux64-1.2.1.gz
gzip -d shadowsocks-server-linux64-1.2.1.gz
chmod +x shadowsocks-server-linux64-1.2.1
mv -f shadowsocks-server-linux64-1.2.1 /usr/bin/ss-go

#kernel
#rpm -ivh http://soft.91yun.org/ISO/Linux/CentOS/kernel/kernel-3.10.0-229.1.2.el7.x86_64.rpm --force

#speed
wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh && bash serverspeeder.sh


