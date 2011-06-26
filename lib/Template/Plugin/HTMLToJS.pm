package Template::Plugin::HTMLToJS;

# ABSTRACT: Convert HTML To JS

use strict;
use warnings;

# VERSION

use parent 'Template::Plugin::Filter';

=method filter

Convert html into javascript

=cut
sub filter {
    my ($self, $text) = @_;
    $text =~ s/\n/ /gx;
    $text =~ s/'/'+"'"+'/gx;
    $text =~ s/\//'+"\/"+'/gx;
    $text =~ s/<(\/|)\bscript\b/<$1scr'+'ipt/gx;
    return 'document.write(\''.$text.'\');';
}

1;
