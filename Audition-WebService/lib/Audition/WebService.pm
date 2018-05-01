use strict;
use warnings;

package Audition::WebService;
use Digest::SHA qw(sha1);
use List::MoreUtils qw(zip);
use Mojolicious::Lite;
use Mojo::URL;
use Mojo::Util qw(secure_compare);

plugin 'Config';

sub together {
    my ($odd, $even) = @_;
    return undef unless scalar @$odd > 0 && scalar @$even > 0;
    return join '', zip(@$odd, @$even);
}

sub apart {
    my @array = split('', $_[0]);
    return undef unless scalar @array > 0;
    my @odd = map {"$_"} @array[grep {!($_ & 1)} 0..$#array]; # bitwise AND array position select odd
    my @even = map {"$_"} @array[grep {($_ & 1)} 0..$#array]; # invert logic to take even
    return {even => \@even, odd => \@odd};
}

#under(sub { my $c = shift; # Basic Authentication for each request
#            my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo);
#            $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
#                        ->query({username=>$username, password=>$password})
#                        => {Accept=>'application/json'})->res == 200
#                        ? return 1
#                        : return $c->render(json=>{message=>"Invalid"})->rendered(401)});

group { under sub { # Valid API Requirement Assertions
        my $c = shift;
        my $signature = $c->param('signature') || undef;
        my $string =  $c->req->json->{string} || undef;
        return $c->render(json=>{message=>"Parameter required)"})->rendered(422) unless $string;
        return $c->render(json=>{message=>"Checksum failure"})->rendered(403) unless $signature && ($signature eq sha1($string));
    };
    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422) unless $split;
        $c->session('returned_last'=>$split);
        return $c->render(json=>$split)->rendered(200);
    };
    post '/join'=>sub {
        my $c  = shift;
        my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
        my $join = together($odd, $even);
        return $c->render(json=>{message=>"Parameter required"})->rendered(422) unless $join;
        $c->session('returned_last'=>$join);
        return $c->render(json=>$join)->rendered(200);
    };
};

get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};


# HTML API
any '/' => sub { # Main login action
    my $c = shift;
    my ($u, $p) = split(':',  $c->req->url->to_abs->userinfo);
    $u =  $c->param('username') || $u;
    $p = $c->param('password') || $p;

    return $c->render unless 200 == $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                                         ->query({username=>$u, password=>$p})
                                         => {Accept=>'application/json'})->res;
    $c->session(user=>$u);
    $c->session(config=>app->config);
    $c->flash(message=>'authenticated');
    $c->redirect_to('protected');
} => 'index';

group { # logged in user actions
    under sub {
        my $c = shift;
        return 1 if $c->session('user')->redirect_to('index');
        return undef;
    };
    get '/protected';
};

get '/logout' => sub { # Logout action
    my $c = shift;
    $c->session(expires => 1);
    $c->redirect_to('index');
};

# INITIALIZATION
my $ctx = {};

my $state = {
    register=>$ENV{"register_url"} || app->config('register_url'),
    auth=>$ENV{"auth_url"} || app->config('auth_url'),
    app_name=>$ENV{"app_name"} || app->config('name'),
    status=>'stopped',
    cfgs=>app->config
};

my $closed_lambda = sub {
    my $s = shift || $state;
    return sub {
        $s->{status}='start';
        app->log->debug("starting");
        get '/'=>'with_config';
        $s->{status}='running';
        return {state=>$s};
    };
};

sub cli {
    my $run_state = $closed_lambda->($state)->($ctx);
    app->start;
#    return $run_state;
}

cli() unless caller();
1;
__DATA__
@@ index.ep
<!DOCTYPE html>
<html>
  <head><title><%= config 'name' %></title></head>
  <body>Welcome to <%= config 'name' %></body>
</html>
