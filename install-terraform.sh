#!/bin/bash

version="$1"

os="$(uname -s | tr '[:upper:]' '[:lower:]')"

case $(uname -m) in
    x86_64)
        arch="amd64";;
    *)
        arch="386";;
esac


download_url="$(curl --silent https://releases.hashicorp.com/index.json \
    | jq -r "
            .terraform.versions[] |
            select(.version == \"$version\") |
            .builds[] |
            select(.os == \"$os\") |
            select(.arch == \"$arch\") |
            .url")"

echo $download_url

curl -o "/tmp/terraform-${version}.zip" "${download_url}"

unzip "/tmp/terraform-${version}.zip" -d ~/bin