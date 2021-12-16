use Test::Spec;
use Test::utf8;
use Modern::Perl;
use Data::Dumper;

use lib "../../";
use Validations;

# Testing is_scalar

# Positive result

describe "Передаём в функцию число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 1;
        my $expect = 1;

        my $actual = Validations::is_scalar( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию строку -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = "test";
        my $expect = 1;

        my $actual = Validations::is_scalar( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию пустую строку -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = "";
        my $expect = 1;

        my $actual = Validations::is_scalar( $value );

        is( $actual, $expect );
    };
};

# Negaive result

describe "Передаём в функцию массив -" => sub {
    it "должна вернуть 0" => sub {
        my @values = qw/ 1 2 3 /;
        my $expect = 0;

        my $actual = Validations::is_scalar( @values );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию хэш -" => sub {
    it "должна вернуть 0" => sub {
        my %value  = ( 1 => 1, 2 => 2 );
        my $expect = 0;

        my $actual = Validations::is_scalar( %value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ссылку на массив -" => sub {
    it "должна вернуть 0" => sub {
        my @values = qw/ 1 2 3 /;
        my $expect = 0;

        my $actual = Validations::is_scalar( \@values );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ссылку на хэш -" => sub {
    it "должна вернуть 0" => sub {
        my %value  = ( 1 => 1, 2 => 2 );
        my $expect = 0;

        my $actual = Validations::is_scalar( \%value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию undef -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = undef;
        my $expect = 0;

        my $actual = Validations::is_scalar( $value );

        is( $actual, $expect );
    };
};

runtests unless caller;

