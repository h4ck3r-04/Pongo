use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_int64('age', 25);
ok(1, 'append_int64 passed with valid input');

eval { $bson_obj->append_int64('age', 'not_a_number') };
like($@, qr/Value .* is not an integer/, 'append_int64 raised error with invalid input');

done_testing();