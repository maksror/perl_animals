package Cat;

=head1 NAME

Cat - class for describe a cat

=head1 SYNOPSYS

 use Cat;
 my $cat = Cat->new( %attr );
 $cat->eat( 'meat' );

=head1 METHODS

=over 4

=cut

use lib "./";
use Validations;
use Animal;
use Data::Dumper;
use Carp;
use Modern::Perl;

use base qw( Animal );

=item B<new>( %attr )

 create new object

 %attr : weight*, height*, sex*, name, sound, fur_length, night_vision
    weight       - positive real number
    height       - positive real number
    sex          - male, female
    name         - not empty string
    sound        - not empty string
    fur_length   - short, medium, long
    night_vision - perfect, good, medium, low

 returns : a new Cat object

=cut

sub new {
    my ( $class, %param ) = @_;

    my @expected_animal_attributes = qw/ weight height sex name sound /;
    my @expected_cats_attributes   = qw/ fur_length night_vision /;

    my %animal_param;

    for my $attribute ( @expected_animal_attributes ) {
        if ( exists $param{ $attribute } ) {
            $animal_param{ $attribute } = $param{ $attribute };
            delete $param{ $attribute };
        }
    }

    # Check additional(cat's) attributes
    for my $attribute ( keys %param ) {
        if ( not Validations::is_in_array( $attribute, \@expected_cats_attributes ) ) {
            confess "Invalid attribute '$attribute'";
        }
    }

    my $cat = $class->SUPER::new( %animal_param );

    # Replace cat's sound
    $cat->{sound} = 'meow';

    # Validate cat's unique attributes
    if ( 
        exists $param{fur_length} 
        and not Validations::is_in_array( $param{fur_length}, [ 'short', 'medium', 'long' ] ) 
    ) {
        confess "Invalid fur lenght";
    }
    else {
        $cat->{fur_length} = $param{fur_length} if exists $param{fur_length};
    }

    if ( 
        exists $param{night_vision} 
        and not Validations::is_in_array( $param{night_vision}, [ 'perfect', 'good', 'medium', 'low' ] ) 
    ) {
        confess "Invalid night vision";
    }
    else {
        $cat->{night_vision} = $param{night_vision} if exists $param{night_vision};
    }

    return $cat;
}

=item B<eat>( $food )

 give food to the animal

 $food - string

=cut

sub eat {
    my ( $self, $food ) = @_;

    $self->SUPER::eat( $food );

    my $class = ref $self ? ref $self : 'Cat';

    print( "While eating, the $class started rumbling\n" );
}


=back

=cut

1;

