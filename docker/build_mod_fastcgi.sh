cd /root/build
git clone https://github.com/dionbosschieter/mod_fastcgi.git
cd mod_fastcgi
cp -v Makefile{.AP2,}
make top_dir=/opt/apache2/
make install top_dir=/opt/apache2/
echo 'LoadModule fastcgi_module modules/mod_fastcgi.so' >> /opt/apache2/conf/httpd.conf
