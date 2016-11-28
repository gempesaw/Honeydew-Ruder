use strict;
use warnings;
use Test::Spec;
use HTTP::Response;
use Honeydew::Ruder;
use Honeydew::Config;

describe 'Ruder' => sub {
    my ($req);

    my $config = Honeydew::Config->instance( file => __FILE__ );
    $config->{ruder}->{server} = 'localhost';

    before each => sub {
        $req = 'GET https://www.google.com';
    };

    it 'should not require a hash to new' => sub {
        my $ruder = Honeydew::Ruder->new($req);
        is($ruder->request, $req);
    };

    describe 'execution' => sub {
        my ($ua_mock);
        before each => sub {
            $ua_mock = mock();
            $ua_mock->expects('post')
              ->with_deep('localhost', data => $req)
              ->returns(HTTP::Response->new(200, undef, undef, 'response'));
        };


        it 'should send the request to the ruder server' => sub {
            my $ruder = Honeydew::Ruder->new(
                request => $req,
                ua => $ua_mock
            );

            my $response = $ruder->execute;
            is($response, 'response');
        };

        it 'should return the entire response for debugging' => sub {
            my $ruder = Honeydew::Ruder->new(
                request => $req,
                ua => $ua_mock
            );

            my $response = $ruder->execute( debug => 1 );
            is($response->content, 'response');

        };
    };
};

runtests;
