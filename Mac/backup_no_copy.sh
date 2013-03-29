#!/bin/bash

# mac backup v 1.0
# tested with os x v 10.8.3
# version history
# 1.0:
# initial release
# - date/time as variable and included to export filename
# - Documents share to be backed up (only)
# - more maybe later with different destination name

# 1.1
# Added subdirs
# - /Users/jermu/Dropbox

# set variables

paivays=`date +%Y%m%d`
kello=`date +%H%M`

set -e

tar -czf /Users/jermu/backups/macbook-$paivays-$kello-Documents.tgz /Users/jermu/Documents/* /Users/jermu/Dropbox/*
