use strict;
use warnings;
use inc::Module::Install;

name 'Number-Vague';
all_from 'lib/Number/Vague.pm';
author q{OSFAMERON <osfameron@cpan.org>};

build_requires 'Test::More';

requires 'Any::Moose';

auto_install;

WriteAll;
