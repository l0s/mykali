#!/bin/sh

docker build --no-cache -t mykali --secret id=password,src=password.txt .
