use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_double('height', 5.9);
ok(1, 'append_double passed with valid input');

eval { $bson_obj->append_double('height', 'not_a_number') };
like($@, qr/Value not_a_number is not a valid number/, 'append_double raised error with invalid input');

done_testing();
