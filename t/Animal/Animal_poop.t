use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing poop

describe "Передаём в функцию объект с объявленным именем и валидную строку -" => sub {
    it "должна вернуть строку 'NAME goes to poop on the PLACE\\n'" => sub {
        my %param  = ( name => 'test' );
        my $place  = 'test';
        my $expect = "$param{name} goes to poop on the $place\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( $param{name} );

        Validations->expects( 'is_not_empty_string' )->returns( 1 );

        stdout_is( sub { Animal::poop( $self, $place ) }, $expect );
    };
};

describe "Передаём в функцию объект с не валидной строкой -" => sub {
    it "должна умереть" => sub {
        my %param  = ( name => 'test' );
        my $place  = '';
        my $expect = "/Wrong place/";


        my $self   = Test::MockObject->new( \%param );

        Validations->expects( 'is_not_empty_string' )->returns( 0 );

        throws_ok( sub { Animal::poop( $self, $place ) }, $expect );
    };
};

runtests unless caller;

