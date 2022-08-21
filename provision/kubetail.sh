#!/bin/bash

set -eux -o pipefail

apt update

apt install -y kubetail