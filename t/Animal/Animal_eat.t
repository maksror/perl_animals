use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Animal;

# Testing eat

describe "Передаём в функцию объект с объявленным именем и валидную строку -" => sub {
    it "должна вернуть строку 'NAME goes to eat FOOD\\n'" => sub {
        my %param  = ( name => 'test' );
        my $food   = 'meat';
        my $expect = "$param{name} goes to eat $food\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( 'test' );

        Validations->expects( 'is_not_empty_string' )->returns( 1 );

        stdout_is( sub { Animal::eat( $self, $food ) }, $expect );
    };
};

describe "Передаём в функцию в качестве еды пустую строку -" => sub {
    it "должна умереть'" => sub {
        my %param  = ( name => 'test' );
        my $food   = '';
        my $expect = "/Wrong food/";

        my $self   = Test::MockObject->new( \%param );

        Validations->expects( 'is_not_empty_string' )->returns( 0 );

        throws_ok( sub { Animal::eat( $self, $food ) }, $expect );
    };
};

runtests unless caller;

