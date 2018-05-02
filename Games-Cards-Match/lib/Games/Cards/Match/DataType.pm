package Games::Cards::Match::DataType;

$Games::Cards::Match::DataType::VERSION   = '0.03';
$Games::Cards::Match::DataType::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match::DataType - Placeholder for parameters data type.

=head1 VERSION

Version 0.03

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>

=cut

use 5.006;
use strict; use warnings;

use Type::Library -base, -declare => qw(Color Shape Card Cards);
use Types::Standard qw(Str Object ArrayRef);
use Type::Utils;

my $COLOR = { 'R' => 1, 'B'  => 1, 'G' => 1, 'Y' => 1 };
my $SHAPE = { 'S' => 1, 'C'  => 1, 'T' => 1, 'O' => 1 };

declare 'Color',
    as Str,
    where   { exists $COLOR->{uc($_[0])} },
    message { "isa check for 'color' failed." };

declare 'Shape',
    as Str,
    where   { exists $SHAPE->{uc($_[0])} },
    message { "isa check for 'shape' failed." };

declare 'Card',
    as Object,
    where   { ref($_[0]) eq 'Games::Cards::Match::Card' };

declare 'Cards',
    as ArrayRef[Card],
    message { "isa check for 'cards' failed." };

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match::DataType
