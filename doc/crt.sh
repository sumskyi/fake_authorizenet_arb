#!/bin/sh
CERTNAME=cherokee.pem
openssl req -days 1000 -new -x509 -nodes -out $CERTNAME -keyout $CERTNAME
chmod 600 $CERTNAME
openssl verify $CERTNAME
if [ $? != 0 ]; then
  \mv $CERTNAME $CERTNAME.not_valid
fi
