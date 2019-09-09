#!/bin/sh

set -e

drone lint
drone fmt --save
drone sign chakrit/phabricator --save
