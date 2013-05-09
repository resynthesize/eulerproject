#!/usr/bin/perl
#
# Brandon Tallent (btallent@gmail.com)
# Helper class for solving project euler problems.
# http://projecteuler.net/

package Euler;
use Time::HiRes qw/gettimeofday tv_interval/;
use Method::Signatures::Simple;
use Moose;

has 'elapsed_time' => ( is => "rw" );
has 'timer'        => ( is => "rw" );

method start_timer ()
{
    $self->timer([gettimeofday]);
}

method stop_timer ()
{
    $self->elapsed_time( tv_interval( $self->timer, [gettimeofday] ) );
}

method answer_attempts ($problem)
{
    my $answer;
    my @answers;
    for my $i ( 1 .. 10 )
    {
        my $method = "attempt$i";
        if ( $problem->meta->has_method($method) )
        {
            $problem->start_timer;
            $problem->$method;
            $problem->stop_timer;
            push @answers,
              {
                attempt      => $i,
                answer       => $problem->answer,
                elapsed_time => $problem->elapsed_time
              };
        }
    }

    return \@answers;
}

1;
