package Pongo::BSON;
use strict;
use warnings;
use Scalar::Util qw(looks_like_number);
require XSLoader;

XSLoader::load('Pongo::BSON', $Pongo::BSON);

{
    package BSON;
    use base 'Class::Accessor';

    __PACKAGE__->mk_accessors(qw(bson));

    sub new {
        my ($class) = @_;
        my $self = $class->SUPER::new();
        my $bson = Pongo::BSON::new();
        $self->bson($bson);
        return $self;
    }

    sub append_array {
        my ($self, $key, $array_ref, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value is not an array reference" unless ref($array_ref) eq 'ARRAY';
        Pongo::BSON::append_array($self->bson, $key, $key_length, $array_ref);
    }

    sub append_bool {
        my ($self, $key, $value, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value must be defined for a boolean" unless defined($value);
        my $bool_value = $value ? 1 : 0;
        Pongo::BSON::append_bool($self->bson, $key, $key_length, $bool_value);
    }

    sub append_utf8 {
        my ($self, $key, $value, $key_length, $value_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        $value_length = -1 unless defined $value_length;
        die "value_length must be a valid integer" unless $value_length  =~ /^-?\d+$/;
        Pongo::BSON::append_utf8($self->bson, $key, $key_length, $value, $value_length);
    }

    sub append_code {
        my ($self, $key, $javascript, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Javascript value is not defined" unless defined($javascript);
        Pongo::BSON::append_code($self->bson, $key, $key_length, $javascript);
    }

    sub append_date_time {
        my ($self, $key, $value, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value for date/time must be an integer" unless defined($value) && $value =~ /^-?\d+$/;
        Pongo::BSON::append_date_time($self->bson, $key, $key_length, $value);
    }

    sub append_int32 {
        my ($self, $key, $value, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value $value is not an integer" unless $value =~ /^-?\d+$/;
        Pongo::BSON::append_int32($self->bson, $key, $key_length, $value);
    }

    sub append_int64 {
        my ($self, $key, $value, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value $value is not an integer" unless $value =~ /^-?\d+$/;
        Pongo::BSON::append_int64($self->bson, $key, $key_length, $value);
    }

    sub append_double {
        my ($self, $key, $value, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Value $value is not a valid number" unless defined($value) && $value =~ /^-?\d+(\.\d+)?$/;
        Pongo::BSON::append_double($self->bson, $key, $key_length, $value);
    }

    sub append_document {
        my ($self, $key, $subdoc, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Invalid sub-document" unless $subdoc && $subdoc->isa('BSON');
        Pongo::BSON::append_document($self->bson, $key, $key_length, $subdoc->bson);
    }

    sub append_document_begin {
        my ($self, $key, $child, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        die "Invalid child" unless $child && $child->isa('BSON');
        Pongo::BSON::append_document_begin($self->bson, $key, $key_length, $child);
    }

    sub append_maxkey {
        my ($self, $key, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        return Pongo::BSON::append_maxkey($self->bson, $key, $key_length);
    }

    sub append_minkey {
        my ($self, $key, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        return Pongo::BSON::append_minkey($self->bson, $key, $key_length);
    }

    sub append_now_utc {
        my ($self, $key, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        return Pongo::BSON::append_now_utc($self->bson, $key, $key_length);
    }

    sub append_null() {
        my ($self, $key, $key_length) = @_;
        $key_length = -1 unless defined $key_length;
        die "key_length must be a valid integer" unless $key_length  =~ /^-?\d+$/;
        return Pongo::BSON::append_null($self->bson, $key, $key_length);
    }

    sub new_from_json {
        my ($class, $json_string) = @_;
        die "JSON string must be defined and non-empty" unless defined $json_string && $json_string ne '';
        my $error_message = '';
        my $bson = Pongo::BSON::new_from_json($json_string, length($json_string), $error_message);
        if (!$bson) {
            die "Error creating BSON from JSON: $error_message\n";
        }
        my $self = $class->SUPER::new();
        $self->bson($bson);
        return $self;
    }

    sub DESTROY {
        my $self = shift;
        if ($self->bson) {
            Pongo::BSON::destroy($self->bson);
        }
    }
}

1;