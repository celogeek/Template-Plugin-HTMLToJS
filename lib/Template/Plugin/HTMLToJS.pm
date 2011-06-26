package Template::Plugin::HTMLToJS;

# ABSTRACT: Convert HTML To JS

=head1 SYNOPSIS

    my $tt = Template->new;
    $tt->process('htmltojs-template.tt');

    # htmltojs-template.tt
    [% USE HTMLToJS %]
    [% FILTER $HTMLToJS %]
    <a href="http://www.test.com">Test</a>
    <script src="/test.js"></script>
    [% END %]

    #Will produce
    document.write('<a href="http://www.test.com">Test</a>\n    <scr'+'ipt> src="/test.js"></scr'+'ipt>');

    #could be use easily with on distant site
    <script src="http://www.test.com/yourhtmltojstemplate"></script>

=head1 DESCRIPTION

I have made this module to give an easy way to send html formated content to a javascript call.

For ex: you have a distant web site, and you want to display a top10 with all information,

on distant : <script src="http://yousite.com/top10"></script>

on yoursite : top10.tt :

    [% USE HTMLToJS %]
    [%FILTER $HTMLToJS %]
    <ul>
    <li><b>Rank 1 :</b> Test1</li>
    <li>...</li>
    </ul>
    [%END%]

This will convert it in a proper document.write form will al escape you need.

=cut

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
