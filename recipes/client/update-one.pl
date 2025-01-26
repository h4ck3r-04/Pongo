use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");

my $selector = BSON->new();
$selector->append_utf8("name", "Alice");

my $update = BSON->new();
my $set = BSON->new();
$set->append_int32("age", 31);
$update->append_document("\$set", $set);

my $result = $client->update_one("testdb", "myCollection", $selector, $update);

1;
