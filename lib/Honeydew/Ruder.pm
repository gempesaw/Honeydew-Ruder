package Honeydew::Ruder;

# ABSTRACT: Talk to the Ruder nodeJS service
use strict;
use warnings;
use Honeydew::Config;
use LWP::UserAgent;
use JSON;
use Moo;

=for markdown [![Build Status](https://travis-ci.org/honeydew-sc/Honeydew-Ruder.svg?branch=master)](https://travis-ci.org/honeydew-sc/Honeydew-Ruder)

=head1 SYNOPSIS

    my $req = Honeydew::Ruder->new('GET https://www.google.com');
    my $res = $req->execute;
    say $res;

=head1 DESCRIPTION

Use this module to interact with the Ruder NodeJS service. Instantiate
an object by passing in a multiline string of an HTTP request and
invoke L</execute> to get the result.

=cut

has request => (
    is => 'ro',
    required => 1
);

has ua => (
    is => 'lazy',
    default => sub { return LWP::UserAgent->new }
);

has config => (
    is => 'lazy',
    default => sub { return Honeydew::Config->instance }
);

around BUILDARGS => sub {
    my ( $orig, $class, @args ) = @_;

    return { request => $args[0] }
      if @args == 1 && !ref $args[0];

    return $class->$orig(@args);
};

=method execute

Send the request off to the ruder server and return the response. By
default, this method will simple return the content of the
response.

If you want the entire HTTP::Response object, pass C<< debug => 1 >>
to the method to do so.

For example, if the actual request were to respond with the following
hypothetical C<HTTP::Response>

    my $server_res = HTTP::Response->new(200, undef, undef, 'response');

Then ruder would behave like such:

    my $ruder_res = $ruder->execute;
    is($ruder_res, 'response'); // ok

    my $ruder_res_debug = $ruder->execute(debug => 1);
    is($ruder_res_debug, $server_res); // ok

=cut

sub execute {
    my ($self, %args) = @_;

    my $req = HTTP::Request->new;
    $req->method('POST');
    $req->uri($self->_ruder_addr);
    $req->header('Content-Type' => 'application/json');
    $req->content(to_json({ data => $self->request}));

    my $response = $self->ua->request($req);
    if ($args{debug}) {
        return $response;
    }
    else {
        return $response->content;
    }
}

sub _ruder_addr {
    my ($self) = @_;
    return $self->config->{ruder}->{server};
}

1;
