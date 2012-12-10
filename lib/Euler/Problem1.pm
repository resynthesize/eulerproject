#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=1
#
# Timing with max = 999
# .----------+---------+--------+----------.
# | Problem  | Attempt | Answer | Time     |
# +----------+---------+--------+----------+
# | Problem1 | 1       | 233168 | 0.000455 |
# | Problem1 | 2       | 233168 | 0.00087  |
# | Problem1 | 3       | 233168 | 0.000825 |
# | Problem1 | 4       | 233168 | 3.1e-05  |
# '----------+---------+--------+----------'
#
# The 4th attempt solves the problem quickly regardless of how large max is

package Euler::Problem1;
use strict;
use warnings;
use Method::Signatures::Simple;
use Data::Dumper;
use Moose;
use POSIX;

extends 'Euler';

has 'answer'  => ( is => "rw" );
has 'answers' => ( is => "rw", lazy_build => 1 );
has 'max'     => ( is => "ro", required => 1, default => 999 );
has 'sum_15'  => ( is => "rw", lazy_build => 1 );
has 'sum_3'   => ( is => "rw", lazy_build => 1 );
has 'sum_5'   => ( is => "rw", lazy_build => 1 );

method _build_answers ()
{
    return $self->answer_attempts($self);
}

method _build_sum_3 ()
{
    return $self->div_by(3);
}

method _build_sum_5 ()
{
    return $self->div_by(5);
}

method _build_sum_15 ()
{
    return $self->div_by(15);
}

method div_by ($num)
{
    my $sum = 0;
    for ( my $i = $num ; $i <= $self->max ; $i += $num )
    {
        $sum += $i;
    }
    return $sum;
}

method div_by_improved ($num)
{
    my $p = floor( $self->max / $num );
    return $num * ( $p * ( $p + 1 ) ) / 2;
}

# brute force
method attempt1 ()
{
    my $sum = 0;
    for my $num ( 1 .. $self->max )
    {

        if (   ( $num % 3 == 0 )
            or ( $num % 5 == 0 ) )
        {
            $sum += $num;
        }

    }
    $self->answer($sum);
}

# using moose lazy_build attributes and instructions from answer guide
method attempt2 ()
{
    $self->answer( $self->sum_3 + $self->sum_5 - $self->sum_15 );
}

# calling div_by() directly
method attempt3 ()
{
    my $answer = $self->div_by(3) + $self->div_by(5) - $self->div_by(15);
    $self->answer($answer);
}

# use div_by_improved instead
method attempt4 ()
{
    my $answer =
      $self->div_by_improved(3) +
      $self->div_by_improved(5) -
      $self->div_by_improved(15);
    $self->answer($answer);
}

1;
