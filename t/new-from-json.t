use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $json = '{"name": "Alice", "age": 30}';
my $bson_obj = BSON->new_from_json($json);
ok($bson_obj, 'Created BSON object from valid JSON');

my $json1 = '{"name": "Alice", "age": }';
eval { BSON->new_from_json($json1) };
like($@, qr/Error creating BSON from JSON/, 'new_from_json raised error for invalid JSON');

done_testing();
