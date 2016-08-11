#!/bin/sh

set -e -x

INTERLOCK_KEY_DIR="`dirname $0`/interlock/certs"

rm -f "${INTERLOCK_KEY_DIR}/key.pem" "${INTERLOCK_KEY_DIR}/cert.pem"
