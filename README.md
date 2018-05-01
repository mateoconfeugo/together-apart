<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline1">1. <span class="todo TODO">TODO</span> Summary</a></li>
<li><a href="#orgheadline3">2. <span class="done DONE">DONE</span> Exception/Error handling</a>
<ul>
<li><a href="#orgheadline2">2.1. <span class="done DONE">DONE</span> Network/connectivity</a></li>
</ul>
</li>
<li><a href="#orgheadline4">3. <span class="done DONE">DONE</span> Configuration</a></li>
<li><a href="#orgheadline5">4. <span class="done DONE">DONE</span> Environment Variables</a></li>
<li><a href="#orgheadline6">5. <span class="todo TODO">TODO</span> Testing</a></li>
<li><a href="#orgheadline7">6. <span class="done DONE">DONE</span> Golf - (eliminate extra code)</a></li>
<li><a href="#orgheadline11">7. <span class="todo TODO">TODO</span> System Integration</a>
<ul>
<li><a href="#orgheadline8">7.1. <span class="done DONE">DONE</span> Monitoring</a></li>
<li><a href="#orgheadline9">7.2. <span class="done DONE">DONE</span> Logging</a></li>
<li><a href="#orgheadline10">7.3. <span class="done DONE">DONE</span> Framework Utilization</a></li>
</ul>
</li>
<li><a href="#orgheadline12">8. <span class="done DONE">DONE</span> Documentation</a></li>
<li><a href="#orgheadline13">9. Dependencies</a></li>
<li><a href="#orgheadline20">10. Application Logic</a>
<ul>
<li><a href="#orgheadline14">10.1. Application functionality odd -even</a></li>
<li><a href="#orgheadline15">10.2. Basic Authentication using webservice</a></li>
<li><a href="#orgheadline16">10.3. Application functionality lastResult</a></li>
<li><a href="#orgheadline17">10.4. Application Functionality: return 401 on unsuccessful auth</a></li>
<li><a href="#orgheadline18">10.5. Application Functionality: return 403 on invalid sha1</a></li>
<li><a href="#orgheadline19">10.6. Application Functionality: return 422 on missing parameters</a></li>
</ul>
</li>
<li><a href="#orgheadline21">11. Code</a></li>
</ul>
</div>
</div>

# TODO Summary<a id="orgheadline1"></a>

# DONE Exception/Error handling<a id="orgheadline3"></a>

## DONE Network/connectivity<a id="orgheadline2"></a>

# DONE Configuration<a id="orgheadline4"></a>

# DONE Environment Variables<a id="orgheadline5"></a>

# TODO Testing<a id="orgheadline6"></a>

    use Audition::WebService;
    use Digest::SHA  qw(sha1);
    use Mojo::JSON qw(decode_json encode_json);
    use Test::More;
    use Test::Mojo;
    
    
    use FindBin;
    #require "$FindBin::Bin/../lib";
    use lib "/home/mburns/projects/bb/shiftboard/Audition-WebService/lib";
    
    # Some hash
    my $test_input = "split me";
    my $want = { 'even' => ['p', 'i', ' ', 'e'], 'odd'  => ['s', 'l', 't', 'm']};
    
    # Test the splitting up of string
    my $test_output = Audition::WebService::split_elements($test_input);
    my $test_result = Audition::WebService::join_elements($test_output->{'odd'}, $test_output->{'even'});
    is($test_result, $test_input, 'Split and then rejoin');
    
    my $t = Test::Mojo->new;
    
    # Test invalid authentication.
    my $url = $t->ua->server->url->userinfo('bad:terrible')->path('/split');
    $t->post_ok($url => json => $test_data)->status_is(401);
    $url = $t->ua->server->url->userinfo('bad:terrible')->path('/join');
    $t->post_ok($url => json  => $want)->status_is(401);
    
    # Test with valid signature and credentials
    my $test_data = {'string' => $test_input};
    my $good_signature = sha1($test_input);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $good_signature});
    $t->post_ok($url => json => $test_data)->status_is(200);
    
    my $good_signature = sha1(encode_json($want));
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $url->query({signature => $good_signature});
    $t->post_ok($url => json => $want)->status_is(200);
    
    # Test for missing signature
    my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $t->post_ok($url => json => $test_data)->status_is(403);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $t->post_ok($url => json => $test_data)->status_is(403);
    
    # Test for tampered signature
    my $bad_signature = sha1($test_input . "corruption");
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $bad_signature});
    $t->post_ok($url => json => $test_data)->status_is(403);
    
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $url->query({signature => $bad_signature});
    $t->post_ok($url => json => $want)->status_is(403);
    
    
    # Test with valid signature
    my $good_signature = sha1($test_input);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $good_signature});
    $t->post_ok($url => json)->status_is(200);
    
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $url->query({signature => $good_signature});
    $t->post_ok($url => json)->status_is(200);
    
    done_testing();
    
    __END__

# DONE Golf - (eliminate extra code)<a id="orgheadline7"></a>

# TODO System Integration<a id="orgheadline11"></a>

## DONE Monitoring<a id="orgheadline8"></a>

    use strict;
    use warnings;
    use Riemann::Client;
    use sigtrap qw/handler signal_handler normal-signals/;
    
    sub handler {   # 1st argument is signal name
            my($sig) = @_;
            print "Caught a SIG$sig--shutting down\n";
            close(LOG);
            exit(0);
            }
    
    sub activate_monitor_signal {
        my $r = Riemann::Client->new(
            host => 'localhost',
            port => 5555,
        );
        $r->send({service => 'api_metrics', metric => 2.5});
    
        $r->send({
            host    => Net::Domain::hostfqdn() || 'api',
            service => 'partition_reduction',
            state   => 'active',
            metric  => 1,
            time    => time() - 10, # defaults to time()
            description => '1 api server actively reporting data from application.',
        });
        my $res = $r->query('true');     # Get all the states from the server
        $res = $r->query('state = "active"');
    }
    
    $SIG{'INT'}  = \&activate_monitor_signal;
    $SIG{'QUIT'} = \&handler;
    
    
        # host and port are optional

## DONE Logging<a id="orgheadline9"></a>

## DONE Framework Utilization<a id="orgheadline10"></a>

# DONE Documentation<a id="orgheadline12"></a>

# Dependencies<a id="orgheadline13"></a>

# Application Logic<a id="orgheadline20"></a>

## Application functionality odd -even<a id="orgheadline14"></a>

## Basic Authentication using webservice<a id="orgheadline15"></a>

## Application functionality lastResult<a id="orgheadline16"></a>

## Application Functionality: return 401 on unsuccessful auth<a id="orgheadline17"></a>

## Application Functionality: return 403 on invalid sha1<a id="orgheadline18"></a>

## Application Functionality: return 422 on missing parameters<a id="orgheadline19"></a>

# Code<a id="orgheadline21"></a>

    package Audition::WebService;
    use strict;
    use warnings;
    use Digest::SHA qw(sha1);
    use List::MoreUtils qw(zip);
    use Mojolicious::Lite;
    use Mojo::URL;
    #use Mojo::UserAgent;
    use Mojo::Util qw(secure_compare);
    
    plugin 'Config';
    
    sub combine {
        my ($odd, $even) = @_;
        return undef unless scalar @$odd > 0 && scalar @$even > 0;
        return join '', @zip(@$odd, @$even);
    }
    
    sub partition {
        my @array = split('', $_[0]);
        return undef unless scalar @array > 0;
        my @odd = map {"$_"} @array[grep {!($_ & 1)} 0..$#array]; # bitwise AND array position select odd
        my @even = map {"$_"} @array[grep {($_ & 1)} 0..$#array]; # invert logic to take even
        return {even => \@even, odd => \@odd};
    }
    
    under(sub { # Authentication
        my $c = shift;
        my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo);
        $c->ua->get(Mojo::URL->new($ENV{"$name_auth_url"} || app->config('auth_url'))
                    ->query({username=>$username, password=>$password})
                    => {Accept=>'application/json'})->res == 200
                    ? return 1 : return $c->render(json=>{message=>"Invalid"})->rendered(401);
          }
        );
    
    group { # Valid API Requirement Assertions
        under sub {
            my $c = shift;
            my $signature = $c->param('signature') || undef;
            my $string =  $c->req->json->{string} || undef;
            return $c->render(json=>{message=>"Parameter required)"})->rendered(422) unless $string;
            return $c->render(json=>{message=>"Checksum failure"})->rendered(403) unless $signature && ($signature eq sha1($string));
        };
        post '/split' => sub {
            my $c  = shift;
            my $odds_n_evens = partition($c->req->json->{string}) || undef;
            return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422) unless $odds_n_evens;
            $c->session('returned_last'=>$odds_n_evens);
            return $c->render(json=>$odds_n_evens)->rendered(200);
        };
        post '/join' => sub {
            my $c  = shift;
            my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
            my $joined = combine($odd, $even);
            return $c->render(json=>{message=>"Parameter required"})->rendered(422) unless $joined;
            $c->session('returned_last' => $joined);
            return $c->render(json => $joined)->rendered(200);
        };
    };
    
    get '/lastResponse' => sub {
        my $c = shift;
        $c->render(json=>$c->session('returned_last')) || undef;
    };
    
    any '/' => sub { # Main login action
        my $c = shift;
        my $user = $c->param('user') || '';
        my $pass = $c->param('pass') || '';
        return $c->render unless $c->users->check($user, $pass);
    
        $c->session(user => $user);
        $c->flash(message => 'authenticated');
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
    
    
    sub run {
        my ($ctx) = shift || {};
        my $name = app->config('name');
    
        my $initial_default_state = {
            register=>$ENV{"$name_register_url"} || app->config('register_url'),
            auth=>$ENV{"$name_auth_url"} || app->config('auth_url'),
            app_name=>$name,
            status=>'stopped',
            cfgs=>app->config
        };
    
        my $closed_lambda = sub {
            my $s = shift || $intial_default_state_;
            return sub {
                $s->{status=>'start'};
                app->log->debug("starting $name");
                get '/'=>'with_config';
                $state_ctx->{status=>'running'};
                return {app=>app->start, state=>$s};
            };
        }
    
        my $run_state = $closed_lambda->($default_state)->($ctx);
    
    }
    
    run() unless caller();
    1;
    
    __DATA__
    @@ with_config.html.ep
    <!DOCTYPE html>
    <html>
      <head><title><%= config 'name' %></title></head>
      <body>Welcome to <%= config 'name' %></body>
    </html>
    
    __END__
    
    
    
    #!/usr/bin/env perl
    use Mojolicious::Lite;
    
    use lib 'lib';
    use Audition::WebService;
    # Make signed cookies tamper resistant
    app->secrets([$ENV{APP_COOKIE_SIGNING_KEY} || 'DeletedCodeIsDebuggedCode']);
    helper users => sub { state $users = Audition::WebService::Users->new };
    
    
    
    
    sub is_digestable {
        my $args = shift;
        my ($sha, $data)  = @{$args}{qw(sha data)};
        return undef unless $sha && $data;
    
        $sha eq sha1($data) ? return 1 : return 0;
    }
    
    sub authenticate {
        my $args = shift;
        my ($c, $url, $username, $password)  = @{$args}{qw(ctx url username password)};
        return undef unless $username && $password;
    
        my $json = try {
            $c->ua->get($url)->result->json;
        } catch {
            warn "caught error: $_";
        };
        return secure_compare $c->req->url->to_abs->userinfo, "$username:$password";
    }
    
    sub is_authenticated {
        my $args = shift;
        my ($c, $url, $username, $password)  = @{$args}{qw(ctx url username password)};
        return undef unless $username && $password;
    
        my $json = $c->ua->get($url)->result->json;
        return secure_compare $c->req->url->to_abs->userinfo, "$username:$password";
    }
    
    
    get '/' => sub {
        my $c = shift;
        if is_authenticated({ctx =>$c, url=>'', username=>$username, password=>$password}) {
            return $c->render(text => 'Welcome priveledged one!');
        }
      $c->res->headers->www_authenticate('Basic');
      $c->render(text => 'Halt who goes there!', status => 401);
    };
