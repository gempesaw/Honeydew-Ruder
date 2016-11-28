# NAME

Honeydew::Ruder - Talk to the Ruder nodeJS service

[![Build Status](https://travis-ci.org/gempesaw/Honeydew-Ruder.svg?branch=master)](https://travis-ci.org/gempesaw/Honeydew-Ruder)

# VERSION

version 0.01

# SYNOPSIS

    my $req = Honeydew::Ruder->new('GET https://www.google.com');
    my $res = $req->execute;
    say $res;

# DESCRIPTION

Use this module to interact with the Ruder NodeJS service. Instantiate
an object by passing in a multiline string of an HTTP request and
invoke ["execute"](#execute) to get the result.

# BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/gempesaw/Honeydew-Ruder/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Daniel Gempesaw <gempesaw@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Daniel Gempesaw.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
