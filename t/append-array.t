use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_array('tags', ['perl', 'bson']);
ok(1, 'append_array passed with valid array reference');

eval { $bson_obj->append_array('tags', 'not_an_array') };
like($@, qr/Value is not an array reference/, 'append_array raised error with invalid input');

done_testing();
