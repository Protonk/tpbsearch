#!/bin/bash

read word
grep $word ~/tpbsearch/complete > ~/tpbsearch/searchtext

R --no-restore --slave < ~/tpbsearch/tpbsearch.R

rm -rf ~/tpbsearch/searchtext

exit