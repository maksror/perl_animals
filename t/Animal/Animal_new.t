use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing new
describe "Создаём объект с полным набором валидных параметров -" => sub {
    it "должен создаться объект с этими параметрами" => sub {
        my %param = (
            weight => 1,
            height => 1,
            sex    => 'male',
            name   => 'test',
            sound  => 'unga bunga',
        );

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 6 );
        Validations->expects( 'is_positive_number' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_not_empty_string' )->returns( 1 )->exactly( 2 );

        my $object = Animal->new( %param );

        ok( ref $object );

        for my $key ( keys %param ) {
            is ( $param{ $key }, $object->{ $key }, "$key добавлен верно" );
        }
    };
};

describe "Создаём объект с валидными параметрами без обязательных -" => sub {
    it "должен создаться объект с этими параметрами" => sub {
        my %param = (
            weight => 1,
            height => 1,
            sex    => 'male',
        );

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 4 );
        Validations->expects( 'is_positive_number' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_not_empty_string' )->returns( 1 )->exactly( 0 );

        my $object = Animal->new( %param );

        ok( ref $object );

        for my $key ( keys %param ) {
            is ( $param{ $key }, $object->{ $key }, "$key добавлен верно" );
        }
    };
};

describe "Создаём объект с неверным набором атрибутов -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            test => 1,
        );
        my $expect = "/Invalid attribute/";

        Validations->expects( 'is_in_array' )->returns( 0 )->exactly( 1 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

describe "Создаём объект с неверным весом -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            weight => 'test',
        );
        my $expect = "/Invalid weight/";

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 1 );
        Validations->expects( 'is_positive_number' )->returns( sub {
            my ( $value ) = @_;
            if ( $value eq $param{weight} ) {
                return 0;
            }

            return 1;
        })->exactly( 1 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

describe "Создаём объект с неверным ростом -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            weight => 1,
            height => 'test',
        );
        my $expect = "/Invalid height/";


        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_positive_number' )->returns( sub {
            my ( $value ) = @_;
            if ( $value eq $param{height} ) {
                return 0;
            }

            return 1;
        })->exactly( 2 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

describe "Создаём объект с неверным полом -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            weight => 1,
            height => 1,
            sex    => 'test',
        );
        my $expect = "/Invalid sex/";

        Validations->expects( 'is_in_array' )->returns( sub {
            my ( $value, $array_ref ) = @_;

            if ( grep /male/, @$array_ref ) {
                return 0;
            }

            return 1;
        } )->exactly( 4 );
        Validations->expects( 'is_positive_number' )->returns( 1 )->exactly( 2 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

describe "Создаём объект с пустым звуком -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            weight => 1,
            height => 1,
            sex    => 'male',
            sound  => '',
        );
        my $expect = "/Invalid sound/";


        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 5 );
        Validations->expects( 'is_positive_number' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_not_empty_string' )->returns( 0 )->exactly( 1 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

describe "Создаём объект с пустым именем -" => sub {
    it "должена умереть" => sub {
        my %param  = (
            weight => 1,
            height => 1,
            sex    => 'male',
            sound  => 'test',
            name   => '',
        );
        my $expect = "/Invalid name/";

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 6 );
        Validations->expects( 'is_positive_number' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_not_empty_string' )->returns( sub {
            my ( $value ) = @_;

            if ( $value eq $param{name} ){
                return 0;
            }

            return 1;
        })->exactly( 2 );

        throws_ok ( sub { Animal->new( %param ) }, $expect );
    };
};

runtests unless caller;

