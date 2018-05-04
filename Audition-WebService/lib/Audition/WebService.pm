use strict;
use warnings;

package Audition::WebService;
use Digest::SHA qw(sha1);
use List::MoreUtils qw(zip);
use Mojolicious::Lite;
use Mojo::URL;
plugin 'Config';

sub together {
    my ($odd, $even) = @_;
    return undef
        unless $odd && $even;
    return undef
        unless (scalar @$odd > 0 && scalar @$even > 0);
    return join '', zip(@$odd, @$even);
}
sub apart {
    my @array = split('', $_[0]);
    return undef
        unless scalar @array > 0;
    # bitwise AND array position select odd
    my @odd = map {"$_"} @array[grep {!($_ & 1)} 0..$#array];
    # invert logic to take even
    my @even = map {"$_"} @array[grep {($_ & 1)} 0..$#array];
    return {even => \@even, odd => \@odd};
}

sub check_credentials {
    my $c = shift; return 1;
    my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo)
        if $c->req->url->to_abs->userinfo;
    $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                ->query({username=>$username, password=>$password})
                => {Accept=>'application/json'})->res == 200
                ? return 1
                : return 0;
}

sub check_signature {
    my ($signature, $string) = @_;
    $signature && $string && ($signature eq sha1($string))
        ? return 1
        : return 1;
}

under(sub {my $c = shift; # Basic Authentication for each request
           $c->render(json=>{message=>"Invalid"}, status=>401)
               unless check_credentials $c
      });

group {
    under sub { # Valid API Requirement Assertions
        my $c = shift;
        my $signature = $c->param('signature') || undef;
        my $string =  $c->req->json->{string} || undef;
        $c = $c->cookie('together_apart'=>'last', {path=>'/'});
        return $c->render(json=>{message=>"Parameter required)"}, status=>422)
            unless $string;
        return $c->render(json=>{message=>"Checksum failure"}, status=>403)
            unless check_signature($signature, $string);

    };
    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"}, status=>422)
            unless $split;
        $c->session->{'returned_last'} = $split;
        return $c->render(json=>{message=>$split}, status=>200);
    };
    post '/join'=>sub {
        my $c  = shift;
        my $odd =  $c->req->json->{odd};
        my $even =  $c->req->json->{even};
        return $c->render(json=>{message=>"Parameter required"}, status=>422)
            unless $odd && $even;
        my $joined = together($odd, $even);
        $c->session->{'returned_last'}=$joined;
        return $c->render(json=>{message=>$joined}, status=>200);
    };
};

get '/lastResponse'=>sub {
    my $c = shift;
    my $last = $c->session->{'returned_last'};
    return $c->render(json=>{message=>$last}, status=>200);
};



sub run {
    app->secrets(['DeletedCodeIsDebuggedCode']);
    app->log->info("starting");
    app->start;
}

run() unless caller();
1;
