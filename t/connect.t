use strict;
use warnings;
use Test::More tests=>2;
use Pongo::Connect;

# Test 1: Ensure that the module loads
use_ok('Pongo::Connect');

# Test 2: Test MongoDB connection
my $uri = "mongodb://localhost:27017";
eval {
    Pongo::Connect::connect($uri);
};
if ($@) {
    fail("Connection to MongoDB failed: $@");
} else {
    pass("Connected to MongoDB successfully");
}