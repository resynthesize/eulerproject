#!/usr/bin/perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use Text::SimpleTable::AutoWidth;
use Try::Tiny;
use Data::Dumper;
use Getopt::Long;

my $problem_path = "$FindBin::Bin/lib/Euler/";
my @problem_files;
my $problem_num = '';

GetOptions( 'problem=s' => \$problem_num );

if ( !opendir( DIR, $problem_path ) )
{
    die("Couldn't open $problem_path: $!");
}

@problem_files =
  ($problem_num) ? ("Problem$problem_num") : grep { /pm$/ } readdir DIR;

my $t = Text::SimpleTable::AutoWidth->new();
$t->captions( [qw/Problem Attempt Answer Time/] );

foreach my $problem (@problem_files)
{
    $problem =~ s/\.pm$//;
    my $file = $problem_path . "$problem.pm";
    require "$file";

    my $problem_name = "Euler::$problem";
    my $p            = $problem_name->new;
    my $answers      = $p->answers;

    foreach my $answer ( @{$answers} )
    {
        $t->row(
            (
                $problem,          $answer->{attempt},
                $answer->{answer}, $answer->{elapsed_time}
            )
        );
    }

}

print $t->draw;
