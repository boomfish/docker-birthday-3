#!/bin/sh

set -e -x

DOCKERMACHINE_CERTDIR="$HOME/.docker/machine/certs"
INTERLOCK_KEY_DIR="`dirname $0`/interlock/certs"
INTERLOCK_KEY_LENGTH=2048
INTERLOCK_KEY_DAYS=1080

DOCKERMACHINE_ALL="bday-a2 bday-a1 bday-p1 bday-p2 bday-m1"

mkdir -p "$INTERLOCK_KEY_DIR"

if [ -f "${INTERLOCK_KEY_DIR}/key.pem" -a -f "${INTERLOCK_KEY_DIR}/cert.pem" ]; then
	echo 'Interlock SSL keypair already exists'
	exit 0
fi

openssl genrsa -out "${INTERLOCK_KEY_DIR}/key.pem" $INTERLOCK_KEY_LENGTH

openssl req -new -subj "/O=interlock" -key "${INTERLOCK_KEY_DIR}/key.pem" -out "${INTERLOCK_KEY_DIR}/interlock.csr"
echo "extendedKeyUsage = clientAuth" > "${INTERLOCK_KEY_DIR}/extfile.cnf"

openssl x509 -req -days $INTERLOCK_KEY_DAYS -sha256 -in "${INTERLOCK_KEY_DIR}/interlock.csr" -CA "${DOCKERMACHINE_CERTDIR}/ca.pem" -CAkey "${DOCKERMACHINE_CERTDIR}/ca-key.pem" -CAcreateserial -out "${INTERLOCK_KEY_DIR}/cert.pem" -extfile "${INTERLOCK_KEY_DIR}/extfile.cnf"

rm "${INTERLOCK_KEY_DIR}/interlock.csr"


