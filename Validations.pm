package Validations;

=head1 NAME

Validations - some validation methods

=head1 SYNOPSYS

 use Validations;
 Validations::is_positive_number( 1 );
 Validations::is_not_empty_string( 'test' );

=head1 METHODS

=over 4

=cut

use Data::Dumper;
use Modern::Perl;


=item B<is_scalar>( $scalar )

 Check if variable is a scalar

=cut

sub is_scalar {
    my @values = @_;

    if ( $#values != 0 ) {
        return 0;
    }

    if ( ref $values[0] or not defined $values[0]) {
        return 0;
    }

    return 1;
}

=item B<is_positive_number>( $value )

 Check if value is a positive real number

=cut

sub is_positive_number {
    my @values = @_;

    if ( not is_scalar( @values ) ) {
        return 0;
    }

    if ( $values[0] !~ /^\d*\.?\d+$/ ) {
        return 0;
    }

    if ( $values[0] <= 0 ) {
        return 0;
    }

    return 1;
}

=item B<is_in_array>( $value, $array_ref )

 Check if value is in array

=cut

sub is_in_array {
    my ( $value, $array_ref ) = @_;

    if ( not ref $array_ref ) {
        return 0;
    }

    if ( not is_scalar( $value ) ) {
        return 0;
    }

    if ( not grep { $_ eq $value } @{ $array_ref } ) {
        return 0;
    }

    return 1;
}

=item B<is_not_empty_string>( $value )

 Check if value is not a empty string

=cut

sub is_not_empty_string {
    my @values = @_;

    if ( not is_scalar( @values ) ) {
        return 0;
    }

    if ( length $values[0] <= 0 ) {
        return 0;
    }

    return 1;
}

=back

=cut

1;

