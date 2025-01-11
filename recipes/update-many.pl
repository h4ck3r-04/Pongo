use strict;
use warnings;
use Pongo::Client;
use Pongo::BSON;

my $client = PongoClient->new("mongodb://localhost:27017");
my $updates = [
    {
        selector => { name => "Alice" },
        update   => { "\$set" => { age => 31 } }
    },
    {
        selector => { name => "Bob" },
        update   => { "\$set" => { age => 29 } }
    }
];

foreach my $update (@$updates) {
    my $selector = PongoBSON->new();
    foreach my $key (keys %{ $update->{selector} }) {
        my $value = $update->{selector}{$key};
        if ($value =~ /^\d+$/) {
            $selector->append_int32($key, $value);
        } else {
            $selector->append_utf8($key, $value);
        }
    }
    my $update_bson = PongoBSON->new();
    foreach my $operation (keys %{ $update->{update} }) {
        my $operation_doc = PongoBSON->new();
        foreach my $key (keys %{ $update->{update}{$operation} }) {
            my $value = $update->{update}{$operation}{$key};
            if ($value =~ /^\d+$/) {
                $operation_doc->append_int32($key, $value);
            } else {
                $operation_doc->append_utf8($key, $value);
            }
        }
        $update_bson->append_document($operation, $operation_doc);
    }
    my $result = $client->update_one("testdb", "myCollection", $selector, $update_bson);
    if ($result) {
        print "Update succeeded for selector: ", join(", ", map { "$_: $update->{selector}{$_}" } keys %{ $update->{selector} }), "\n";
    } else {
        warn "Update failed for selector: ", join(", ", map { "$_: $update->{selector}{$_}" } keys %{ $update->{selector} }), "\n";
    }
}

1;
