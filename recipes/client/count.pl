use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");
my $selector = BSON->new();
my $count = $client->count("testdb", "myCollection", $selector);
print "Total documents in the collection: $count\n";

1;
