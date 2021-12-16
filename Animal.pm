package Animal;

=head1 NAME

Animal - class for describe basic animal

=head1 SYNOPSYS

 use Animal;
 my $animal = Animal->new( %attr );
 $animal->eat( 'meat' );

=head1 METHODS

=over 4

=cut

use lib "./";
use Validations;
use Data::Dumper;
use Modern::Perl;
use Carp;


=item B<new>( %attr )

 create new object

 %attr : weight*, height*, sex*, name, sound
    weight - positive real number
    height - positive real number
    sex    - male, female
    name   - not empty string
    sound  - not empty string

 returns : a new Animal object

=cut

sub new {
    my ( $class, %param ) = @_;

    my @expected_animal_attributes = qw/ weight height sex name sound /;

    # Attribute validation
    for my $attribute ( keys %param ) {
        if ( not Validations::is_in_array( $attribute, \@expected_animal_attributes ) ) {
            confess "Invalid attribute '$attribute'";
        }
    }

    if ( not Validations::is_positive_number( $param{weight} ) ) {
        confess "Invalid weight";
    }

    if ( not Validations::is_positive_number( $param{height} ) ) {
        confess "Invalid height";
    }

    if ( not Validations::is_in_array( $param{sex}, [ 'male', 'female'] ) ) {
        confess "Invalid sex";
    }

    if ( exists $param{sound} and not Validations::is_not_empty_string( $param{sound} ) ) {
        confess "Invalid sound";
    }

    if ( exists $param{name} and not Validations::is_not_empty_string( $param{name} ) ) {
        confess "Invalid name";
    }

    bless \%param, $class;
    return \%param;
}

=item B<get_name>

 get animal name

 returns : name or string "class_name without name"

=cut

sub get_name {
    my ( $self ) = @_;

    if ( ref $self ) {
        if ( defined $self->{name} ) {
            return $self->{name};
        }
        else {
            my $class_name = ref $self;
            return "$class_name without name";
        }
    }
    else {
        return "$self without name";
    }
}

=item B<get_sound>

 get animal sound

 returns : sound or undef

=cut

sub get_sound {
    my ( $self ) = @_;

    if ( ref $self ) {
        return $self->{sound};
    }
    else {
        return undef;
    }
}

=item B<eat>( $food )

 give food to the animal

 $food - string

=cut

sub eat {
    my ( $self, $food ) = @_;

    if ( not Validations::is_not_empty_string( $food ) ) {
        confess "Wrong food";
    }

    print( $self->get_name . " goes to eat $food\n" );
}

=item B<sleep>( $hours )

 send the animal to sleep

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

    print( $self->get_name, " goes to sleep $hours hours\n" );
}

=item B<poop>( $place )

 Send an animal to the toilet

 $place - string

=cut

sub poop {
    my ( $self, $place ) = @_;

    if ( not Validations::is_not_empty_string( $place ) ) {
        confess "Wrong place";
    }

    print( $self->get_name, " goes to poop on the $place\n" );
}

=item B<speak>

 Make the animal make a sound

=cut

sub speak {
    my ( $self ) = @_;

    if ( defined $self->get_sound ) {
        print( $self->get_name, " say ", $self->get_sound, "\n" );
    }
    else {
        print( $self->get_name, " can't speak\n" );
    }
}

=back

=cut

1;

