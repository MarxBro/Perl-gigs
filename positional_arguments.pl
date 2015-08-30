The Problem
However, once everyone starts using your subroutine, it starts expanding what it can do. Argument lists tend to expand, making it harder and harder to remember the order of arguments.

sub pretty_print {
    my (
        $filename, $text, $text_width, $justification, $indent,
        $sentence_lead
    ) = @_;

    # Format $text to $text_width somehow. If $justification is set, justify
    # appropriately. If $indent is set, indent the first line by one tab. If
    # $sentence_lead is set, make sure all sentences start with two spaces.

    open my $fh, '>', $filename
        or die "Cannot open '$filename' for writing: $!\n";

    print $fh $text;

    close $fh;

    return;
}

pretty_print( 'filename', $long_text, 80, 'full', undef, 1 );

The Solution

The most maintainable solution is to use "named arguments." In Perl 5, the best way to implement this is by using a hash reference. Hashes also work, but they require additional work on the part of the subroutine author to verify that the argument list is even. A hashref makes any unmatched keys immediately obvious as a compile error.

sub pretty_print {
    my ($args) = @_;

    # Format $args->{text} to $args->{text_width} somehow.
    # If $args->{justification} is set, justify appropriately.
    # If $args->{indent} is set, indent the first line by one tab.
    # If $args->{sentence_lead} is set, make sure all sentences start with
    # two spaces.

    open my $fh, '>', $args->{filename}
        or die "Cannot open '$args->{filename}' for writing: $!\n";

    print $fh $args->{text};

    close $fh;

    return;
}

pretty_print({
    filename      => 'filename',
    text          => $long_text,
    text_width    => 80,
    justification => 'full',
    sentence_lead => 1,
});
