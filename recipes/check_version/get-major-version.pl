use Pongo::CheckVersion;

my $major_version = Pongo::CheckVersion::GetMongoMajorVersion();
print "MongoDB C Driver Major Version: $major_version\n";
