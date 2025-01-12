use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client_ = PongoClient->new("mongodb://localhost:27017");

my @array = (123, 45.6, "hello", 42);

my $bson = PongoBSON->new();
$bson->append_utf8("name","Eric Doe" );
$bson->append_int32("age", 34);
$bson->append_array("my_array_key", \@array);
$bson->append_double("my_double_key", 42.6);
$bson->append_bool("my_bool_key", 1);
my $manufacturer_bson = PongoBSON->new();
$manufacturer_bson->append_utf8("name", "Suzuki");

$bson->append_document("manufacturer", $manufacturer_bson);

$client_->insert_one("testdb", "myCollection", $bson);


1;
