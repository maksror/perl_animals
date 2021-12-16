use Test::Spec;
use Test::utf8;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Validations;

# Testing is_positive_number

# Positive result

describe "Передаём в функцию целое позитивное число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 1;
        my $expect = 1;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию вещественное позитивное число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 1.5;
        my $expect = 1;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию позитивное число в виде строки -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = "1.5";
        my $expect = 1;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

# Negative result

describe "Передаём в функцию целое негативное число -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = -1;
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию вещественное негативное число -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = -1;
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ноль -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = 0;
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию строку с символами -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = "test1";
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию пустую строку -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = "";
        my $expect = 0;

        Validations->expects( 'is_scalar' )->returns( 1 );

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

runtests unless caller;

