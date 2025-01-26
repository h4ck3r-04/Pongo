use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");

my $bson1 = BSON->new();
$bson1->append_utf8("name", "Alice");
$bson1->append_int32("age", 30);

my $bson2 = BSON->new();
$bson2->append_utf8("name", "Bob");
$bson2->append_int32("age", 24);

$client->insert_many("testdb", "myCollection", [$bson1, $bson2]);

1;