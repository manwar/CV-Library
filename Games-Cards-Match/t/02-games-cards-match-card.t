#!/usr/bin/perl

use Test::More tests => 10;
use Games::Cards::Match::Card;
use Test::Exception;

throws_ok { Games::Cards::Match::Card->new() }
    qr/Missing required arguments/, 'no param G::C::M::C->new()';
throws_ok { Games::Cards::Match::Card->new('X') }
    qr/must be a HASH ref/, 'param G::C::M::C->new() must be hashref';
throws_ok { Games::Cards::Match::Card->new({}) }
    qr/Missing required arguments/, 'missing param G::C::M::C->new()';
throws_ok { Games::Cards::Match::Card->new({ a => 1 }) }
    qr/Missing required arguments/, 'missing param G::C::M::C->new()';
throws_ok { Games::Cards::Match::Card->new({ color => 1 }) }
    qr/Missing required arguments/, 'missing param G::C::M::C->new()';
throws_ok { Games::Cards::Match::Card->new({ color => 1, shape => 2 }) }
    qr/isa check/, 'failed isa check for color';
throws_ok { Games::Cards::Match::Card->new({ color => 'R', shape => 2 }) }
    qr/isa check/, 'failed isa check for shape';
lives_ok { Games::Cards::Match::Card->new({ color => 'R', shape => 'S' }) }
    'pass G::C::M::C->new';
my $c1 = Games::Cards::Match::Card->new({ color => 'R', shape => 'S' });
my $c2 = Games::Cards::Match::Card->new({ color => 'R', shape => 'S' });
my $c3 = Games::Cards::Match::Card->new({ color => 'R', shape => 'T' });
is ($c1->is_same($c2), 1, 'card matched');
is ($c1->is_same($c3), 0, 'card mismatched');
