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
describe "Передаём в функцию объект с объявленным именем и хозяином -" => sub {
    it "должна вернуть строку 'NAME plays with his owner OWNER\\n'" => sub {
        my %param  = (
            name  => 'test',
            owner => 'qwe',
        );
        my $expect = "$param{name} plays with his owner $param{owner}\n";

        my $self   = Test::MockObject->new( \%param );
        $self->expects( 'get_name' )->returns( $param{name} );

        stdout_is( sub { HomeCat::play( $self ) }, $expect );
    };
};

runtests unless caller;

