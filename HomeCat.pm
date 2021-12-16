package HomeCat;

=head1 NAME

HomeCat - class for describe a home cat

=head1 SYNOPSYS

 use HomeCat;
 my $home_cat = HomeCat->new( %attr );
 $HomeCat->eat( 'meat' );

=head1 METHODS

=over 4

=cut

use lib "./";
use Validations;
use Animal;
use Data::Dumper;
use Carp;
use Modern::Perl;

use base qw( Cat );

=item B<new>( %attr )

 create new object

 %attr : weight*, height*, sex*, name*, owner*, sound, fur_length, night_vision
    weight       - positive real number
    height       - positive real number
    sex          - male, female
    name         - not empty string
    owner        - not empty string
    sound        - not empty string
    fur_length   - short, medium, long
    night_vision - perfect, good, medium, low

 returns : a new Cat object

=cut

sub new {
    my ( $class, %param ) = @_;

    # Check of mandatory attributes for home cat
    if ( not exists $param{name} or not Validations::is_not_empty_string( $param{name} ) ) {
        confess "A home cat should have a name";
    }

    if ( not exists $param{owner} or not Validations::is_not_empty_string( $param{owner} ) ) {
        confess "A home cat should have an owner";
    }

    my @mandatory_home_cat_attributes = qw/ name owner /;

    my %cat_param;
    for my $attribute ( keys %param ) {
        if ( not Validations::is_in_array( $attribute, \@mandatory_home_cat_attributes ) ) {
            $cat_param{ $attribute } = $param{ $attribute };
            delete $param{ $attribute };
        }
    }

    my $home_cat = $class->SUPER::new( %cat_param );

    for my $attribute ( keys %param ) {
        $home_cat->{$attribute} = $param{$attribute};
    }

    return $home_cat;
}

=item B<play>

 play with your cat

=cut

sub play {
    my ( $self ) = @_;

    print( $self->get_name . " plays with his owner " . $self->{owner} . "\n" );
}

=item B<sleep>( $hours )

 send the home cat to sleep with you

 $hours - positive real number(less that 12)

=cut

sub sleep {
    my ( $self, $hours ) = @_;

    if ( not Validations::is_positive_number( $hours ) ) {
        confess "Wrong number of hours of sleep";
    }
    elsif ( $hours > 12 ) {
        confess "Too many hours for sleep";
    }

    print( $self->get_name, " goes to sleep $hours hours with " . $self->{owner} . "\n" );
}

=back

=cut

1;

