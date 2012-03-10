
# Drops lines w/ > 5 pipe chars
# as R takes too long to do this

while(<STDIN>) {
	my($line) = $_;
	if ($line =~ /^([^\|]*\|){5}[^\|]*$/)
	{
	print $line;
	}
}