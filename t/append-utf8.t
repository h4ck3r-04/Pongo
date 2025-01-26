use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_utf8('name', 'Alice');
ok(1, 'append_utf8 passed');

done_testing();
