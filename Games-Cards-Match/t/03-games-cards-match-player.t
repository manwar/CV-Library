#!/usr/bin/perl

use Test::More tests => 9;
use Games::Cards::Match::Card;
use Games::Cards::Match::Player;
use Test::Exception;

throws_ok { Games::Cards::Match::Player->new() }
    qr/Missing required arguments/, 'no param G::C::M::P->new()';
throws_ok { Games::Cards::Match::Player->new('X') }
    qr/must be a HASH ref/, 'param G::C::M::P->new() must be a hash ref';
throws_ok { Games::Cards::Match::Player->new({}) }
    qr/Missing required arguments/, 'missing param G::C::M::P->new()';
throws_ok { Games::Cards::Match::Player->new({ a => 1 }) }
    qr/Missing required arguments/, 'missing param G::C::M::P->new()';
throws_ok { Games::Cards::Match::Player->new({ code => [1] }) }
    qr/did not pass type/, 'missing param G::C::M::P->new()';
lives_ok { Games::Cards::Match::Player->new({ code => 'P1' }) }
    'pass G::C::M::P->new()';
throws_ok { Games::Cards::Match::Player->new({ code => 'P1', cards => 'x' }) }
    qr/isa check/, 'failed isa check for cards';
throws_ok { Games::Cards::Match::Player->new({ code => 'P1', cards => ['x'] }) }
    qr/isa check/, 'failed isa check for cards';
lives_ok { Games::Cards::Match::Player->new({ code => 'P1', cards => [ Games::Cards::Match::Card->new({ color => 'R', shape => 'S' }) ] }) }
    'pass G::C::M::P->new()';
