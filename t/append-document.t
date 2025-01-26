use strict;
use warnings;
use Test::More;
use Pongo::BSON;

my $sub_bson = BSON->new();
$sub_bson->append_utf8('city', 'New York');
my $bson_obj = BSON->new();
$bson_obj->append_document('address', $sub_bson);
ok(1, 'append_document passed with valid sub-document');

eval { $bson_obj->append_document('address', 'not_a_bson_object') };
like($@, qr/Invalid sub-document/, 'append_document raised error with invalid sub-document');

done_testing();
