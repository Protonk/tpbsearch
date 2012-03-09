#!/bin/bash

read word
grep $word ~/pbsearch/complete > ~/pbsearch/searchtext

R --no-restore --slave < ~/pbsearch/rsearch.R

rm -rf ~/pbsearch/searchtext

exit