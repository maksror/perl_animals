use Test::Spec;
use Test::utf8;
use Modern::Perl;
use Data::Dumper;

use lib "../../";
use Validations;

# Testing is_positive_number

# Positive result
describe "Передаём в функцию целое позитивное число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 1;
        my $expect = 1;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию вещественное позитивное число -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = 1.5;
        my $expect = 1;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию позитивное число в виде строки -" => sub {
    it "должна вернуть 1" => sub {
        my $value  = "1.5";
        my $expect = 1;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

# Negative result
describe "Передаём в функцию целое негативное число -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = -1;
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию вещественное негативное число -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = -1;
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ноль -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = 0;
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ссылку на массив с числами -" => sub {
    it "должна вернуть 0" => sub {
        my @value  = ( 1, 2, 3 );
        my $expect = 0;

        my $actual = Validations::is_positive_number( \@value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию ссылку на хэш -" => sub {
    it "должна вернуть 0" => sub {
        my %value  = ( 1 => 1 );
        my $expect = 0;

        my $actual = Validations::is_positive_number( \%value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию массив с числами -" => sub {
    it "должна вернуть 0" => sub {
        my @value  = ( 3, 2, 3 );
        my $expect = 0;

        my $actual = Validations::is_positive_number( @value );

        is( $actual, $expect );
    };
};


describe "Передаём в функцию хэш -" => sub {
    it "должна вернуть 0" => sub {
        my %value  = ( 1 => 1 );
        my $expect = 0;

        my $actual = Validations::is_positive_number( %value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию undef -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = undef;
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию строку с символами -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = "test1";
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию пустую строку -" => sub {
    it "должна вернуть 0" => sub {
        my $value  = "";
        my $expect = 0;

        my $actual = Validations::is_positive_number( $value );

        is( $actual, $expect );
    };
};

runtests unless caller;

