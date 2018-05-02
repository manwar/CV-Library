package Games::Cards::Match::Card;

$Games::Cards::Match::Card::VERSION   = '0.03';
$Games::Cards::Match::Card::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match::Card - Object representation of a card.

=head1 VERSION

Version 0.03

=cut

use 5.006;
use Types::Standard qw(Int);
use Games::Cards::Match::DataType qw(Color Shape);

use Moo;
use namespace::autoclean;

use overload ( '""'  => \&as_string );

has 'index' => (is => 'rw', isa => Int);
has 'color' => (is => 'ro', isa => Color, required => 1);
has 'shape' => (is => 'ro', isa => Shape, required => 1);

=head1 DESCRIPTION

B<FOR INTERNAL USE ONLY>.

=head1 METHODS

=head2 is_same($card)

=cut

sub is_same {
    my ($self, $other) = @_;

    return 0 unless (defined($other) && (ref($other) eq 'Games::Cards::Match::Card'));

    return
        (
         (defined($self->{color})
          && (defined($other->{color}))
          && (lc($self->{color}) eq lc($other->{color}))
         )
         &&
         (defined($self->{shape})
          && (defined($other->{shape}))
          && (lc($self->{shape}) eq lc($other->{shape}))
         )
        )?(1):(0);
}

sub as_string {
    my ($self) = @_;

    return sprintf("%s|%s", $self->color, $self->shape);
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match::Card
