#!/bin/sh

docker build -t mykali --secret id=password,src=password.txt .
