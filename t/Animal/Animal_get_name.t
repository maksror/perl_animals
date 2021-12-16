use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing get_name

describe "Передаём в функцию объект с именем -" => sub {
    it "должна вернуть NAME" => sub {
        my %param  = ( name => 'test' );
        my $expect = $param{name};

        my $self   = Test::MockObject->new( \%param );

        my $actual = Animal::get_name( $self );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию объект без имени -" => sub {
    it "должна вернуть строку 'CLASSNAME without name'" => sub {
        my %param  = ( test => "test" );
        my $expect = 'Test::MockObject without name';

        my $self   = Test::MockObject->new( \%param );

        my $actual = Animal::get_name( $self );

        is( $actual, $expect );
    };
};

describe "Вызываем метод класса напрямую без указания экземпляра -" => sub {
    it "должна вернуть строку 'Animal without name'" => sub {
        my $expect = 'Animal without name';

        my $actual = Animal->get_name;

        is( $actual, $expect );
    };
};


runtests unless caller;

