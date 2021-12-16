use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Cat;

# Testing new
describe "Создаём объект с указанием новых параметров(уникальных для кошки) -" => sub {
    it "должен создаться объект с этими параметрами" => sub {
        my %param = (
            fur_length   => 'long',
            night_vision => 'perfect',
            sound        => 'meow',
        );

        my $animal = Test::MockObject->new();
        Animal->expects( 'new' )->returns( $animal );

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 4 );

        my $cat = Cat->new( %param );

        ok( ref $cat );

        for my $key ( keys %param ) {
            is ( $param{ $key }, $cat->{ $key }, "$key добавлен верно" );
        }
    };
};


describe "Создаём объект с нестандартным звуком для кошки -" => sub {
    it "должен создаться объект с 'sound => meow'" => sub {
        my %param = (
            sound => 'test',
        );
        my $expect = "/Invalid night vision/";

        my $animal = Test::MockObject->new();
        Animal->expects( 'new' )->returns( $animal );

        my $cat = Cat->new( %param );

        ok( $cat->{sound} eq 'meow' );
    };
};

describe "Создаём объект с неверным параметром fur_length -" => sub {
    it "должена умереть" => sub {
        my %param = (
            fur_length   => 'test',
            night_vision => 'perfect',
            sound        => 'meow',
        );
        my $expect = "/Invalid fur lenght/";

        my $animal = Test::MockObject->new();
        Animal->expects( 'new' )->returns( $animal );

        Validations->expects( 'is_in_array' )->returns( sub {
            my ( $value ) = @_;

            if ( $value eq $param{fur_length} ){
                return 0;
            }

            return 1;
        })->exactly( 3 );

        throws_ok ( sub { Cat->new( %param ) }, $expect );
    };
};

describe "Создаём объект с неверным параметром night_vision -" => sub {
    it "должена умереть" => sub {
        my %param = (
            fur_length   => 'short',
            night_vision => 'test',
            sound        => 'meow',
        );
        my $expect = "/Invalid night vision/";

        my $animal = Test::MockObject->new();
        Animal->expects( 'new' )->returns( $animal );

        Validations->expects( 'is_in_array' )->returns( sub {
            my ( $value ) = @_;

            if ( $value eq $param{night_vision} ){
                return 0;
            }

            return 1;
        })->exactly( 4 );

        throws_ok ( sub { Cat->new( %param ) }, $expect );
    };
};


runtests unless caller;

