use strict;
use warnings;
use Pongo::Client;

my $client = PongoClient->new("mongodb://localhost:27017");
my $uri = $client->client_get_uri();
print $uri;