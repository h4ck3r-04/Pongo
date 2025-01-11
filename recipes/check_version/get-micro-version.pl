use Pongo::CheckVersion;

my $micro_version = Pongo::CheckVersion::GetMongoMicroVersion();
print "MongoDB C Driver Micro Version: $micro_version\n";
