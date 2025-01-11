# mongosh
# use testdb
# db.createCollection("myCollection")
# db.myCollection.insertOne({
#   name: "Product 1",
#   category: "Electronics",
#   price: 99,
#   description: "Affordable electronic product"
# });

# db.myCollection.insertOne({
#   name: "Product 2",
#   category: "Home Appliances",
#   price: 199,
#   description: "Useful home appliance"
# });

# db.myCollection.insertOne({
#   name: "Product 3",
#   category: "Electronics",
#   price: 499,
#   description: "High-end electronic gadget"
# });

# db.myCollection.insertOne({
#   name: "Product 4",
#   category: "Furniture",
#   price: 159,
#   description: "Comfortable and stylish furniture"
# });

# db.myCollection.insertOne({
#   name: "Product 5",
#   category: "Clothing",
#   price: 49,
#   description: "Stylish clothing item"
# });

use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");
my $result = $client->delete_all("testdb", "myCollection");

if ($result) {
    print "All documents deleted successfully.\n";
} else {
    warn "Failed to delete documents.\n";
}

1;
