use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $bson_obj = BSON->new();
ok($bson_obj, 'Created BSON object');
isa_ok($bson_obj, 'BSON', 'Object is of class BSON');

done_testing();