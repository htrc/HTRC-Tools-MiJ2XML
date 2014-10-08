#!/usr/bin/perl

# University of Illinois/NCSA Open Source License
#
# Copyright (c) 2013 HathiTrust Research Center   All rights reserved.
#
# Developed by: 		HathiTrust Research Center, University Library and GSLIS, University of Illinois
#                               http://www.hathitrust.org/htrc http://www.library.illinois.edu http://www.lis.illinois.edu
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal with the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
#
#    Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimers.
#    Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimers in the documentation and/or other materials provided with the distribution.
#    Neither the names of HathiTrust Research Center, University Library and GSLIS, University of Illinois, nor the names of its contributors may be used to endorse or promote products derived from this Software without specific prior written permission.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

use MARC::File::MiJ;
use MARC::Batch;
use MARC::File::XML;
use utf8;
use Cwd qw();
use Scalar::Util qw(looks_like_number);
use File::Path qw(make_path);

my ( $sourcefile, $destinationDir, $batchSize ) = @ARGV;

# check the arguments
if ( not defined $sourcefile ) {
    $sourcefile = "meta.json";
}

if ( not -e $sourcefile ) {
    die "Source file does not exist: $sourcefile\n";
}

if ( not defined $destinationDir ) {
    $destinationDir = Cwd::cwd();
}
elsif ( not -e $destinationDir ) {
    make_path($destinationDir)
      or die "Error creating directory: $destinationDir\n";
}

if ( not defined $batchSize ) {
    $batchSize = 0;
}
elsif ( not looks_like_number($batchSize) ) {
    die "batch size argument must be a number: $batchSize\n";
}

# connect to the source file

my $batch = MARC::Batch->new( "MiJ", $sourcefile );
my $batchCount = 0;

my $count = 0;

# main control loop

while ( $record = $batch->next() ) {
    $batchCount++;
    writeBatch( $batchCount, $batchSize );
}

print STDOUT join("\n", map { s|/|::|g; s|\.pm$||; $_ } keys %INC);

# sub writeBatch assumes it is within a while ( $record = $batch->next() ) loop
sub writeBatch {

    my $batchNum   = shift;
    my $maxRecords = shift;

    my $recordCount = 0;

    open( OUT, ">>" . "$destinationDir/b$batchNum.xml" );
    binmode( OUT, ":utf8" );
    $batch->warnings_off();
    $batch->strict_off();

    print OUT MARC::File::XML::header();

    # print the record fetched in the calling while loop
    $recordCount++;
    print OUT MARC::File::XML::record($record);

    while ( $record = $batch->next() ) {
        $recordCount++;
        print OUT MARC::File::XML::record($record);

        if ( $recordCount >= $maxRecords ) {
            last;
        }
    }

    print OUT MARC::File::XML::footer();
    close(OUT);
}
