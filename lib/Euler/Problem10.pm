#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=10
#
# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
# Find the sum of all the primes below two million.

package Euler::Problem10;
use Method::Signatures::Simple;
use Data::Dumper;
use Moose;
use List::Util qw/sum/;
extends 'Euler';

has 'answer'  => ( is => "rw" );
has 'answers' => ( is => "rw", lazy_build => 1 );
has 'limit'   => ( is => "ro", default => 2_000_000 );
has 'primes'  => ( is => "rw", lazy_build => 1 );

# prime sieve algorithim
# http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
method _build_primes ()
{
    my @list;
    my @primes;

    # populate a list with the index representing each
    # possible prime, and a 1 or 0 to indicate primeness
    for ( 2 .. $self->limit )
    {
        $list[$_] = 1;
    }

    for my $p ( 2 .. sqrt( $self->limit ) )
    {

        # if the number is currently marked as prime
        if ( $list[$p] == 1 )
        {
            # starting with $p^2, go through every interval
            # of $p and mark it as not prime (it's divisible by p)
            # the first iteration will mark 4, 6, 8, 12, etc as not prime.
            # the second iteration will mark 3, 6, 9, 12 and so on up to
            # max.  it's ok if we mark an indice as non-prime multiple times.
            my $p2 = $p**2;
            for ( my $j = $p2 ; $j <= $self->limit ; $j += $p )
            {
                $list[$j] = 0;
            }
        }
    }

    # at this point, any indice with a value of 1 is prime.  I haven't
    # figured out a good way to avoid making this duplicate 'prime' list yet.
    # perl's slice is destructive and alters indice order
    for my $index ( 0 .. $#list )
    {
        if ( $list[$index] )
        {
            push @primes, $index;
        }
    }

    return \@primes;
}

method _build_answers ()
{
    return $self->answer_attempts($self);
}

method attempt1 ()
{
    print Dumper $self->primes;

    $self->answer( sum( @{ $self->primes } ) );
}

1;
