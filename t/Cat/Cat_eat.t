use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use Cat;

# Testing eat

describe "Передаём в функцию объект с объявленным именем и валидную строку -" => sub {
    it "должна добавить строку 'While eating, the CLASS started rumbling\\n'" => sub {
        my $self = Test::MockObject->new();

        my $class  = ref $self; 
        my $expect = "While eating, the $class started rumbling\n";

        Animal->expects( 'eat' )->returns( 1 );

        stdout_is( sub { Cat::eat( $self ) }, $expect );
    };
};

describe "Вызываем метод напрямую без экземпляра -" => sub {
    it "должна добавить строку 'While eating, the Cat started rumbling\\n'" => sub {
        my $expect = "While eating, the Cat started rumbling\n";

        Animal->expects( 'eat' )->returns( 1 );

        stdout_is( sub { Cat::eat('some_food') }, $expect );
    };
};

runtests unless caller;

