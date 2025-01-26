use strict;
use warnings;

use Pongo::BSON;
my $json_string = '{"name": "Alice", "age": 30}';
my $bson_obj;
eval {
    $bson_obj = BSON->new_from_json($json_string);
};
if ($@) {
    die "Failed to create BSON object: $@\n";
}

print "BSON object created successfully!\n";
undef $bson_obj