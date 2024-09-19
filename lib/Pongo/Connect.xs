#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <mongoc/mongoc.h>

void connect_mongodb(const char* uri_string) {
    mongoc_client_t *client;
    mongoc_database_t *database;
    bson_t *ping_cmd;
    bson_error_t error;
    bool retval;

    mongoc_init();

    client = mongoc_client_new(uri_string);
    if (!client) {
        printf("Failed to create MongoDB client\n");
        return;
    }

    database = mongoc_client_get_database(client, "test");

    ping_cmd = BCON_NEW("ping", BCON_INT32(1));

    retval = mongoc_client_command_simple(client, "admin", ping_cmd, NULL, NULL, &error);

    if (retval) {
        printf("Connected to MongoDB successfully\n");
    } else {
        printf("Failed to connect to MongoDB: %s\n", error.message);
    }

    bson_destroy(ping_cmd);
    mongoc_database_destroy(database);
    mongoc_client_destroy(client);

    mongoc_cleanup();
}

MODULE = Pongo::Connect    PACKAGE = Pongo::Connect

void
connect(uri)
    char* uri
    CODE:
    connect_mongodb(uri);