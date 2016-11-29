# NAME

Honeydew::Ruder - Talk to the Ruder nodeJS service

[![Build Status](https://travis-ci.org/honeydew-sc/Honeydew-Ruder.svg?branch=master)](https://travis-ci.org/honeydew-sc/Honeydew-Ruder)

# VERSION

version 0.02

# SYNOPSIS

    my $req = Honeydew::Ruder->new('GET https://www.google.com');
    my $res = $req->execute;
    say $res;

# DESCRIPTION

Use this module to interact with the Ruder NodeJS service. Instantiate
an object by passing in a multiline string of an HTTP request and
invoke ["execute"](#execute) to get the result.

# METHODS

## execute

Send the request off to the ruder server and return the response. By
default, this method will simple return the content of the
response.

If you want the entire HTTP::Response object, pass `debug => 1`
to the method to do so.

For example, if the actual request were to respond with the following
hypothetical `HTTP::Response`

    my $server_res = HTTP::Response->new(200, undef, undef, 'response');

Then ruder would behave like such:

    my $ruder_res = $ruder->execute;
    is($ruder_res, 'response'); // ok

    my $ruder_res_debug = $ruder->execute(debug => 1);
    is($ruder_res_debug, $server_res); // ok

# BUGS

Please report any bugs or feature requests on the bugtracker website
https://github.com/honeydew-sc/Honeydew-Ruder/issues

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

# AUTHOR

Daniel Gempesaw <gempesaw@gmail.com>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2016 by Daniel Gempesaw.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
