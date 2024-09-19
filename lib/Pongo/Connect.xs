#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include <mongocxx/client.hpp>
#include <mongocxx/instance.hpp>
#include <mongocxx/uri.hpp>
#include <mongocxx/exception/exception.hpp>

void connect_mongodb(const char* uri_string) {
    static mongocxx::instance instance{};
    try {
        mongocxx::uri uri(uri_string);
        mongocxx::client client(uri);
        mongocxx::database db = client["test"];

        // Check connection by running a ping command
        bsoncxx::stdx::optional<bsoncxx::document::value> result = db.run_command(
            bsoncxx::builder::stream::document{} << "ping" << 1 << bsoncxx::builder::stream::finalize
        );

        if (result) {
            printf("Connected to MongoDB successfully\n");
        } else {
            printf("Failed to connect to MongoDB\n");
        }
    } catch (const mongocxx::exception& e) {
        printf("MongoDB Connection Error: %s\n", e.what());
    }
}

MODULE = Pongo::Connect Package = Pongo::Connect
PROTOTYPES: ENABLE

void
connect(uri)
    char *uri
    CODE:
    connect_mongodb(uri)

