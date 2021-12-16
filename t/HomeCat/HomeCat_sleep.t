use Test::Spec;
use Test::utf8;
use Test::MockObject;
use Test::Output;
use Test::Exception;
use Data::Dumper;
use Modern::Perl;

use lib "../../";
use HomeCat;

# Testing sleep

describe "Передаём в функцию объект с объявленным именем и валидное кол-во часов -" => sub {
    it "должна вернуть строку 'NAME goes to sleep HOURS hours with OWNER\\n'" => sub {
        my %param  = (
            owner => 'test',
            name  => 'qwe',
        );
        my $hours  = 10;
        my $expect = "$param{name} goes to sleep $hours hours with $param{owner}\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( $param{name} );

        Validations->expects( 'is_positive_number' )->returns( 1 );

        stdout_is( sub { HomeCat::sleep( $self, $hours ) }, $expect );
    };
};

describe "Передаём в функцию более 12 часов -" => sub {
    it "должна умереть" => sub {
        my %param  = (
            owner => 'test',
            name  => 'qwe',
        );
        my $hours  = 13;
        my $expect = "/Too many hours for sleep/";

        my $self   = Test::MockObject->new( \%param );

        Validations->expects( 'is_positive_number' )->returns( 1 );

        throws_ok( sub { HomeCat::sleep( $self, $hours ) }, $expect );
    };
};

describe "Передаём в функцию объект не валидное кол-во часов -" => sub {
    it "должна умереть" => sub {
        my %param  = (
            owner => 'test',
            name  => 'qwe',
        );
        my $hours  = 'test';
        my $expect = "/Wrong number of hours of sleep/";

        my $self   = Test::MockObject->new( \%param );

        Validations->expects( 'is_positive_number' )->returns( 0 );

        throws_ok( sub { HomeCat::sleep( $self, $hours ) }, $expect );
    };
};

runtests unless caller;

