# selinux disable
sudo sed -i -e 's/SELINUX=enforcing/SELINUX=disable/' /etc/sysconfig/selinux

# yum repos
# epel
sudo rpm --import https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
# remi
sudo rpm --import https://rpms.remirepo.net/RPM-GPG-KEY-remi
sudo yum install -y http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
# mysql
sudo yum -y localinstall https://dev.mysql.com/get/mysql57-community-release-el7-8.noarch.rpm

yum -y update --exclude=kernel*

# apache
sudo yum -y install httpd httpd-devel
sudo systemctl enable httpd
sudo systemctl start httpd

# php
sudo yum -y install --enablerepo=remi \
gd-last \
libzip-last

sudo yum -y install --enablerepo=remi-php56 \
php-devel \
php-mbstring \
php-mysql \
php-pdo \
php-mcrypt \
php-pear \
php-xml \
php-gd \
pcre-devel \
php-opcache \
php-apcu \
php-intl \
mod_php \
phpmyadmin

sudo systemctl restart httpd

# mysql
sudo yum -y install mysql-server
sudo systemctl enable mysqld
sudo systemctl start mysqld

ROOT_PASSWD=`sudo cat /var/log/mysqld.log | grep "A temporary password is generated for root@localhost" | awk '{print $11}'`
echo mysql root password: ${ROOT_PASSWD}

