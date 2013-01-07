#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=6
#
# the sum of the squares of the first ten natural numbers is,
# 1**2 + 2**2 + ... + 10**2 = 385
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)**2 = 55**2 = 3025
#
# Hence the difference between the sum of the squares of the first ten natural
# numbers and the square of the sum is 3025  385 = 2640.
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.

package Euler::Problem6;
use Method::Signatures::Simple;
use Data::Dumper;
use Moose;

extends 'Euler';

has 'answer'      => ( is => "rw" );
has 'answers'     => ( is => "rw", lazy_build => 1 );
has 'max'         => ( is => "ro", default => 100 );
has 'square_sums' => ( is => "rw", lazy_build => 1 );
has 'sum_squares' => ( is => "rw", lazy_build => 1 );

method _build_sum_squares ()
{
    return ( 2 * $self->max + 1 ) * ( $self->max + 1 ) * $self->max / 6;
}

method _build_square_sums ()
{
    my $sum = $self->max * ( $self->max + 1 ) / 2;
    return $sum**2;
}

method _build_answers ()
{
    return $self->answer_attempts($self);
}

method attempt1 ()
{
    print "Sum of squares: " . $self->sum_squares . "\n";
    print "Square of sums: " . $self->square_sums . "\n";

    $self->answer( $self->square_sums - $self->sum_squares );
}

1;
