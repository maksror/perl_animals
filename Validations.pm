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

=item B<is_positive_number>( $value )

 Check if value is a positive real number

=cut

sub is_positive_number {
    my ( $value ) = @_;

    if ( ref $value or not defined $value ) {
        return 0;
    }

    if ( $value !~ /^\d*\.?\d+$/ ) {
        return 0;
    }

    return 1;
}

=item B<is_in_array>( $value, $array_ref )

 Check if value is in array

=cut

sub is_in_array {
    my ( $value, $array_ref ) = @_;

    if ( ref $value or not defined $value ) {
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
    my ( $value ) = @_;

    if ( ref $value or length $value < 1 ) {
        return 0;
    }

    return 1;
}

=back

=cut

1;

