use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
$bson_obj->append_utf8('key', 'value');

eval { $bson_obj->DESTROY() };
ok(1, 'DESTROY cleaned up object');

done_testing();
