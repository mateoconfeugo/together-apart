<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline1">1. Program Descriptions</a></li>
<li><a href="#orgheadline2">2. Usage</a></li>
<li><a href="#orgheadline3">3. Summary</a></li>
<li><a href="#orgheadline15">4. Application specification</a>
<ul>
<li><a href="#orgheadline4">4.1. General Requirements</a></li>
<li><a href="#orgheadline5">4.2. API Endpoint Function Requirements</a></li>
<li><a href="#orgheadline7">4.3. F1 - Split string into even and odd character arrays, Assume first character 1, is odd</a>
<ul>
<li><a href="#orgheadline6">4.3.1. Code</a></li>
</ul>
</li>
<li><a href="#orgheadline9">4.4. F2 - join undo split</a>
<ul>
<li><a href="#orgheadline8">4.4.1. Code</a></li>
</ul>
</li>
<li><a href="#orgheadline12">4.5. F3 - Last result</a>
<ul>
<li><a href="#orgheadline10">4.5.1. Test</a></li>
<li><a href="#orgheadline11">4.5.2. Code</a></li>
</ul>
</li>
<li><a href="#orgheadline13">4.6. API Tests</a></li>
<li><a href="#orgheadline14">4.7. G1</a></li>
</ul>
</li>
<li><a href="#orgheadline17">5. Dev Tools</a>
<ul>
<li><a href="#orgheadline16">5.1. dependencies</a></li>
</ul>
</li>
<li><a href="#orgheadline18">6. Configuration</a></li>
<li><a href="#orgheadline29">7. Application  Logic</a>
<ul>
<li><a href="#orgheadline19">7.1. F1</a></li>
<li><a href="#orgheadline20">7.2. F2</a></li>
<li><a href="#orgheadline21">7.3. F3</a></li>
<li><a href="#orgheadline24">7.4. Basic Authentication using webservice</a>
<ul>
<li><a href="#orgheadline22">7.4.1. Code</a></li>
<li><a href="#orgheadline23">7.4.2. Test</a></li>
</ul>
</li>
<li><a href="#orgheadline26">7.5. API Interface</a>
<ul>
<li><a href="#orgheadline25">7.5.1. Error Codes</a></li>
</ul>
</li>
<li><a href="#orgheadline27">7.6. Access Management</a></li>
<li><a href="#orgheadline28">7.7. Application Code</a></li>
</ul>
</li>
<li><a href="#orgheadline33">8. System Integration</a>
<ul>
<li><a href="#orgheadline30">8.1. Systemd</a></li>
<li><a href="#orgheadline32">8.2. Monitoring</a>
<ul>
<li><a href="#orgheadline31">8.2.1. Toggle</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline34">9. Environment Variables</a></li>
<li><a href="#orgheadline35">10. Test Suite</a></li>
<li><a href="#orgheadline36">11. Build</a></li>
<li><a href="#orgheadline42">12. Provision</a>
<ul>
<li><a href="#orgheadline37">12.1. <span class="todo TODO">TODO</span> Appliance (App + Packer Image)</a></li>
<li><a href="#orgheadline38">12.2. <span class="todo TODO">TODO</span> Docker Image</a></li>
<li><a href="#orgheadline39">12.3. <span class="todo TODO">TODO</span> Platform Runtime Orchestration</a></li>
<li><a href="#orgheadline40">12.4. <span class="todo TODO">TODO</span> SSL</a></li>
<li><a href="#orgheadline41">12.5. <span class="todo TODO">TODO</span> Reverse Proxy</a></li>
</ul>
</li>
<li><a href="#orgheadline44">13. Release</a>
<ul>
<li><a href="#orgheadline43">13.1. Push</a></li>
</ul>
</li>
<li><a href="#orgheadline53">14. Deployment</a>
<ul>
<li><a href="#orgheadline52">14.1. <span class="todo TODO">TODO</span> Package</a>
<ul>
<li><a href="#orgheadline45">14.1.1. logging/rotation</a></li>
<li><a href="#orgheadline46">14.1.2. pid</a></li>
<li><a href="#orgheadline47">14.1.3. system user</a></li>
<li><a href="#orgheadline48">14.1.4. group</a></li>
<li><a href="#orgheadline49">14.1.5. var/data</a></li>
<li><a href="#orgheadline50">14.1.6. auditing</a></li>
<li><a href="#orgheadline51">14.1.7. software defined storage</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline58">15. Continuous Delivery /Continuous Integration</a>
<ul>
<li><a href="#orgheadline54">15.1. built-in api devops endpoint</a></li>
<li><a href="#orgheadline55">15.2. sites-available</a></li>
<li><a href="#orgheadline56">15.3. sites-enabled</a></li>
<li><a href="#orgheadline57">15.4. restart</a></li>
</ul>
</li>
<li><a href="#orgheadline60">16. Appendix A:   DevOps Document Overview</a>
<ul>
<li><a href="#orgheadline59">16.1. Features</a></li>
</ul>
</li>
<li><a href="#orgheadline61">17. Appendex B: System 3rd Party Dependencies/Requirements</a></li>
</ul>
</div>
</div>


# Program Descriptions<a id="orgheadline1"></a>

# Usage<a id="orgheadline2"></a>

This application provides a simple REST inspired service to divide a character string into odd and
even arrays and then join the arrays back into the original charter string.

# Summary<a id="orgheadline3"></a>

    # INITIALIZATION
    my $ctx = {};
    
    my $state = {
        register=>$ENV{"register_url"} || app->config('register_url'),
        auth=>$ENV{"auth_url"} || app->config('auth_url'),
        app_name=>$ENV{"app_name"} || app->config('name'),
        status=>'stopped',
        cfgs=>app->config
    };
    
    my $run = sub {
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
        my $process = $run->($state)->($ctx);
        app->start;
    }
    
    cli() unless caller();
    1;

# Application specification<a id="orgheadline15"></a>

[Coding Exercise Specification](file:///home/mburns/Downloads/backend_coding_exercise.pdf)

## General Requirements<a id="orgheadline4"></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Spec ID</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">G0</td>
<td class="org-left">Create valid credentials via register service <https://interview-api.shiftboard.com/auth></td>
</tr>


<tr>
<td class="org-left">G1</td>
<td class="org-left">All requests must include basic auth.</td>
</tr>


<tr>
<td class="org-left">G2</td>
<td class="org-left">Validated against at auth service <https://interview-api.shiftboard.com/auth>.</td>
</tr>


<tr>
<td class="org-left">G3</td>
<td class="org-left">Unsuccessful attempts return 401</td>
</tr>


<tr>
<td class="org-left">G4</td>
<td class="org-left">POSTs are a JSON formated object</td>
</tr>


<tr>
<td class="org-left">G5</td>
<td class="org-left">Required SHA1 posted content digest query parameter, signature, return 403 if  invalid</td>
</tr>


<tr>
<td class="org-left">G6</td>
<td class="org-left">Missing parameters return 422</td>
</tr>


<tr>
<td class="org-left">G7</td>
<td class="org-left">Operate in a non-sticky, load balanced environment.</td>
</tr>
</tbody>
</table>

## API Endpoint Function Requirements<a id="orgheadline5"></a>

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="org-left" />

<col  class="org-left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Spec ID</th>
<th scope="col" class="org-left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left">F1</td>
<td class="org-left">Split string into even and odd character arrays, Assume first character 1, is odd.</td>
</tr>


<tr>
<td class="org-left">F2</td>
<td class="org-left">The user/pass will successfully authenticate against <https://interview-api.shiftboard.com/auth>.</td>
</tr>


<tr>
<td class="org-left">F3</td>
<td class="org-left">Last result depending on method called last</td>
</tr>
</tbody>
</table>

## F1 - Split string into even and odd character arrays, Assume first character 1, is odd<a id="orgheadline7"></a>

-   Input: JSON object key "string" contains string.
-   Output: JSON object keys odd and even each an array of characters.

    curl -X POST -u USER:PASS \

Example        Response:
{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}

    POST http://localhost:3000/split?signature=04e74f3b8cfcf0b502ff701a9b5f0b98ece0d3b4
    Accept: application/json
    
    {"string":"split me"}

### Code<a id="orgheadline6"></a>

    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422)
          unless $split;
        $c->session('returned_last'=>$split);
        return $c->render(json=>$split)->rendered(200);
    };

## F2 - join undo split<a id="orgheadline9"></a>

-   INPUT: {"odd":["s","l","t","m"], "even":["p","i"," ","e"]}
-   OUTPUT: {"string":"split me"}

    curl -X POST -u USER:PASS \
    http://localhost:3000/join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404 \
    -d '{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}'

    POST http://localhost:3000/join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404
    Accept: application/json
    
    {"odd":["s","l","t","m"], "even":["p","i"," ","e"]}

### Code<a id="orgheadline8"></a>

    post '/join'=>sub {
        my $c  = shift;
        my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
        my $join = together($odd, $even);
        return $c->render(json=>{message=>"Parameter required"})->rendered(422)
          unless $join;
        $c->session('returned_last'=>$join);
        return $c->render(json=>$join)->rendered(200);
    };

## F3 - Last result<a id="orgheadline12"></a>

-   INPUT: {}
-   OUTPUT: [{"string":"split me"} || {"odd":["s","l","t","m"], "even":["p","i"," ","e"]}]

    curl -X POST -u USER:PASS \
    http://localhost:3000/join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404 \
    -d '{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}'

    POST http://localhost:3000/lastResult
    Accept: application/json

### Test<a id="orgheadline10"></a>

### Code<a id="orgheadline11"></a>

    get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};

## API Tests<a id="orgheadline13"></a>

    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $good_signature});
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
    $t->post_ok($url=>json=>$test_data)->status_is(200);

## G1<a id="orgheadline14"></a>

# Dev Tools<a id="orgheadline17"></a>

    any '/' => sub { # Main login action
        my $c = shift;
        my ($u, $p) = split(':',  $c->req->url->to_abs->userinfo);
        $u =  $c->param('username') || $u;
        $p = $c->param('password') || $p;
    
        return $c->render
          unless $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                                            ->query({username=>$u, password=>$p})
                                            => {Accept=>'application/json'})->res == 200;
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

## dependencies<a id="orgheadline16"></a>

# Configuration<a id="orgheadline18"></a>

    {
     auth_url => 'https://interview-api.shiftboard.com/auth',
     name => 'partition_combiner',
     register_url => 'https://interview-api.shiftboard.com/register'
    }

# Application  Logic<a id="orgheadline29"></a>

## F1<a id="orgheadline19"></a>

    sub together {
        my ($odd, $even) = @_;
        return undef unless scalar @$odd > 0 && scalar @$even > 0;
        return join '', zip(@$odd, @$even);
    }

## F2<a id="orgheadline20"></a>

    sub apart {
        my @array = split('', $_[0]);
        return undef
          unless scalar @array > 0;
        my @odd = map {"$_"} @array[grep {!($_ & 1)} 0..$#array]; # bitwise AND array position select odd
        my @even = map {"$_"} @array[grep {($_ & 1)} 0..$#array]; # invert logic to take even
        return {even => \@even, odd => \@odd};
    }

## F3<a id="orgheadline21"></a>

    get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};

## Basic Authentication using webservice<a id="orgheadline24"></a>

### Code<a id="orgheadline22"></a>

    under(sub { my $c = shift; # Basic Authentication for each request
                my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo);
                $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                            ->query({username=>$username, password=>$password})
                            => {Accept=>'application/json'})->res == 200
                            ? return 1
                            : return $c->render(json=>{message=>"Invalid"})->rendered(401)});

### Test<a id="orgheadline23"></a>

    subtest 'testing registered authentication' => sub {
        plan tests => 2;
        my $module = Test::MockModule->new('Audition::WebService');
        $module->mock('apart', sub { return $desired_apart });
        $module->mock('together', sub { return $desired_together });
        Module::Name::subroutine(@args);
        my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
        $url->query({signature => $good_signature});
        $t->post_ok($url=>json=>$test_data)->status_is(200);
        $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
        $t->post_ok($url=>json=>$test_data)->status_is(200);
        $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
        $t->post_ok($url=>json=>$test_data)->status_is(200);
    };

## API Interface<a id="orgheadline26"></a>

    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422)
          unless $split;
        $c->session('returned_last'=>$split);
        return $c->render(json=>$split)->rendered(200);
    };
    post '/join'=>sub {
        my $c  = shift;
        my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
        my $join = together($odd, $even);
        return $c->render(json=>{message=>"Parameter required"})->rendered(422)
          unless $join;
        $c->session('returned_last'=>$join);
        return $c->render(json=>$join)->rendered(200);
    };

### Error Codes<a id="orgheadline25"></a>

-   Application Functionality: return 401 on unsuccessful auth
-   Application Functionality: return 403 on invalid sha1
-   Application Functionality: return 422 on missing parameters

## Access Management<a id="orgheadline27"></a>

    under sub { # Valid API Requirement Assertions
        my $c = shift;
        my $signature = $c->param('signature') || undef;
        my $string =  $c->req->json->{string} || undef;
        return $c->render(json=>{message=>"Parameter required)"})->rendered(422)
          unless $string;
        return $c->render(json=>{message=>"Checksum failure"})->rendered(403)
          unless $signature && ($signature eq sha1($string));
    };

## Application Code<a id="orgheadline28"></a>

    use strict;
    use warnings;
    
    package Audition::WebService;
    use Digest::SHA qw(sha1);
    use List::MoreUtils qw(zip);
    #use Mojolicious::Lite;
    use Mojo::Base "Mojolicious";
    use Mojo::URL;
    use Mojo::Util qw(secure_compare);
    use Riemann::Client;
    use sigtrap qw/handler signal_handler normal-signals/;
    
    sub startup {
        my $app = shift;
        $app->plugin(Swagger2 => {url => "data://Audition::WebService/api.json"});
      }
    
    plugin 'Config';
    
    sub together {
        my ($odd, $even) = @_;
        return undef unless scalar @$odd > 0 && scalar @$even > 0;
        return join '', zip(@$odd, @$even);
    }
    sub apart {
        my @array = split('', $_[0]);
        return undef
          unless scalar @array > 0;
        my @odd = map {"$_"} @array[grep {!($_ & 1)} 0..$#array]; # bitwise AND array position select odd
        my @even = map {"$_"} @array[grep {($_ & 1)} 0..$#array]; # invert logic to take even
        return {even => \@even, odd => \@odd};
    }
    under(sub { my $c = shift; # Basic Authentication for each request
                my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo);
                $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                            ->query({username=>$username, password=>$password})
                            => {Accept=>'application/json'})->res == 200
                            ? return 1
                            : return $c->render(json=>{message=>"Invalid"})->rendered(401)});
    
    group {
            under sub { # Valid API Requirement Assertions
                my $c = shift;
                my $signature = $c->param('signature') || undef;
                my $string =  $c->req->json->{string} || undef;
                return $c->render(json=>{message=>"Parameter required)"})->rendered(422)
                  unless $string;
                return $c->render(json=>{message=>"Checksum failure"})->rendered(403)
                  unless $signature && ($signature eq sha1($string));
            };
        
                post '/split'=>sub {
                    my $c  = shift;
                    my $split = apart($c->req->json->{string}) || undef;
                    return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422)
                      unless $split;
                    $c->session('returned_last'=>$split);
                    return $c->render(json=>$split)->rendered(200);
                };
                post '/join'=>sub {
                    my $c  = shift;
                    my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
                    my $join = together($odd, $even);
                    return $c->render(json=>{message=>"Parameter required"})->rendered(422)
                      unless $join;
                    $c->session('returned_last'=>$join);
                    return $c->render(json=>$join)->rendered(200);
                };
            
    };
    
    any '/' => sub { # Main login action
        my $c = shift;
        my ($u, $p) = split(':',  $c->req->url->to_abs->userinfo);
        $u =  $c->param('username') || $u;
        $p = $c->param('password') || $p;
    
        return $c->render
          unless $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                                            ->query({username=>$u, password=>$p})
                                            => {Accept=>'application/json'})->res == 200;
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
    # INITIALIZATION
    my $ctx = {};
    
    my $state = {
        register=>$ENV{"register_url"} || app->config('register_url'),
        auth=>$ENV{"auth_url"} || app->config('auth_url'),
        app_name=>$ENV{"app_name"} || app->config('name'),
        status=>'stopped',
        cfgs=>app->config
    };
    
    my $run = sub {
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
        my $process = $run->($state)->($ctx);
        app->start;
    }
    
    cli() unless caller();
    1;
    
      __DATA__
      @@ together_apart.json
      {
        "swagger": "2.0",
        "info": {...},
        "host": "petstore.swagger.wordnik.com",
        "basePath": "/api",
        "paths": {
          "/pets": {
            "get": {...}
          }
        }
      }

# System Integration<a id="orgheadline33"></a>

## Systemd<a id="orgheadline30"></a>

    systemctl stop partition_combiner
    systemctl start partition_combiner
    systemctl status partition_combiner

## Monitoring<a id="orgheadline32"></a>

### Toggle<a id="orgheadline31"></a>

    pgrep audition | kill 11

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

# Environment Variables<a id="orgheadline34"></a>

    export partition_combiner_auth_url='https://interview-api.shiftboard.com/auth';
    export partition_combiner_register_url='https://interview-api.shiftboard.com/register';

    sudo apt-get install libmojolicious-perl  libdigest-sha-perl liblist-moreutils-perl libtry-tiny-perl

    use strict;
    use warnings;
    
    package Audition::WebService;
    use Digest::SHA qw(sha1);
    use List::MoreUtils qw(zip);
    #use Mojolicious::Lite;
    use Mojo::Base "Mojolicious";
    use Mojo::URL;
    use Mojo::Util qw(secure_compare);
    use Riemann::Client;
    use sigtrap qw/handler signal_handler normal-signals/;

# Test Suite<a id="orgheadline35"></a>

    use Audition::WebService;
    use Digest::SHA  qw(sha1);
    use Mojo::JSON qw(decode_json encode_json);
    use Test::Mojo;
    use Test::MockModule
    use Test::More;
    
    use FindBin;
    #require "$FindBin::Bin/../lib";
    use lib "/home/mburns/projects/bb/shiftboard/Audition-WebService/lib";
    
    my $desired_together = "split me";
    my $desired_apart = {'even'=>['p', 'i', ' ', 'e'], 'odd'  => ['s', 'l', 't', 'm']};
    my $apart_got = apart($desired_together);
    my $got_together = together($test_output->{'odd'}, $test_output->{'even'});
    is($got_together, $desired_together, 'Odd and even combined into a single numberical sequence');
    is($apart_got, $desired_apart, 'Numbers split into two sequence based on being odd or even');
    
    my $t = Test::Mojo->new;
    
    subtest 'testing registered authentication' => sub {
        plan tests => 2;
        my $module = Test::MockModule->new('Audition::WebService');
        $module->mock('apart', sub { return $desired_apart });
        $module->mock('together', sub { return $desired_together });
        Module::Name::subroutine(@args);
        my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
        $url->query({signature => $good_signature});
        $t->post_ok($url=>json=>$test_data)->status_is(200);
        $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
        $t->post_ok($url=>json=>$test_data)->status_is(200);
        $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
        $t->post_ok($url=>json=>$test_data)->status_is(200);
    };
    
    subtest 'testing api app biz domain functionality' => sub {
        plan tests => 2;
        my $module = Test::MockModule->new('Audition::WebService');
            $module->mock('check_credentials', sub { return 1 });
        Module::Name::subroutine(@args);
        my $test_data = {'string'=>$desired_together};
        my $good_signature = sha1($desired_together);
        my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
        $url->query({signature => $good_signature});
            $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
            $t->post_ok($url=>json=>$test_data)->status_is(200);
            my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
            $url->query({signature => $good_signature});
            $t->post_ok($url=>json=>$test_data)->status_is(200);
            $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
            $t->post_ok($url=>json=>$test_data)->status_is(200);
    };

# Build<a id="orgheadline36"></a>

    prove -v

# Provision<a id="orgheadline42"></a>

## TODO Appliance (App + Packer Image)<a id="orgheadline37"></a>

## TODO Docker Image<a id="orgheadline38"></a>

## TODO Platform Runtime Orchestration<a id="orgheadline39"></a>

## TODO SSL<a id="orgheadline40"></a>

## TODO Reverse Proxy<a id="orgheadline41"></a>

# Release<a id="orgheadline44"></a>

## Push<a id="orgheadline43"></a>

    git push origin release-next

    git push origin release-next

# Deployment<a id="orgheadline53"></a>

## TODO Package<a id="orgheadline52"></a>

    dpkg partition_combiner

### logging/rotation<a id="orgheadline45"></a>

### pid<a id="orgheadline46"></a>

### system user<a id="orgheadline47"></a>

### group<a id="orgheadline48"></a>

### var/data<a id="orgheadline49"></a>

### auditing<a id="orgheadline50"></a>

### software defined storage<a id="orgheadline51"></a>

# Continuous Delivery /Continuous Integration<a id="orgheadline58"></a>

## built-in api devops endpoint<a id="orgheadline54"></a>

Target for github app repo release hook trigger post. Existing running version of the application
sets up and restarts public facing webserver proxying with updated symbolic links for
the site-availabe and sites-enabled point to the next blue green service pair in the the versioned
deployment release chain.

## sites-available<a id="orgheadline55"></a>

## sites-enabled<a id="orgheadline56"></a>

## restart<a id="orgheadline57"></a>

# Appendix A:   DevOps Document Overview<a id="orgheadline60"></a>

Relax, use what you already have - powerful devops tools/practice to automatically maintain and update
your system are just familiar linux stuff and things and a couple simple ideas.

Use the existing tools and practices already in place by major distros to manage application software so
it blends into the ecosystem and plays by the distributions guidelines.  Translation put your software into
correctly formated packages in this debian.  Work on projects like any other open source github project fork.
The thinkng is: make it easy to work on the software and get it running - coupling that with make updating or rollingback easy
while enabling fast recall to the how and why this things.

Harvest low hanging fruit that yeilds nice to have features while in development

-   forensic system analysis via instant replay using atop archive fils + auditd + log files + application virtualized containerization
-   providing a swagger api that allows dev ops tasks to be easily scripted via your favorite language as a client
    creates a feedback path which makes what you can do directly from the devops docs directly or run as a script by
    running emacs as a dynamic language from called from a shell script.  This active documentation is a playbook - an automated one.
-   Use a push system based on ssh and public/private key access.

## Features<a id="orgheadline59"></a>

-   Publishes code into source files
-   Releases the code into the upstream code repository
-   Deploys the code onto the desired runtime platorm (dev, qa, stg, prd)
-   Provisions the runtime infrastruce and like artifacts the application is dependent
-   Capture the functional requirements in automate testable form
-   Understand engineering decisions behind the implementation, design, methodology testing
-   Define the way features are deployed into new versions of this WebService
-   Run tests
-   Provides application documentation
-   Provide development history
-   Provides a reduamentry cli interface to devops/maintence tasks
-   Sets up and runs system from src control repo (github)
-   Provide easy way to refer and collaborate among developers
-   Continous Delivery with rollback
-   Worksheet to aid in project management aspects of software development
-   Bridge that first draft proof of concept devops task into part of the crm/orchestration process
-   Allows the stitching together of many pre-existing tools
-   Incorporate others work via pull requests in a timely fashion
-   Define Idioms
-   Capture domain specific paculiarities

# Appendex B: System 3rd Party Dependencies/Requirements<a id="orgheadline61"></a>

-   Local: Running in the context of a ordinary linux system account
-   A single VPC, with the usual 3 security group setup - internal, web, and bastion.
-   [Terraform](https://www.terraform.io) and for provisioning infrastructure.
-   [Packer](https://www.packer.io) to build a single general-purpose base AMI.
-   API web application
-   Common library components
-   Github hooks to deploy
-   Riemann monitoring integration.
