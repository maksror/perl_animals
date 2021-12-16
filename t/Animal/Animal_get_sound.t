use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing get_sound

describe "Передаём в функцию объект с объявленным звуком -" => sub {
    it "должна вернуть 'SOUND'" => sub {
        my %param  = ( sound => 'test' );
        my $expect = $param{sound};

        my $self   = Test::MockObject->new( \%param );

        my $actual = Animal::get_sound( $self );

        is( $actual, $expect );
    };
};

describe "Передаём в функцию объект без объявленного звука -" => sub {
    it "должна вернуть undef" => sub {
        my %param  = ( test => 'test' );
        my $expect = undef;

        my $self   = Test::MockObject->new( \%param );

        my $actual = Animal::get_sound( $self );

        is( $actual, $expect );
    };
};

describe "Вызываем метод класса напрямую без указания экземпляра -" => sub {
    it "должна вернуть undef" => sub {
        my $expect = undef;

        my $actual = Animal->get_sound;

        is( $actual, $expect );
    };
};


runtests unless caller;

