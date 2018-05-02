#!/usr/bin/perl

use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More tests => 4;

BEGIN {
    use_ok('Games::Cards::Match')           || print "Bail out!\n";
    use_ok('Games::Cards::Match::Card')     || print "Bail out!\n";
    use_ok('Games::Cards::Match::Player')   || print "Bail out!\n";
    use_ok('Games::Cards::Match::DataType') || print "Bail out!\n";
}

diag("Testing Games::Cards::Match $Games::Cards::Match::VERSION, Perl $], $^X");
