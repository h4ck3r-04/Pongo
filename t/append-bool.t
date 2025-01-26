use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_bool('is_active', 1);
ok(1, 'append_bool passed with valid input (True)');

$bson_obj->append_bool('is_active', 0);
ok(1, 'append_bool passed with valid input (False)');

eval { $bson_obj->append_bool('is_active') };
like($@, qr/Value must be defined for a boolean/, 'append_bool raised error for undefined input');

done_testing();
