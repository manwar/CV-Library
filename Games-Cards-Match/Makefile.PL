use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'Games::Cards::Match',
    AUTHOR             => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM       => 'lib/Games/Cards/Match.pm',
    ABSTRACT_FROM      => 'lib/Games/Cards/Match.pm',
    LICENSE            => 'artistic_2',
    EXE_FILES          => [ 'script/play-cards-match' ],
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More'      => 0,
        'Test::Exception' => 0,
    },
    PREREQ_PM => {
        'List::Util'           => '1.19',
        'Moo'                  => '2.000000',
        'MooX::Options'        => '4.023',
        'namespace::autoclean' => '0.28',
        'Type::Tiny'           => '1.000005',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Games-Cards-Match-*' },
);
