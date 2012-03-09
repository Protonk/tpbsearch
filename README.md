# Local TPB search

Simple search using an R script. 

Your copy of magnet links may look like this:

    Steal This Film (Part 1 AND 2) | 701 Mb | 15/0 | 373b1794e9e73dbf206bce304a5900851193f285
    
There may be other values (e.g. the local id of the torrent). The script accepts a subset of the database from 1 string to the whole thing. It then formats it, ranks the torrents by number of seeds and displays the top 6 results as well as a magnet link (not just the hash) for the number one result.

The actual searching part is done in the terminal, not in R. So you can be as clever or as literal as you like.