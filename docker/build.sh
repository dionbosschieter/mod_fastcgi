echo "nameserver 8.8.8.8" > /etc/resolv.conf
apt-get update
trap 'rm -rf /root/build' 0 1 2 3 6 9 14 15

apt-get install -y wget build-essential libz-dev python autoconf libtool libtool-bin libpcre++-dev libexpat1-dev apache2-dev git
mkdir -vp /root/build/
cd /root/build/

# build apache24
wget http://httpd.apache.org/dev/dist/httpd-2.4.26.tar.gz
wget http://httpd.apache.org/dev/dist/httpd-2.4.26-deps.tar.gz
tar xfz httpd-2.4.26.tar.gz
tar xfz httpd-2.4.26-deps.tar.gz
cd httpd-2.4.26/srclib
wget http://mirror.netcologne.de/apache.org//apr/apr-iconv-1.2.1.tar.gz
tar xvfz apr-iconv-1.2.1.tar.gz
mv apr-iconv-1.2.1 apr-iconv
wget http://zlib.net/zlib-1.2.11.tar.gz
tar xfz zlib-1.2.11.tar.gz
mv zlib-1.2.11 zlib
wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.40.tar.gz
tar xfz pcre-8.40.tar.gz
mv pcre-8.40 pcre
wget https://openssl.org/source/openssl-1.0.1.tar.gz
tar xfz openssl-1.0.1.tar.gz
rm -v openssl-1.0.1.tar.gz
cd openssl-*
./config --prefix=/usr zlib-dynamic --openssldir=/etc/ssl shared
make
make install_sw
cd ../..
./buildconf
./configure --prefix=/opt/apache2 --enable-pie --enable-mods-shared=all --enable-so --disable-include --enable-deflate --enable-headers --enable-expires --enable-ssl=shared --enable-mpms-shared=all --with-mpm=event --enable-rewrite --with-z=/home/mario/apache24/httpd-2.4.26/srclib/zlib --enable-module=ssl --enable-fcgid --with-included-apr
make 
make install

# build mod_fastcgi
cd
git clone https://github.com/dionbosschieter/mod_fastcgi.git
cd mod_fastcgi
cp -v Makefile{.AP2,}
make top_dir=/opt/apache2/
make install top_dir=/opt/apache2/
echo 'LoadModule fastcgi_module modules/mod_fastcgi.so' >> /opt/apache2/conf/httpd.conf
