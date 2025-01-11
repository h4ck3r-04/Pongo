use Pongo::CheckVersion;

my $minor_version = Pongo::CheckVersion::GetMongoMinorVersion();
print "MongoDB C Driver Minor Version: $minor_version\n";
