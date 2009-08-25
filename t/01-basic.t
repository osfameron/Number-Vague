use strict; use warnings;
use Test::More tests => 19;
use Number::Vague;

sub num { Number::Vague->parse(shift); }

ok   num('~2')->vague,     '~2 is vague';
ok   !num('~2')->is_range, '~2 is not a range';
ok   !num('2-3')->vague,   '2-3 is not vague';
ok   num('2-3')->is_range, '2-3 is a range';
ok   !num('23')->vague,    '23 is not vague';
ok   !num('23')->is_range, '23 is not a range';

ok   (!(num(4) + num(5))->vague,      '4 + 5 not vague' );
ok   ( (num(4) + num('~5'))->vague,    '4 + ~5 vague' );
ok   ( (num('~4') + num(5))->vague,    '~4 + 5 vague' );
ok   ( (num('~4') + num('~5'))->vague, '~4 + ~5 vague' );
ok   (!(num('4') + num('5-6'))->vague, '4 + 5-6 not vague' );
ok   (!(num('4-5') + num('6'))->vague, '4-5 + 6 not vague' );

my $range = num('4-5') + num('10-12');
ok !$range->vague, 'Range is not vague';
is $range->min, 14, 'min of range ok';
is $range->max, 17, 'max of range ok';

is num(100),    '100',  'overload normal ok';
is num('~100'), '~100', 'overload vague ok';
is $range,      '14-17', 'overload range ok';
is ($range + num('~1'), '~15-18', 'vague range ok');
