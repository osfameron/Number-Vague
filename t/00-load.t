#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Number::Vague' );
}

diag( "Testing Number::Vague $Number::Vague::VERSION, Perl $], $^X" );
