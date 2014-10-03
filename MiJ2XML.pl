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

my $batch = MARC::Batch->new("MiJ", $ARGV[0]);

open (OUT, ">>" . $ARGV[1]);
binmode(OUT, ":utf8");
$batch->warnings_off();
$batch->strict_off();

print OUT MARC::File::XML::header();

while ( $record = $batch->next())
{
  $record->encoding("UTF-8");

  print OUT MARC::File::XML::record( $record );
}

print OUT MARC::File::XML::footer();
close(OUT);
