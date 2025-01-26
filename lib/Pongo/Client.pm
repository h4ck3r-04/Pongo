package Pongo::Client;
use strict;
use warnings;
use Pongo::BSON;
require XSLoader;

XSLoader::load('Pongo::Client', $Pongo::VERSION);

{
  package PongoClient;
  use base 'Class::Accessor';
  __PACKAGE__->mk_accessors(qw(client collection uri));

  sub new {
    my ($class, $uri) = @_;
    my $self = $class->SUPER::new();
    my $client;
    if (ref($uri) eq 'BSON') {
      my $uri_str = $uri->to_str();
      $client = Pongo::Client::client_new_from_uri($uri_str);
    }
    else {
      $client = Pongo::Client::client_new($uri);
    }
    if (!$client) {
      die "Failed to create client with the URI";
    }
    $self->client($client);
    $self->uri($uri);
    return $self;
  }

  sub get_collection {
    my ($self, $db_name, $collection_name) = @_;
    my $collection = Pongo::Client::client_get_collection($self->client, $db_name, $collection_name);
    return $collection;
  }

  sub destroy_collection {
    my ($self, $collection) = @_;
    Pongo::Client::collection_destroy($collection);
  }

  sub get_cursor {
    my ($self, $db_name, $collection_name, $query, $limit) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $cursor = Pongo::Client::collection_find($collection, 0, 0, $limit || 0, 0, $query, BSON->new(), undef);
    return $cursor;
  }

  sub destroy_cursor {
    my ($self, $cursor, $collection) = @_;
    Pongo::Client::cursor_destroy($cursor);
    $self->destroy_collection($collection);
  }

  sub count {
    my ($self, $db_name, $collection_name, $selector) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $count_ = Pongo::Client::collection_count($collection, 0, $selector, 0, 0, undef, undef);
    $self->destroy_collection($collection);
    return $count_;
  }

  sub insert_one {
    my ($self, $db_name, $collection_name, $bson) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    Pongo::Client::collection_insert_one($collection, $bson->bson, undef, undef, undef);
    $self->destroy_collection($collection);
  }

  sub insert_many {
    my ($self, $db_name, $collection_name, $bson_objects) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    foreach my $bson (@$bson_objects) {
      Pongo::Client::collection_insert_one($collection, $bson->bson, undef, undef, undef);
    }
    $self->destroy_collection($collection);
  }

  sub update_one {
    my ($self, $db_name, $collection_name, $selector, $update) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $result = Pongo::Client::collection_update_one($collection, $selector->bson, $update->bson, undef, undef, undef);
    $self->destroy_collection($collection);
    return $result;
  }

  sub update_many {
    my ($self, $db_name, $collection_name, $updates) = @_;
    unless (ref($updates) eq 'ARRAY') {
      die "Updates must be an array reference";
    }
    my $results = [];
    foreach my $update (@$updates) {
      unless (exists $update->{selector} && exists $update->{update}) {
        die "Each update must contain a selector and an update operation";
      }
      my $selector = BSON->new();
      foreach my $key (keys %{$update->{selector}}) {
        my $value = $update->{selector}{$key};
        if ($value =~ /^d\+$/) {
          $selector->append_int32($key, $value);
        } else {
          $selector->append_utf8($key, $value);
        }
      }
      my $update_bson = BSON->new();
      foreach my $operation (keys %{$update->{update}}) {
        my $operation_doc = BSON->new();
        foreach my $key (keys %{$update->{update}{$operation}}) {
          my $value = $update->{update}{$operation}{$key};
          if ($value =~ /^\d+$/) {
            $operation_doc->append_int32($key, $value);
          } else {
            $operation_doc->append_utf8($key, $value);
          }
        }
        $update_bson->append_document($operation, $operation_doc);
      }
      my $result = $self->update_one($db_name, $collection_name, $selector, $update_bson);
      push @$results, $result;
      unless ($result) {
        warn "Failed to update document with selector: ".join(", ", map{ "$_: $update->{selector}{$_}" } keys %{ $update->{selector} });
      }
      return $results;
    }
  }

  sub delete_one {
    my ($self, $db_name, $collection_name, $selector) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $result = Pongo::Client::collection_delete_one($collection, $selector->bson, undef, undef, undef);
    $self->destroy_collection($collection);
    return $result;
  }

  sub delete_many {
    my ($self, $db_name, $collection_name, $selector) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $result = Pongo::Client::collection_delete_many($collection, $selector->bson, undef, undef, undef);
    $self->destroy_collection($collection);
    return $result;
  }

  sub delete_all {
    my ($self, $db_name, $collection_name) = @_;
    my $collection = $self->get_collection($db_name, $collection_name);
    my $query = BSON->new();
    my $result = $self->delete_many($db_name, $collection_name, $query);
    return $result;
  }

  sub DESTROY {
    my $self = shift;
    if ($self->client) {
      Pongo::Client::client_destroy($self->client);
    }
  }
}

1;