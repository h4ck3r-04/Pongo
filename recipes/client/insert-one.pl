use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client_ = PongoClient->new("mongodb://localhost:27017");
my $json_string = q|{
    "name": "Eric Doe",
    "age": 34,
    "details": {
        "address": {
            "street": "123 Maple Street",
            "city": "Somewhere",
            "postal_code": "12345"
        },
        "phones": ["123-456-7890", "987-654-3210"]
    },
    "preferences": {
        "newsletter": true,
        "notifications": {
            "email": false,
            "sms": true
        }
    },
    "purchases": [
        {"item": "Laptop", "price": 1200.50, "currency": "USD"},
        {"item": "Headphones", "price": 150.00, "currency": "USD"}
    ],
    "tags": ["electronics", "music", "shopping"]
}|;

my $bson;
eval {
    $bson = BSON->new_from_json($json_string);
};
if ($@) {
    die "Failed to create BSON from JSON: $@\n";
}

eval {
    $client_->insert_one("testdb", "myCollection", $bson);
};
if ($@) {
    die "Failed to insert document into MongoDB: $@\n";
}

print "Document inserted successfully into MongoDB!\n";

1;
