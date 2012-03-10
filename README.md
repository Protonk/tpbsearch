# Local TPB search

## Search

Simple search using an R script. 

Your copy of magnet links may look like this:

    Steal This Film (Part 1 AND 2) | 701 Mb | 15/0 | 373b1794e9e73dbf206bce304a5900851193f285
    
There may be other values (e.g. the local id of the torrent). The script accepts a subset of the database from 1 string to the whole thing. It then formats it, ranks the torrents by number of seeds and displays the top 6 results as well as a magnet link (not just the hash) for the number one result.

My copy of TPB can be found with `938802790A385C49307F34CCA4C30F80B03DF59` as the magnet hash. If you download that copy you should be able to reproduce my results completely.

The actual searching part is done in the terminal, not in R. So you can be as clever or as literal as you like.

## Statistics 

Also included is code to feed the whole database into R in order to perform some basic analysis (distribution of size, seeds, etc). R isn't really the best choice for text searching, so if you want to see which movies are torrented the most for a given snapshot then you will want to use a different program.

### Prepare

The particular database I used has "|" as the delimeter and not all lines have the same number of pipes. So we have a very short perl script to remove the offending lines and we can ingest the rest into R.

The settings on read.table are important, otherwise characters in the title string are interpreted as control or comment characters and you'll have a bad day. 