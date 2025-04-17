#!/usr/bin/perl
use strict;
use warnings;
use File::Find;
use IPC::Run qw( run );
use feature 'say';
$SIG{INT} = sub { warn("Abort"); exit 1 };

my $music_mount = '/music';

my $total = 0;
my $bad = 0;

sub check {
    my $name = $File::Find::name;
    my @cmd = (
        'ffmpeg',
        '-v', 'error',
        '-i', $name,
        '-f', 'null', '/dev/null'
    );
    # Capture ffmpeg output (stderr)
    run \@cmd, "/dev/null", \my $stdout, "2>", \my $stderr;

    if ($stderr ne '') {
        $bad++;
        (my $relpath = $name) =~ s{^\Q$music_mount/}{};
        print "$relpath\n";
    }
    $total++
}
find(
    sub {
        return unless -f $_;
        return unless /\.(mp3|flac|m4a|ogg|wav|aac|wma|alac
            |opus|webm|mka|mkv|oga|aiff|ape|amr|caf|dts|tta
            |voc|wv|ra|rm|au|gsm|m4b|m4p|mpc)$/ix;
        check();
    },
    $music_mount
);

print STDERR "Corruption: $bad / $total\n"
