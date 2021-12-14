use Test::Spec;
use Test::utf8;
use Modern::Perl;
use Data::Dumper;

use lib "../../";
use Validations;

# Testing is_in_array

# Positive result
describe "Передаём в функцию не пустой паттерн и ссылку на массив содержищий этот паттерн -" => sub {
    it "должна вернуть 1" => sub {
        my $string  = 'test';
        my @array   = qw/ test 123 /;
        my $expect  = 1;

        my $actual = Validations::is_in_array( $string, \@array );

        is( $actual, $expect );
    };
};

# Negaive result
describe "Передаём в функцию не пустой паттерн и ссылку на массив не содержищий этот паттерн -" => sub {
    it "должна вернуть 0" => sub {
        my $string  = 'test';
        my @array   = qw/ 123 456 /;
        my $expect  = 0;

        my $actual = Validations::is_in_array( $string, \@array );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию не пустой паттерн и ссылку на пустой массив -" => sub {
    it "должна вернуть 0" => sub {
        my $string  = 'test';
        my @array;
        my $expect  = 0;

        my $actual = Validations::is_in_array( $string, \@array );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию пустой паттерн(undef) и ссылку на массив -" => sub {
    it "должна вернуть 0" => sub {
        my $string  = undef;
        my @array   = qw/ 123 456 /;
        my $expect  = 0;

        my $actual = Validations::is_in_array( $string, \@array );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию не пустой паттерн и массив -" => sub {
    it "должна вернуть 0" => sub {
        my $string  = "123";
        my @array   = qw/ 123 456 /;
        my $expect  = 0;

        my $actual = Validations::is_in_array( $string, @array );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию данные в виде хэша -" => sub {
    it "должна вернуть 0" => sub {
        my %hash = (
            string => "123",
            array  => [ 123, 456 ],
        );
        my $expect  = 0;

        my $actual = Validations::is_in_array( %hash );

        is( $actual, $expect );
    };
};


describe "Передаём в функцию данные в виде ссылки на хэша -" => sub {
    it "должна вернуть 0" => sub {
        my %hash = (
            string => "123",
            array  => [ 123, 456 ],
        );
        my $expect  = 0;

        my $actual = Validations::is_in_array( \%hash );

        is( $actual, $expect );
    };
};

runtests unless caller;

