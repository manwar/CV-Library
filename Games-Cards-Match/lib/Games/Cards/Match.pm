package Games::Cards::Match;

$Games::Cards::Match::VERSION   = '0.03';
$Games::Cards::Match::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Games::Cards::Match - Interface to the Match Card Game.

=head1 VERSION

Version 0.03

=cut

use 5.006;
use List::Util qw(shuffle);
use Types::Standard qw(Bool);
use Games::Cards::Match::Card;
use Games::Cards::Match::Player;
use Games::Cards::Match::DataType qw(Cards);

use Moo;
use namespace::autoclean;

has 'active'    => (is => 'rw');
has 'board'     => (is => 'rw');
has 'player1'   => (is => 'rw');
has 'player2'   => (is => 'rw');
has 'available' => (is => 'ro', isa => Cards);

sub BUILD {
    my ($self) = @_;

    my $cards = [];
    foreach (1..2) {
        foreach my $color (qw(R B G Y)) {
            foreach my $shape (qw(S C T O)) {
                push @$cards, Games::Cards::Match::Card->new({ color => $color, shape => $shape });
            }
        }
    }

    $self->{available} = [shuffle @{$cards}];
    $self->{player1}   = Games::Cards::Match::Player->new({ code => 'P1' });
    $self->{player2}   = Games::Cards::Match::Player->new({ code => 'P2' });
    $self->{active}    = $self->{player1};

    $self->_arrange_cards;
}

=head1 DESCRIPTION

This work is done in response to the CV-Library selection process.

=head1 METHODS

=head2 play()

Start the game.

=cut

sub play {
    my ($self) = @_;

    my $found_matching = 1;
    while ($found_matching) {
        my $card1 = $self->pick_card;
        my $card2 = $self->pick_card;
        if (defined $card1
            && defined $card2
            && $card1->is_same($card2)) {
            $self->{active}->save([$card1, $card2]);
            $self->remove_cards($card1, $card2);
            print {*STDOUT} "M";
        }
        else {
            print {*STDOUT} ".";
            $self->add_cards($card1, $card2);
            $found_matching = 0;
        }

        if ($self->is_over) {
            print {*STDOUT} "\n\n";
            return;
        }
    }
}

=head2 remaining_cards()

Returns list of index where card still present.

=cut

sub remaining_cards {
    my ($self) = @_;

    my @remaining_cards = ();
    foreach my $index (keys %{$self->{board}}) {
        if (defined $self->{board}->{$index}) {
            push @remaining_cards, $index;
        }
    }

    return @remaining_cards;
}

=head2 pick_card()

Pick random card from the board and return.

=cut

sub pick_card {
    my ($self) = @_;

    my @remaining_cards = $self->remaining_cards;
    foreach my $index (keys %{$self->{board}}) {
        if (defined $self->{board}->{$index}) {
            push @remaining_cards, $index;
        }
    }

    my $card;
    while (!defined $card) {
        my $index = $remaining_cards[ rand @remaining_cards ];
        $card = $self->{board}->{$index};
    }

    $self->{board}->{$card->index} = undef;
    return $card;
}

=head2 remove_cards($card1, $card2)

Remove the given cards from the board.

=cut

sub remove_cards {
    my ($self, $card1, $card2) = @_;

    $self->{board}->{$card1->index} = undef;
    $self->{board}->{$card2->index} = undef;
}

=head2 add_cards($card1, $card2)

Put the given cards back to the board where it was before.

=cut

sub add_cards {
    my ($self, $card1, $card2) = @_;

    $self->{board}->{$card1->index} = $card1;
    $self->{board}->{$card2->index} = $card2;
}

=head2 next_player()

Make next player active.

=cut

sub next_player {
    my ($self) = @_;

    if ($self->active->code eq 'P1') {
        $self->active($self->{player2});
    }
    else {
        $self->active($self->{player1});
    }
}

=head2 is_over()

Returns 1 or 0 depending if the deck is empty or not.

=cut

sub is_over {
    my ($self) = @_;

    my @remaining_cards = $self->remaining_cards;
    return (scalar(@remaining_cards) == 0);
}

=head2 final_score()

Returns the final score.

=cut

sub final_score {
    my ($self) = @_;

    my $player1 = $self->{player1}->score;
    my $player2 = $self->{player2}->score;
    return sprintf("[P1]: %d\n[P2]: %d\n\n", $player1, $player2);
}

=head2 result()

Declare the result.

=cut

sub result {
    my ($self) = @_;

    my $player1 = $self->{player1}->score;
    my $player2 = $self->{player2}->score;
    if ($player1 > $player2) {
        return "Player 1 (P1) is the winner, congratulations.";
    }
    elsif ($player1 < $player2) {
        return "Player 2 (P2) is the winner, congratulations.";
    }
    else {
        return "Game drawn.";
    }
}

=head2 show_board()

Return the game board.

=cut

sub show_board {
    my ($self, $hide) = @_;

    my $deck = '';
    foreach my $index (sort { $a <=> $b } keys %{$self->{board}}) {
        my $card = $self->{board}->{$index};
        my $c = '   ';
        if (defined $card) {
            if ($hide) {
                $c = $index;
            }
            else {
                $c = $card->as_string;
            }
        }

        $deck .= sprintf("[ %3s ]", $c);
        $deck .= "\n" if ($index % 8 == 0);
    }

    return $deck;
}

#
#
# PRIVATE METHODS

sub _arrange_cards {
    my ($self) = @_;

    my $cards = $self->{available};
    my $index = 0;
    foreach my $card (@{$cards}) {
        $index++;
        $card->index($index);
        $self->{board}->{$index} = $card;
        last if (@$cards == $index);
    }
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=cut

1; # End of Games::Cards::Match
