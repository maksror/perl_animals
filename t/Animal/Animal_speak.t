use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing speak

describe "Передаём в функцию объект с объявленным именем и звуком -" => sub {
    it "должна вернуть строку 'NAME say SOUND\\n'" => sub {
        my %param  = ( name => 'test', sound => 'test' );
        my $place  = 'test';
        my $expect = "$param{name} say $param{sound}\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( $param{name} );
        $self->expects( 'get_sound' )->returns( $param{sound} )->exactly( 2 );

        stdout_is( sub { Animal::speak( $self, $place ) }, $expect );
    };
};

describe "Передаём в функцию объект с объявленным именем и без звука -" => sub {
    it "должна вернуть строку 'NAME can't speak\\n'" => sub {
        my %param  = ( name => 'test' );
        my $place  = 'test';
        my $expect = "$param{name} can't speak\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( $param{name} );
        $self->expects( 'get_sound' )->returns( $param{sound} );

        stdout_is( sub { Animal::speak( $self, $place ) }, $expect );
    };
};


runtests unless caller;

