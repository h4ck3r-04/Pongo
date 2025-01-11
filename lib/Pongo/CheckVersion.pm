package Pongo::CheckVersion;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
require XSLoader;

XSLoader::load('Pongo::CheckVersion', $Pongo::VERSION);

sub MongoCheckVersion {
    my ($required_major, $required_minor, $required_micro) = @_;
    die "Value $required_major is not an integer" unless  $required_major =~ /^-?\d+$/;
    die "Value $required_minor is not an integer" unless  $required_minor =~ /^-?\d+$/;
    die "Value $required_micro is not an integer" unless  $required_micro =~ /^-?\d+$/;
    my $compatible = Pongo::CheckVersion::get_mongoc_check_version($required_major, $required_minor, $required_micro);
    return defined($compatible) && $compatible ? 1 : 0;
}

sub GetMongoMajorVersion {
    my $major = Pongo::CheckVersion::get_mongoc_major_version();
    return $major;
}

sub GetMongoMinorVersion {
    my $minor = Pongo::CheckVersion::get_mongoc_minor_version();
    return $minor;
}

sub GetMongoMicroVersion {
    my $micro = Pongo::CheckVersion::get_mongoc_micro_version();
    return $micro;
}

sub GetMongoVersion {
    my $version = Pongo::CheckVersion::get_mongoc_version();
    return $version;
}

1;