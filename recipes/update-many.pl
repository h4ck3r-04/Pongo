use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");

my $updates = [
    {
        selector => {name => "Alice"},
        update => {"$set" => {age => 32}},
    },
    {
        selector => {name => "Bob"},
        update => {"$set" => {age => 45}},
    }
];

my $results = $client->update_many("test", "myCollection", $updates);

foreach my $result (@$results) {
    if ($result) {
        print "Document updated successfully!\n";
    } else {
        print "Failed to update document.\n";
    }
}

1;
