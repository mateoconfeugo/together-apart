<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline1">1. Description</a></li>
<li><a href="#orgheadline4">2. Application Specification</a>
<ul>
<li><a href="#orgheadline2">2.1. General Requirements</a></li>
<li><a href="#orgheadline3">2.2. API Endpoint Function Requirements</a></li>
</ul>
</li>
<li><a href="#orgheadline5">3. Acceptance Criteria</a></li>
<li><a href="#orgheadline6">4. Usage</a></li>
<li><a href="#orgheadline7">5. Configuration</a></li>
<li><a href="#orgheadline8">6. Perl Dependencies</a></li>
<li><a href="#orgheadline9">7. Release</a></li>
<li><a href="#orgheadline20">8. Deployment</a>
<ul>
<li><a href="#orgheadline10">8.1. Create Debian Package</a></li>
<li><a href="#orgheadline11">8.2. Reverse Proxy Server</a></li>
<li><a href="#orgheadline13">8.3. SSL</a>
<ul>
<li><a href="#orgheadline12">8.3.1. starting secure server</a></li>
</ul>
</li>
<li><a href="#orgheadline14">8.4. built-in api devops endpoint</a></li>
<li><a href="#orgheadline15">8.5. restart</a></li>
<li><a href="#orgheadline19">8.6. Rolling Deployment</a>
<ul>
<li><a href="#orgheadline16">8.6.1. Start first version</a></li>
<li><a href="#orgheadline17">8.6.2. Start second version</a></li>
<li><a href="#orgheadline18">8.6.3. Kill the first version</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline29">9. Application  Logic</a>
<ul>
<li><a href="#orgheadline23">9.1. Basic Authentication using webservice</a>
<ul>
<li><a href="#orgheadline21">9.1.1. Code</a></li>
<li><a href="#orgheadline22">9.1.2. Test</a></li>
</ul>
</li>
<li><a href="#orgheadline25">9.2. API Interface</a>
<ul>
<li><a href="#orgheadline24">9.2.1. Error Codes</a></li>
</ul>
</li>
<li><a href="#orgheadline26">9.3. API Tests</a></li>
<li><a href="#orgheadline27">9.4. Access Management</a></li>
<li><a href="#orgheadline28">9.5. Application Code</a></li>
</ul>
</li>
<li><a href="#orgheadline30">10. Test Suite</a></li>
<li><a href="#orgheadline37">11. System Integration</a>
<ul>
<li><a href="#orgheadline32">11.1. SSL</a>
<ul>
<li><a href="#orgheadline31">11.1.1. Lets Encrypt - certbot</a></li>
</ul>
</li>
<li><a href="#orgheadline36">11.2. Systemd</a>
<ul>
<li><a href="#orgheadline33">11.2.1. hypnotoad</a></li>
<li><a href="#orgheadline34">11.2.2. Reload systemctl daemon</a></li>
<li><a href="#orgheadline35">11.2.3. rsyslog</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline44">12. Appendix A: TODO</a>
<ul>
<li><a href="#orgheadline42">12.1. Goals</a>
<ul>
<li><a href="#orgheadline38">12.1.1. manage technical debt (versioning, release, deploy, documentation, test)</a></li>
<li><a href="#orgheadline39">12.1.2. automatically maintain and update</a></li>
<li><a href="#orgheadline40">12.1.3. make it easy to run/work on the software</a></li>
<li><a href="#orgheadline41">12.1.4. checklists to help foster better development security practices</a></li>
</ul>
</li>
<li><a href="#orgheadline43">12.2. Design Tasks <code>[20/20]</code></a></li>
</ul>
</li>
<li><a href="#orgheadline45">13. Appendix B: System 3rd Party Dependencies/Requirements</a></li>
<li><a href="#orgheadline47">14. Appendix C: REPL /Debugger</a>
<ul>
<li><a href="#orgheadline46">14.1. Testing G7 - Setting up non sticky environment</a></li>
</ul>
</li>
</ul>
</div>
</div>


# Description<a id="orgheadline1"></a>

This application provides a basic authenticated  REST like service dividing strings into odd and
even arrays and rejoining arrays into original strings.

# [Application Specification](file:///home/mburns/Downloads/backend_coding_exercise.pdf)<a id="orgheadline4"></a>

## General Requirements<a id="orgheadline2"></a>

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

## API Endpoint Function Requirements<a id="orgheadline3"></a>

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

# Acceptance Criteria<a id="orgheadline5"></a>

    :curl -X POST -u USER:PASS \
    http://matt-burns.shftbrd.com/split?signature=04e74f3b8cfcf0b502ff701a9b5f0b98ece0d3b4 \
    -d '{"string":"split me"}'

    curl -X POST -u USER:PASS \
    http://localhost/split?signature=04e74f3b8cfcf0b502ff701a9b5f0b98ece0d3b4 \
    -d '{"string":"split me"}'

{"message":{"odd":["s","l","t","m"],"even":["p","i"," ","e"]}}

    curl -X POST -u USER:PASS \
    https://localhost/split?signature=04e74f3b8cfcf0b502ff701a9b5f0b98ece0d3b4 \
    -d '{"string":"split me"}'

    curl -X POST -u USER:PASS \
    http://matt-burns.shftbrd.com/join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404 \
    -d '{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}'

    curl -X POST -u USER:PASS \
    http://localhost/join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404 \
    -d '{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}'

{"message":"split me"}

    curl -X POST -u USER:PASS \
    https://localhost:join?signature=6edd74450aa9206c4ba0b8c009de382a3e91f404 \
    -d '{"odd":["s","l","t","m"], "even":["p","i"," ","e"]}'

    curl -u USER:PASS http://matt-burns.shftbrd.com/lastResponse

    curl -u USER:PASS http://localhost/lastResponse

    curl -u USER:PASS https://localhost/lastResponse

    prove -v -I/../Together-Apart/lib t/acceptance.t

    # Subtest: business unit tests.
        1..3
        ok 1 - Odd and even combined into a single numberical sequence
        ok 2 - Numbers split into two sequences these the odd
        ok 3 - Numbers split into two sequence these are the even
    ok 1 - business unit tests.
    # Subtest: API usage mocking registered auth. see F1, F2, F3, G0, G1, G2, G3, G4, G5, G6
        1..10
        ok 1 - POST http://TBD:TBD@127.0.0.1:35837/split?signature=%3AjQ%C2%BF%C3%87%16%C3%A3j7%C3%A7%19_V%C2%8A%C3%B7u%27%3Fm%22
        ok 2 - 200 OK
        ok 3 - POST http://TBD:TBD@127.0.0.1:35837/split?signature=%3AjQ%C2%BF%C3%87%16%C3%A3j7%C3%A7%19_V%C2%8A%C3%B7u%27%3Fm%22
        ok 4 - 422 Unprocessable Entity
        ok 5 - POST http://TBD:TBD@127.0.0.1:35837/join?signature=%C2%B6D%C3%85%18%3B5%C3%8E%C2%86%0B%0Ef%C3%8D%04%5C%126%C3%94%05%C2%A5%C3%90
        ok 6 - 200 OK
        ok 7 - POST http://TBD:TBD@127.0.0.1:35837/join?signature=%C2%B6D%C3%85%18%3B5%C3%8E%C2%86%0B%0Ef%C3%8D%04%5C%126%C3%94%05%C2%A5%C3%90
        ok 8 - 422 Unprocessable Entity
        ok 9 - GET http://TBD:TBD@127.0.0.1:35837/lastResponse
        ok 10 - Basic auth check on each endpoint called the mock auth webservice
    ok 2 - API usage mocking registered auth. see F1, F2, F3, G0, G1, G2, G3, G4, G5, G6
    1..2
    ok
    All tests successful.
    Files=1, Tests=2,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.20 cusr  0.02 csys =  0.24 CPU)
    Result: PASS

# Usage<a id="orgheadline6"></a>

    sub run {
        app->secrets(['DeletedCodeIsDebuggedCode']);
        app->log->info("starting");
        app->start;
    }
    
    run() unless caller();
    1;

# Configuration<a id="orgheadline7"></a>

    {
     auth_url => 'https://interview-api.shiftboard.com/auth',
     name => 'together_apart',
     register_url => 'https://interview-api.shiftboard.com/register',
     public=> "/home/mburns/projects/bb/shiftboard/docs",
    
     hypnotoad => {
       pidfile=>"~/together-apart/script/hypnotoad.pid",
       listen  => ['http://*:80', 'https://*:443?cert=/etc/server.crt&key=/etc/server.key'],
       workers => 10
      }
    }

# Perl Dependencies<a id="orgheadline8"></a>

    use strict;
    use warnings;
    
    package Together::Apart;
    
    use Digest::SHA qw(sha1);
    use List::MoreUtils qw(zip);
    use Mojo::Asset::File;
    use Mojolicious::Lite;
    use Mojo::Base "Mojolicious";
    use Mojolicious::Static;
    use Mojo::URL;
    
    plugin 'Config';

# Release<a id="orgheadline9"></a>

    git push origin release-next

# Deployment<a id="orgheadline20"></a>

    git pull origin master

    sudo perl -I./lib lib/Together/Apart.pm daemon -l http://[::]:80

## Create Debian Package<a id="orgheadline10"></a>

    dzil clean && dzil build
    dh-make-perl make  Together-Apart/Together-Apart-0.01

    dpkg together-apart --pre-invoke test-features-absent --post-invoke test-features-present --status-fd ./current-status --build ../dist/

## Reverse Proxy Server<a id="orgheadline11"></a>

In front of app acting as the endpoint accessible by external clients.

-   terminating SSL connections from the outside,
-   limits the number of concurrent open sockets towards the app
-   balancing load across multiple instances,
-   supporting several applications through the same IP/port.

## SSL<a id="orgheadline13"></a>

    hypnotoad => {
       listen  => ['https://*:443?cert=/etc/server.crt&key=/etc/server.key'],
       proxy   => 1,
       workers => 10
     }

### starting secure server<a id="orgheadline12"></a>

    $ ./script/together_apart daemon -l https://[::]:443

## built-in api devops endpoint<a id="orgheadline14"></a>

Target for github app repo release hook trigger post. Existing running version of the application
sets up and restarts public facing webserver proxying with updated symbolic links for
the site-availabe and sites-enabled point to the next blue green service pair in the the versioned
deployment release chain.

## restart<a id="orgheadline15"></a>

    hypnotoad ./script/together_apart

## Rolling Deployment<a id="orgheadline19"></a>

### Start first version<a id="orgheadline16"></a>

    ./script/together_apart prefork -P /tmp/first.pid -l http://*:3000?reuse=1

### Start second version<a id="orgheadline17"></a>

    ./script/together_apart prefork -P /tmp/second.pid -l http://*:3000?reuse=1

### Kill the first version<a id="orgheadline18"></a>

    kill -s TERM `cat /tmp/first.pid`

# Application  Logic<a id="orgheadline29"></a>

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

    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"}, status=>422)
            unless $split;
        $c->session->{'returned_last'} = $split;
        return $c->render(json=>{message=>$split}, status=>200);
    };

    get '/lastResponse'=>sub {
        my $c = shift;
        my $last = $c->session->{'returned_last'};
        return $c->render(json=>{message=>$last}, status=>200);
    };

## Basic Authentication using webservice<a id="orgheadline23"></a>

### Code<a id="orgheadline21"></a>

    sub check_credentials {
        my $c = shift;
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
            : return 0;
    }
    
    under(sub {my $c = shift; # Basic Authentication for each request
               $c->render(json=>{message=>"Invalid"}, status=>401)
                   unless check_credentials $c
          });

### Test<a id="orgheadline22"></a>

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

## API Interface<a id="orgheadline25"></a>

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

### Error Codes<a id="orgheadline24"></a>

-   G3 Application Functionality: return 401 on unsuccessful
-   G5 Application Functionality: return 403 on invalid sha1
-   G6 Application Functionality: return 422 on missing parameters

## API Tests<a id="orgheadline26"></a>

    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $good_signature});
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
    $t->post_ok($url=>json=>$test_data)->status_is(200);

## Access Management<a id="orgheadline27"></a>

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

## Application Code<a id="orgheadline28"></a>

    #ABSTRACT: split join api endpoints
    use strict;
    use warnings;
    
    package Together::Apart;
    
    use Digest::SHA qw(sha1);
    use List::MoreUtils qw(zip);
    use Mojo::Asset::File;
    use Mojolicious::Lite;
    use Mojo::Base "Mojolicious";
    use Mojolicious::Static;
    use Mojo::URL;
    
    plugin 'Config';
    
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
    sub together {
        my ($odd, $even) = @_;
        return undef
            unless $odd && $even;
        return undef
            unless (scalar @$odd > 0 && scalar @$even > 0);
        return join '', zip(@$odd, @$even);
    }
    sub check_credentials {
        my $c = shift;
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
            : return 0;
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
    
    get '/'=>sub {
        my $c = shift;
        $c->res->headers->content_type('text/html');
        $c->reply->asset(Mojo::Asset::File->new(path => './public/index.html'))
    };
    
    get '/org.css'=>sub {
        my $c = shift;
        $c->res->headers->content_type('text/css');
        $c->reply->asset(Mojo::Asset::File->new(path => './public/org.css'));
    };
    
    sub run {
        app->secrets(['DeletedCodeIsDebuggedCode']);
        app->log->info("starting");
        app->start;
    }
    
    run() unless caller();
    1;

# Test Suite<a id="orgheadline30"></a>

    prove -v -I./lib t/acceptance.t

    use Digest::SHA  qw(sha1);
    use Mojo::JSON qw(decode_json encode_json);
    use Test::Mojo;
    use Test::MockModule;
    use Test::More;
    use FindBin;
    use lib "../lib";
    
    use Together::Apart;
    
    my $desired_together = "split me";
    my $desired_apart = {'odd'  => ['s', 'l', 't', 'm'],'even'=>['p', 'i', ' ', 'e'] };
    my $apart_got = Together::Apart::apart($desired_together);
    my $got_together = Together::Apart::together(['s', 'l', 't', 'm'], ['p', 'i', ' ', 'e']);
    
    subtest 'business unit tests.' => sub {
      plan tests => 3;
      is($got_together, $desired_together, 'Odd and even combined into a single numberical sequence');
      is(@{$apart_got->{odd}}, @{['s', 'l', 't', 'm']}, 'Numbers split into two sequences these the odd');
      is(@{$apart_got->{even}}, @{['p', 'i', ' ', 'e']}, 'Numbers split into two sequence these are the even');
    };
    
    my $t = Test::Mojo->new;
    
    subtest 'API usage mocking registered auth. see F1, F2, F3, G0, G1, G2, G3, G4, G5, G6' => sub {
      plan tests => 10;
      my $auth_called = 0;
      my $register_called = 0;
      my $module = Test::MockModule->new('Together::Apart');
      $module->mock('register', sub { $register_called += 1; return 1; });
      Together::Apart::register(@args);
    
      $module->mock('check_credentials', sub { $auth_called += 1; return 1; });
      Together::Apart::check_credentials(@args);
    
      my $test_data = {'string'=>$desired_together};
      my $good_signature = sha1($desired_together);
    
      my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
      $url->query({signature => $good_signature});
      $t->post_ok($url=>json=>$test_data)->status_is(200);
    
      $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
      $url->query({signature => $good_signature});
      $t->post_ok($url=>json=>{'bad_string'=>'bad'})->status_is(422);
    
      $good_signature = sha1($desired_apart);
      $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
      $url->query({signature => $good_signature});
      $t->post_ok($url=>json=>$desired_apart)->status_is(200);
    
      $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
      $url->query({signature => $good_signature});
      $t->post_ok($url=>json=> {'odd'=>undef, 'even'=>undef})->status_is(422);
    
      $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResponse');
      $t->get_ok($url);
      is($auth_called, 6, 'Basic auth check on each endpoint called the mock auth webservice');
    };
    
    done_testing();
    1;

# System Integration<a id="orgheadline37"></a>

## SSL<a id="orgheadline32"></a>

### Lets Encrypt - certbot<a id="orgheadline31"></a>

    $ sudo apt-get update
    $ sudo apt-get install software-properties-common
    $ sudo add-apt-repository ppa:certbot/certbot
    $ sudo apt-get update
    $ sudo apt-get install python-certbot-apache

## Systemd<a id="orgheadline36"></a>

### hypnotoad<a id="orgheadline33"></a>

    [Unit]
    Description=together-apart application
    Requires=network.target
    After=network.target
    
    [Service]
    Type=forking
    PIDFile=/home/ubuntu/together-apart/script/hypnotoad.pid
    ExecStart=/usr/bin/hypnotoad /home/ubuntu/together-apart/script/together_apart -f
    ExecStop=/usr/bin/hypnotoad -s  /home/ubuntu/together-apart/script/together_apart
    ExecReload=/usr/bin/hypnotoad /home/ubuntu/together-apart/script/together_apart
    KillMode=process
    
    [Install]
    WantedBy=multi-user.target

### Reload systemctl daemon<a id="orgheadline34"></a>

    sudo systemctl --system daemon-reload

### rsyslog<a id="orgheadline35"></a>

    if $programname == '* Packages

    sudo apt-get install libmojolicious-perl  libdigest-sha-perl liblist-moreutils-perl libtry-tiny-perl

    name    = Together-Apart
             version = 0.01
             author  = matthewburns@gmail
             license = MIT
             copyright_holder = Matt Burns
    
    [@Basic]
    
    [Prereqs]
    
    Mojolicious     = 7.77
    Digest::SHA      = 6.02
    List::MoreUtils  = 0.428
    
    [Control::Debian]

# Appendix A: TODO<a id="orgheadline44"></a>

org-mode to document and automate microservice development,  operational and maintainence tasks.
API provides access to the app code block creating devop playbooks.

Application update endpoint targeted by github repo webhooks triggered merge into master,
creates continous delivery feedback loop used deploying new version, handing off
the request handling of the service to the new version.

Debian packages and socket reuse make upgrade to new version while system is running in production.
push system based on ssh and public/private key access.

## Goals<a id="orgheadline42"></a>

### manage technical debt (versioning, release, deploy, documentation, test)<a id="orgheadline38"></a>

### automatically maintain and update<a id="orgheadline39"></a>

### make it easy to run/work on the software<a id="orgheadline40"></a>

### checklists to help foster better development security practices<a id="orgheadline41"></a>

## Design Tasks <code>[20/20]</code><a id="orgheadline43"></a>

-   [X] Publishes code into source files
-   [X] Releases the code into the upstream code repository
-   [X] Deploys the code onto the desired runtime platorm (dev, qa, stg, prd)
-   [X] Provisions the runtime infrastructure and like artifacts the application is dependent upon.
-   [X] Capture the functional requirements in automated testable form
-   [X] Understand engineering decisions behind the implementation, design, methodology testing
-   [X] Define the way features are deployed into new versions of this WebService
-   [X] Run tests
-   [X] Provides application documentation
-   [X] Provide development history
-   [X] Provides a reduamentry cli interface to devops/maintence tasks
-   [X] Sets up and runs system from src control repo (github)
-   [X] Provide  way to refer and collaborate among developers
-   [X] Continous Delivery
-   [X] Worksheet to aid in project management aspects of software development
-   [X] Bridge that first draft proof of concept devops task into part of the crm/orchestration process
-   [X] Allows the stitching together of many pre- [-]existing tools (git, dpkg,
-   [X] Incorporate others work via pull requests.
-   [X] Define Idioms
-   [X] Capture domain specific paculiarities

# Appendix B: System 3rd Party Dependencies/Requirements<a id="orgheadline45"></a>

-   Local: Running in the context of a ordinary linux system account
-   API web application
-   Common library components
-   Github hooks to deploy

# Appendix C: REPL /Debugger<a id="orgheadline47"></a>

    perl -d -I../lib  Together-Apart/lib/Together/Apart.pm daemon

## Testing G7 - Setting up non sticky environment<a id="orgheadline46"></a>

    # Listen on two ports with HTTP and HTTPS at the same time
    $daemon->listen(['http://*:3000', 'https://*:4000']);
    # Listen on release-next port
    # 4461 release-next -> new version
    # 4460 master -> existing prd version
    my $port = $daemon->listen(['http://127.0.0.1'])->start->ports->[0];
    # Run multiple web servers concurrently
    my $daemon1 = Mojo::Server::Daemon->new(listen => ['http://*:3000'])->start;
    my $daemon2 = Mojo::Server::Daemon->new(listen => ['http://*:4000'])->start;
    Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
