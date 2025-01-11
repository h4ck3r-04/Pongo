use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client_ = PongoClient->new("mongodb://localhost:27017");

my $bson = PongoBSON->new();
$bson->append_utf8("name","Eric Doe" );
$bson->append_int32("age", 34);

$client_->insert_one("testdb", "myCollection", $bson);


1;
