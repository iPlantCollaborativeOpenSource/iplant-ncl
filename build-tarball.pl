#!/usr/bin/perl

use warnings;
use strict;

use Carp;
use English qw(-no_match_vars);
use File::Basename;
use File::Path qw(remove_tree);

our $VERSION = 'v0.0.1';

my $SRC_PREFIX = 'ncl';
my $DST_PREFIX = 'iplant-ncl';

# Build the tarball.
remove_package_directories();
remove_destination_tarballs();
my $src_tarball = get_source_tarball_name();
extract_source_tarball($src_tarball);
my $dst_directory = rename_source_directory($src_tarball);
create_destination_tarball($dst_directory);
remove_package_directories();

exit;

##########################################################################
# Usage      : remove_package_directories();
#
# Purpose    : Removes any directories that may may have been left over
#              from previous build attempts.
#
# Returns    : Nothing.
#
# Parameters : None.
#
# Throws     : "unable to remove $dir: $reason"
sub remove_package_directories {
    for my $dir ( glob "$SRC_PREFIX* $DST_PREFIX*" ) {
        if ( -d $dir ) {
            remove_tree $dir
                or croak "unable to remove $dir: $ERRNO\n";
        }
    }
    return;
}

##########################################################################
# Usage      : remove_destination_tarballs();
#
# Purpose    : Removes any destination tarballs that may already exist.
#
# Returns    : Nothing.
#
# Parameters : None.
#
# Throws     : No exceptions.
sub remove_destination_tarballs {
    remove_tree glob "$DST_PREFIX*.tar.gz";
    return;
}

##########################################################################
# Usage      : $tarball_name = get_source_tarball_name();
#
# Purpose    : Determines the name of the source tarball.
#
# Returns    : The name of the source tarball.
#
# Parameters : None.
#
# Throws     : "no source tarballs found"
#              "multiple source tarballs found"
sub get_source_tarball_name {
    my @src_tarballs = glob "$SRC_PREFIX*.tar.gz";
    if ( scalar @src_tarballs < 1 ) {
        croak 'no source tarballs found';
    }
    elsif ( scalar @src_tarballs > 1 ) {
        croak 'multiple source tarballs found';
    }
    return $src_tarballs[0];
}

##########################################################################
# Usage      : extract_source_tarball($src);
#
# Purpose    : Extracts the source tarball.
#
# Returns    : Nothing.
#
# Parameters : $src - the name of the source tarball.
#
# Throws     : "Unable to extract the source tarball"
sub extract_source_tarball {
    my ($src) = @_;
    system( 'tar', 'xvf', $src ) == 0
        or croak "unable to extract the source tarball: $CHILD_ERROR";
    return;
}

##########################################################################
# Usage      : $dst_directory = rename_source_directory($src);
#
# Purpose    : Renamees the source directory to the destination directory
#              name.
#
# Returns    : the name of the destination directory.
#
# Parameters : $src - the name of the source tarball.
#
# Throws     : "unable to rename $src_dir to $dst_dir: $status"
sub rename_source_directory {
    my ($src) = @_;
    my $src_dir = basename $src, '.tar.gz';
    my $dst_dir = $src_dir;
    $dst_dir =~ s/ \A \Q$SRC_PREFIX/$DST_PREFIX/xms;
    rename $src_dir, $dst_dir
        or croak "unable to rename $src_dir to $dst_dir: $CHILD_ERROR";
    return $dst_dir;
}

##########################################################################
# Usage      : create_destination_tarball($dst_directory);
#
# Purpose    : Creates the destination tarball.
#
# Returns    : Nothing.
#
# Parameters : $dst_directory - the name of the destination directory.
#
# Throws     : "unable to create the destination tarball: $status"
sub create_destination_tarball {
    my ($dst_dir) = @_;
    system( 'tar', 'czvf', "$dst_dir.tar.gz", $dst_dir ) == 0
        or croak "unable to create the destination tarball: $CHILD_ERROR";
    return;
}
