#!/usr/bin/perl
#$newf = $oldf = $ARGV[0];
# replace any non alpha-numeric characters, excluding / . and - with an underscore
#$newf =~ s/[^a-zA-Z0-9.\/-]/_/g;
#exit 0 if $newf eq $oldf;
#print "Renaming \"$oldf\" to \"$newf\"...";
#rename $oldf,$newf ;
#print ($! ? "Error: $!\n" : "OK\n");

opendir(DH, $ARGV[0]);
my @files = readdir(DH);
closedir(DH);

foreach my $file (@files)
{
    # skip . and ..
    next if($file =~ /^\.$/);
    next if($file =~ /^\.\.$/);

    print "OLD: " . $file . "\n";
    print "NEW: " . replace($file)."\n";

    rename( $file, replace($file));
}

sub remove {
    my $string = shift;
    $string =~ s/[^a-zA-Z0-9.\-_]//g;
    return $string;
}
sub replace {
    my $string = shift;
    $string =~ s/[^a-zA-Z0-9.\-_]/_/g;
    return $string;
}
sub reversable {
    my $string = shift;
    $string =~ s/([^a-zA-Z0-9.\-_])/sprintf('=%x',unpack('C',$1))/eg;
    return $string;
}
