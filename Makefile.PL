use 5.008005;
use ExtUtils::MakeMaker 7.12;

WriteMakefile(
  NAME           => 'Pongo',
  VERSION_FROM   => 'lib/Pongo.pm',
  PREREQ_PM      => { 'ExtUtils::MakeMaker' => '7.12' },
  ABSTRACT_FROM  => 'lib/Pongo.pm',
  AUTHOR         => 'Rudraditya Thakur',
  CCFLAGS        => '-Wall -std=c99 -I/usr/local/include/libmongoc-1.0 -I/usr/local/include/libbson-1.0',
  OPTIMIZE       => '-O3',
  LICENSE        => 'Apache License 2.0',
  XSMULTI        => 1,
);