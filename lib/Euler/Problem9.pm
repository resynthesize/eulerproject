#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=9
#
# A Pythagorean triplet is a set of three natural numbers, a  b  c, for which,
# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc

package Euler::Problem9;
use Method::Signatures::Simple;
use Data::Dumper;
use Moose;

extends 'Euler';

has 'answer'  => ( is => "rw" );
has 'answers' => ( is => "rw", lazy_build => 1 );

method _build_answers ()
{
    return $self->answer_attempts($self);
}

# generates the next set of coprime integers where
# m > n and m - n is odd.
method _gen_coprime ()
{

}

method attempt1 ()
{
    my $answer = 0;
    for my $a ( 1 .. 999 )
    {
        for my $b ( 1 .. 999 )
        {

            my $c = sqrt( $a**2 + $b**2 );
            if ( ( $a + $b + $c ) == 1000 )
            {
                $answer = $a * $b * $c;
		print "$a $b $c\n"; 
                last;
            }
        }
    }

    $self->answer($answer);
}

1;
