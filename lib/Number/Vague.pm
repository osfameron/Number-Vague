package Number::Vague;

use warnings;
use strict;

=head1 NAME

Number::Vague - The great new Number::Vague!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';


=head1 SYNOPSIS

Add numbers, imprecisely

    use Number::Vague;

    my $normal = Number::Vague->parse('100'); 
    my $vague  = Number::Vague->parse('~100'); 

    my $x = $normal + $vague;
    # $x->vague will also be true

    my $range = Number::Vague->parse('10-20');

    my $min = ($range + 5)->min;
    my $max = ($range + $vague)->max;

    ...

=cut

use Any::Moose;

use overload q("") => \&print_number;
use overload q(+)  => \&add_number;

has 'min' => (
    is   => 'ro',
    isa  => 'Num',
  );
has 'max' => (
    is   => 'ro',
    isa  => 'Num',
  );
has 'vague' => (
    is   => 'ro',
    isa  => 'Bool',
  );

sub parse {
    my ($class, $s) = @_;
    my $vague = $s =~ s/^~//;

    my ($min, $max) = $s =~ /^(..*)-(.*)$/ ?
        ($1, $2)
      : ($s, $s);

    $class->new(
        min   => $min,
        max   => $max,
        vague => $vague,
      );
}

sub is_range {
    my $self = shift;
    return $self->min != $self->max;
}

sub print_number {
    my $self = shift;

    ($self->vague ? '~' : '')
    .
    ($self->is_range ?
        $self->min . '-' . $self->max
      : $self->min);
}

sub add_number {
    my ($self, $other, $flipped) = @_;
    my $class = ref $self;
    
    $other = $class->parse($other) unless ref $other;
    
    $class->new(
        min   => $self->min    + $other->min,
        max   => $self->max    + $other->max,
        vague => $self->vague || $other->vague,
      );
}

=head1 AUTHOR

osfameron, C<< <osfameron at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-number-vague at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Number-Vague>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Number::Vague

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Number-Vague>

=item * Search CPAN

L<http://search.cpan.org/dist/Number-Vague/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2009 osfameron.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of Number::Vague
