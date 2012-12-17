#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=4
#
# A palindromic number reads the same both ways. The largest palindrome made
# from the product of two 2-digit numbers is 9009 = 91 99.
# Find the largest palindrome made from the product of two 3-digit numbers.

package Euler::Problem4;
use Method::Signatures::Simple;
use Data::Dumper;
use POSIX;
use Moose;

extends 'Euler';

has 'answer'  => ( is => "rw" );
has 'answers' => ( is => "rw", lazy_build => 1 );

method _build_answers ()
{
    return $self->answer_attempts($self);
}

method is_palindrome ($string)
{
    my $len  = length $string;
    my $half = floor( $len / 2 );

    my $first_half  = substr( $string, 0,      $half );
    my $second_half = substr( $string, -$half, $half );
    
    if ( $first_half eq reverse($second_half) )
    {
#        print "$string, $first_half, $second_half\n";

        return 1;
    }
    else
    {
        return 0;
    }
}

# brute force attempt
method attempt1 ()
{
    my $largest = 0;
    for $a ( 1 .. 999 )
    {
        for $b ( 1 .. 999 )
        {
            my $c = $a * $b;
            if ( $self->is_palindrome($c) && $c > $largest )
            {
                $largest = $c;
            }
        }
    }
    $self->answer($largest);
}

1;
