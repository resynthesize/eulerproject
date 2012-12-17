#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
#
# various attempts to solve http://projecteuler.net/problem=3
#
# The prime factors of 13195 are 5, 7, 13 and 29.
# What is the largest prime factor of the number 600_851_475_143 ?

package Euler::Problem3;
use Method::Signatures::Simple;
use Data::Dumper;
use Moose;

extends 'Euler';

has 'answer'  => ( is => "rw" );
has 'answers' => ( is => "rw", lazy_build => 1 );
has 'number'  => ( is => "ro", default => 600_851_475_143 );
has 'primes'  => ( is => "rw", lazy_build => 1 );

# prime sieve algorithim
# http://en.wikipedia.org/wiki/Sieve_of_Eratosthenes
method _build_primes ()
{
    my @list;
    my @primes;

    my $max = int( ( sqrt( $self->number ) ) + 1 );

    # populate a list with the index representing each
    # possible prime, and a 1 or 0 to indicate primeness
    for ( 2 .. $max )
    {
        $list[$_] = 1;
    }

    # starting with 2, count 1 by 1 up to the square root of max
    for ( my $p = 2 ; $p <= sqrt($max) ; $p++ )
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
            for ( my $j = $p2 ; $j <= $max ; $j += $p )
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

# reading up on prime factorization led me to believe that a prime sieve
# algorithim would be needed to quickly factor a number this large.  after
# solving the problem, i realized that a simple brute force algorithim would
# work just as well (see attempt2) for numbers much higher than $self->number
# and also be much faster.
method attempt1 ()
{
    my $i;
    my @prime_factors;
    foreach my $prime ( @{ $self->primes } )
    {
        if ( $self->number % $prime == 0 )
        {
            push @prime_factors, $prime;
        }
    }

    $self->answer( $prime_factors[-1] );
}

# first algorithim provided on problem whitepaper
method attempt2 ()
{
    my $num         = $self->number;
    my $factor      = 2;
    my $last_factor = 1;
    while ( $num > 1 )
    {
        if ( ( $num % $factor ) == 0 )
        {
#            print "factor: $factor, num: $num\n";

            $last_factor = $factor;
            $num = int( ( $num / $factor ) + 0.5 );
            while ( ( $num % $factor ) == 0 )
            {
                $num = int( ( $num / $factor ) + 0.5 );

            }
        }
        $factor++;
    }
    $self->answer($factor);
}

# second algorithim provided on problem whitepaper
method attempt3 ()
{
    my $num = $self->number;
    my $factor;
    my $last_factor;
    if ( ( $num % 2 ) == 0 )
    {
        $num = int( ( $num / 2 ) + 0.5 );
        $last_factor = 2;
    }
    else
    {
        $last_factor = 1;
    }

    $factor = 3;
    while ( $num > 1 )
    {
#        print "num: $num\n";
        if ( ( $num % $factor ) == 0 )
        {
 #           print "factor: $factor, num: $num\n";

            $last_factor = $factor;
            $num = int( ( $num / $factor ) + 0.5 );
            while ( ( $num % $factor ) == 0 )
            {
                $num = int( ( $num / $factor ) + 0.5 );

            }
        }
        $factor += 2;
    }
    $self->answer($factor);
}

1;
