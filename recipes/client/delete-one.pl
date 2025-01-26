# mongosh
# use testdb
# db.createCollection("myCollection")
# db.myCollection.insertOne({ name: "John Doe", age: 30, email: "john.doe@example.com" })

use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");
my $selector = BSON->new();
$selector->append_utf8("name", "Alice");
my $result = $client->delete_one("testdb", "myCollection", $selector);

1;