use Test::Spec;
use Test::utf8;
use Modern::Perl;
use Data::Dumper;

use lib "../../";
use Validations;

# Testing is_not_empty_string

# Positive result

describe "Передаём в функцию не пустую строку -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 'test';
        my $expect = 1;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_not_empty_string( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 123;
        my $expect = 1;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_not_empty_string( $value );

        is( $actual, $expect );
    };
};

# Nagative reuslt

describe "Передаём в функцию пустую строку -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = "";
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_not_empty_string( $value );

        is( $actual, $expect );
    };
};

runtests unless caller;

