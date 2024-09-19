package Pongo::Connect;

use strict;
use warnings;
require Exporter;
require DynaLoader;

our @ISA = qw(Exporter DynaLoader);
our @EXPORT = qw(connect);

our $VERSION = '1.0.0';

bootstrap Pongo::Connect $VERSION;

1;

__END__

=head1 NAME

Pongo::Connect - Perl interface to connect to MongoDB using C++ driver.

=head1 SYNOPSIS

    use Pongo::Connect;

    # MongoDB connection URI
    my $uri = "mongodb://localhost:27017";

    # Connect to MongoDB
    Pongo::Connect::connect($uri);

=head1 DESCRIPTION

Pongo::Connect wraps the MongoDB C++ driver and allows you to connect to a MongoDB instance from Perl.

=cut
