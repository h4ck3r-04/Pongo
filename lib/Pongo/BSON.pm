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
        Pongo::BSON::append_int32($self->bson, $key, -1, $value);
    }

    sub append_document {
        my ($self, $key, $subdoc) = @_;
        die "Invalid sub-document" unless $subdoc && $subdoc->isa('PongoBSON');
        Pongo::BSON::append_document($self->bson, $key, -1, $subdoc->bson);
    }

    sub DESTROY {
        my $self = shift;
        if ($self->bson) {
            Pongo::BSON::destroy($self->bson);
        }
    }
}

1;