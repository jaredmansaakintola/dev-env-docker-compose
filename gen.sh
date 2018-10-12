#!/usr/bin/env bash

thrift --gen php $1
thrift --gen py:utf8strings $1
