#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=5
#
# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

package Euler::Problem5;
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

method attempt1 ()
{
    my $current_num = 0;
    my $all_div     = 0;
    my @range       = ( 1 .. 20 );
    @range = reverse @range;

    while ( $all_div == 0 )
    {
	# since the problem stated that 2520 is the smallest number that 1-10 go through, 
	# we know that the number has to be a multiple of 2520
        $current_num += 2520;
        foreach my $num (@range)
        {
            print "$current_num, $num\n";
            last if ( ( $current_num % $num ) != 0 );
            if ( $num == 1 )
            {
                $all_div = 1;
            }

            # only even numbers will be evenly divisible by even numbers.
        }
    }

    $self->answer($current_num);
}

1;
