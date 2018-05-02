#!/usr/bin/perl

use Test::More tests => 5;
use Games::Cards::Match;
use Test::Exception;

lives_ok { Games::Cards::Match->new() } 'pass G::C::M->new()';
my $g = Games::Cards::Match->new;
my $p2 = $g->next_player;
is (ref($p2), 'Games::Cards::Match::Player', 'match player obj');
is ($p2->code, 'P2', 'match player code');
my $p1 = $g->next_player;
is (ref($p1), 'Games::Cards::Match::Player', 'match player obj');
is ($p1->code, 'P1', 'match player code');
