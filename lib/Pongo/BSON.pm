package Pongo::BSON;
use strict;
use warnings;
require XSLoader;

XSLoader::load('Pongo::BSON', $Pongo::BSON);

{
    package PongoBSON;
    use base 'Class::Accessor';

    __PACKAGE__->mk_accessors(qw(bson));

    sub new {
        my ($class) = @_;
        my $self = $class->SUPER::new();
        my $bson = Pongo::BSON::new();
        $self->bson($bson);
        return $self;
    }

    sub append_utf8 {
        my ($self, $key, $value) = @_;
        Pongo::BSON::append_utf8($self->bson, $key, -1, $value, -1);
    }

    sub append_int32 {
        my ($self, $key, $value) = @_;
        die "Value $value is not an integer" unless  $value =~ /^-?\d+$/;
        Pongo::BSON::append_int32($self->bson, $key, -1, $value);
    }

    sub append_double {
        my ($self, $key, $value) = @_;
        die "Value $value is not a valid number" unless defined($value) && $value =~ /^-?\d+(\.\d+)?$/;
        Pongo::BSON::append_double($self->bson, $key, -1, $value);
    }

    sub append_bool {
        my ($self, $key, $value) = @_;
        die "Value must be defined for a boolean" unless defined($value);
        my $bool_value = $value ? 1 : 0;
        Pongo::BSON::append_bool($self->bson, $key, -1, $bool_value);
    }

    sub append_document {
        my ($self, $key, $subdoc) = @_;
        die "Invalid sub-document" unless $subdoc && $subdoc->isa('PongoBSON');
        Pongo::BSON::append_document($self->bson, $key, -1, $subdoc->bson);
    }

    sub append_array {
        my ($self, $key, $array_ref) = @_;
        die "Value is not an array reference" unless ref($array_ref) eq 'ARRAY';
        Pongo::BSON::append_array($self->bson, $key, -1, $array_ref);
    }

    sub DESTROY {
        my $self = shift;
        if ($self->bson) {
            Pongo::BSON::destroy($self->bson);
        }
    }
}

1;