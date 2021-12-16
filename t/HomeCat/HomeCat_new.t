use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use HomeCat;

# Testing new
describe "Создаём объект с указанием новых параметров(обязательных для домашней кошки) -" => sub {
    it "должен создаться объект с этими параметрами" => sub {
        my %param = (
            owner => 'test',
            name  => 'qwe',
        );

        my $cat = Test::MockObject->new();
        Cat->expects( 'new' )->returns( $cat );

        Validations->expects( 'is_in_array' )->returns( 1 )->exactly( 2 );
        Validations->expects( 'is_not_empty_string' )->returns( 1 )->exactly( 2 );

        my $home_cat = HomeCat->new( %param );

        ok( ref $home_cat );

        for my $key ( keys %param ) {
            is ( $param{ $key }, $home_cat->{ $key }, "$key добавлен верно" );
        }
    };
};

describe "Создаём объект с отсутвием имени -" => sub {
    it "должена умереть" => sub {
        my %param = (
            owner => 'test',
        );
        my $expect = "/A home cat should have a name/";

        throws_ok ( sub { HomeCat->new( %param ) }, $expect );
    };
};


describe "Создаём объект с отсутвием хозяина -" => sub {
    it "должена умереть" => sub {
        my %param = (
            name => 'test',
        );
        my $expect = "/A home cat should have an owner/";

        Validations->expects( 'is_not_empty_string' )->returns( 1 )->exactly( 1 );

        throws_ok ( sub { HomeCat->new( %param ) }, $expect );
    };
};

runtests unless caller;

