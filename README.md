<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#orgheadline1">1. Description</a></li>
<li><a href="#orgheadline4">2. Application specification</a>
<ul>
<li><a href="#orgheadline2">2.1. General Requirements</a></li>
<li><a href="#orgheadline3">2.2. API Endpoint Function Requirements</a></li>
</ul>
</li>
<li><a href="#orgheadline5">3. Acceptance Criteria</a></li>
<li><a href="#orgheadline14">4. Application  Logic</a>
<ul>
<li><a href="#orgheadline8">4.1. Basic Authentication using webservice</a>
<ul>
<li><a href="#orgheadline6">4.1.1. Code</a></li>
<li><a href="#orgheadline7">4.1.2. Test</a></li>
</ul>
</li>
<li><a href="#orgheadline10">4.2. API Interface</a>
<ul>
<li><a href="#orgheadline9">4.2.1. Error Codes</a></li>
</ul>
</li>
<li><a href="#orgheadline11">4.3. API Tests</a></li>
<li><a href="#orgheadline12">4.4. Access Management</a></li>
<li><a href="#orgheadline13">4.5. Application Code</a></li>
</ul>
</li>
<li><a href="#orgheadline15">5. Usage</a></li>
<li><a href="#orgheadline16">6. Configuration</a></li>
<li><a href="#orgheadline20">7. System Integration</a>
<ul>
<li><a href="#orgheadline19">7.1. Systemd</a>
<ul>
<li><a href="#orgheadline17">7.1.1. daemon</a></li>
<li><a href="#orgheadline18">7.1.2. hypnotoad</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline21">8. Environment Variables</a></li>
<li><a href="#orgheadline22">9. Perl Dependencies</a></li>
<li><a href="#orgheadline23">10. Test Suite</a></li>
<li><a href="#orgheadline31">11. Provision</a>
<ul>
<li><a href="#orgheadline29">11.1. Platform Runtime Orchestration</a>
<ul>
<li><a href="#orgheadline28">11.1.1. Common Scenarios</a></li>
</ul>
</li>
<li><a href="#orgheadline30">11.2. Packages</a></li>
</ul>
</li>
<li><a href="#orgheadline33">12. Release</a>
<ul>
<li><a href="#orgheadline32">12.1. Push</a></li>
</ul>
</li>
<li><a href="#orgheadline52">13. Deployment</a>
<ul>
<li><a href="#orgheadline34">13.1. Package</a></li>
<li><a href="#orgheadline35">13.2. logging/rotation</a></li>
<li><a href="#orgheadline36">13.3. system user</a></li>
<li><a href="#orgheadline37">13.4. groups</a></li>
<li><a href="#orgheadline38">13.5. var/data</a></li>
<li><a href="#orgheadline39">13.6. auditing</a></li>
<li><a href="#orgheadline40">13.7. software defined storage</a></li>
<li><a href="#orgheadline41">13.8. monitoring</a></li>
<li><a href="#orgheadline42">13.9. Reverse Proxy Server</a></li>
<li><a href="#orgheadline44">13.10. SSL</a>
<ul>
<li><a href="#orgheadline43">13.10.1. starting secure server</a></li>
</ul>
</li>
<li><a href="#orgheadline45">13.11. built-in api devops endpoint</a></li>
<li><a href="#orgheadline46">13.12. Nginx</a></li>
<li><a href="#orgheadline47">13.13. restart</a></li>
<li><a href="#orgheadline51">13.14. Rolling Deployment</a>
<ul>
<li><a href="#orgheadline48">13.14.1. Start first version</a></li>
<li><a href="#orgheadline49">13.14.2. Start second version</a></li>
<li><a href="#orgheadline50">13.14.3. Kill the first version</a></li>
</ul>
</li>
</ul>
</li>
<li><a href="#orgheadline59">14. Appendix A: Literate DevOps Document Overview</a>
<ul>
<li><a href="#orgheadline57">14.1. Goals</a>
<ul>
<li><a href="#orgheadline53">14.1.1. eliminate common technical debt (versioning, release, deploy, documentation, test)</a></li>
<li><a href="#orgheadline54">14.1.2. automatically maintain and update</a></li>
<li><a href="#orgheadline55">14.1.3. make it easy to run/work on the software</a></li>
<li><a href="#orgheadline56">14.1.4. checklists to help foster better development security practices</a></li>
</ul>
</li>
<li><a href="#orgheadline58">14.2. Features incorporated into the document  <code>[12/20]</code></a></li>
</ul>
</li>
<li><a href="#orgheadline60">15. Appendix B: System 3rd Party Dependencies/Requirements</a></li>
<li><a href="#orgheadline62">16. Appendix C: REPL /Debugger</a>
<ul>
<li><a href="#orgheadline61">16.1. Testing G7 - Setting up non sticky environment</a></li>
</ul>
</li>
</ul>
</div>
</div>


# Description<a id="orgheadline1"></a>

This application provides a basic authenticated  REST like service dividing strings into odd and
even arrays and rejoining arrays into original strings.

# Application specification<a id="orgheadline4"></a>

[Coding Exercise Specification](file:///home/mburns/Downloads/backend_coding_exercise.pdf)

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

    prove -v -I/home/mburns/projects/bb/shiftboard/Audition-WebService/lib Audition-WebService/t/exported_test.t

    Audition-WebService/t/exported_test.t ..
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

# Application  Logic<a id="orgheadline14"></a>

    sub together {
        my ($odd, $even) = @_;
        return undef
          unless scalar @$odd > 0 && scalar @$even > 0;
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
        my ($odd, $even) =  @{$c->req->json}{qw(odd even)} || undef;
        my $join = together($odd, $even);
        return $c->render(json=>{message=>"Parameter required"})->rendered(422) unless $join;
        $c->session('returned_last'=>$join);
        return $c->render(json=>$join)->rendered(200);
    };

    post '/split'=>sub {
        my $c  = shift;
        my $split = apart($c->req->json->{string}) || undef;
        return $c->render(json=>{message=>"Parameter Invalid"})->rendered(422)
          unless $split;
        $c->session('returned_last'=>$split);
        return $c->render(json=>$split)->rendered(200);
    };

    get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};

## Basic Authentication using webservice<a id="orgheadline8"></a>

### Code<a id="orgheadline6"></a>

    under(sub { my $c = shift; # Basic Authentication for each request
                my ($username, $password) = split(':',  $c->req->url->to_abs->userinfo);
                $c->ua->get(Mojo::URL->new($ENV{"auth_url"} || app->config('auth_url'))
                            ->query({username=>$username, password=>$password})
                            => {Accept=>'application/json'})->res == 200
                            ? return 1
                            : return $c->render(json=>{message=>"Invalid"})->rendered(401)});

### Test<a id="orgheadline7"></a>

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

## API Interface<a id="orgheadline10"></a>

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
            return $c->render(json=>{message=>"Parameter required"})->rendered(422) unless $join;
            $c->session('returned_last'=>$join);
            return $c->render(json=>$join)->rendered(200);
        };
    get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};

### Error Codes<a id="orgheadline9"></a>

-   G3 Application Functionality: return 401 on unsuccessful
-   G5 Application Functionality: return 403 on invalid sha1
-   G6 Application Functionality: return 422 on missing parameters

## API Tests<a id="orgheadline11"></a>

    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
    $url->query({signature => $good_signature});
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
    $t->post_ok($url=>json=>$test_data)->status_is(200);

## Access Management<a id="orgheadline12"></a>

    under sub { # Valid API Requirement Assertions
        my $c = shift;
        my $signature = $c->param('signature') || undef;
        my $string =  $c->req->json->{string} || undef;
        return $c->render(json=>{message=>"Parameter required)"})->rendered(422) unless $string;
        return $c->render(json=>{message=>"Checksum failure"})->rendered(403) unless $signature && ($signature eq sha1($string));
    };

## Application Code<a id="orgheadline13"></a>

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
          unless scalar @$odd > 0 && scalar @$even > 0;
        return join '', zip(@$odd, @$even);
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
                return $c->render(json=>{message=>"Parameter required)"})->rendered(422) unless $string;
                return $c->render(json=>{message=>"Checksum failure"})->rendered(403) unless $signature && ($signature eq sha1($string));
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
                    return $c->render(json=>{message=>"Parameter required"})->rendered(422) unless $join;
                    $c->session('returned_last'=>$join);
                    return $c->render(json=>$join)->rendered(200);
                };
            get '/lastResponse'=>sub {$_[0]->render(json=>$_[0]->session('returned_last'))->rendered(200)};
    };
    sub run {
        app->start;
    }
    
    run() unless caller();
    1;

# Usage<a id="orgheadline15"></a>

    sub run {
        app->start;
    }
    
    run() unless caller();
    1;

# Configuration<a id="orgheadline16"></a>

    {
     auth_url => 'https://interview-api.shiftboard.com/auth',
     name => 'partition_combiner',
     register_url => 'https://interview-api.shiftboard.com/register'
    }

# System Integration<a id="orgheadline20"></a>

## Systemd<a id="orgheadline19"></a>

### daemon<a id="orgheadline17"></a>

    [Unit]
    Description=together apart application
    After=network.target
    
    [Service]
    Type=simple
    ExecStart=/home/ubuntu/together-apart/script/together-apart daemon -m production -l http://*:3000
    
    [Install]
    WantedBy=multi-user.target

    systemctl stop together-apart
    systemctl start together-apart
    systemctl status together-apart

### hypnotoad<a id="orgheadline18"></a>

    [Unit]
    Description=together-apart application
    After=network.target
    
    [Service]
    Type=forking
    PIDFile=/home/ubuntu/together-apart/script/hypnotoad.pid
    ExecStart=/usr/bin/hypnotoad /home/ubuntu/together-apart/script/together-apart
    ExecReload=/usr/bin/hypnotoad /home/ubuntu/together-apart/script/together-apart
    KillMode=process
    
    [Install]
    WantedBy=multi-user.target

# Environment Variables<a id="orgheadline21"></a>

    export partition_combiner_auth_url='https://interview-api.shiftboard.com/auth';
    export partition_combiner_register_url='https://interview-api.shiftboard.com/register';
    export MOJO_REVERSE_PROXY='http://localhost:80';

    sudo apt-get install libmojolicious-perl  libdigest-sha-perl liblist-moreutils-perl libtry-tiny-perl

# Perl Dependencies<a id="orgheadline22"></a>

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

# Test Suite<a id="orgheadline23"></a>

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
    is($got_together, $desired_together, 'Odd and even combined into a single numerical sequence');
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

# Provision<a id="orgheadline31"></a>

## Platform Runtime Orchestration<a id="orgheadline29"></a>

### Common Scenarios<a id="orgheadline28"></a>

1.  Typical Release

2.  Rollback

3.  Cherry Pick

4.  Hot Fix

## Packages<a id="orgheadline30"></a>

    sudo apt-get install libmojolicious-perl  libdigest-sha-perl liblist-moreutils-perl libtry-tiny-perl

# Release<a id="orgheadline33"></a>

## Push<a id="orgheadline32"></a>

    git push origin release-next

    git push origin release-next

# Deployment<a id="orgheadline52"></a>

## Package<a id="orgheadline34"></a>

    dpkg together-apart

## logging/rotation<a id="orgheadline35"></a>

## system user<a id="orgheadline36"></a>

## groups<a id="orgheadline37"></a>

## var/data<a id="orgheadline38"></a>

## auditing<a id="orgheadline39"></a>

## software defined storage<a id="orgheadline40"></a>

## monitoring<a id="orgheadline41"></a>

## Reverse Proxy Server<a id="orgheadline42"></a>

In front of app acting as the endpoint accessible by external clients.

-   terminating SSL connections from the outside,
-   limits the number of concurrent open sockets towards the app
-   balancing load across multiple instances,
-   supporting several applications through the same IP/port.

## SSL<a id="orgheadline44"></a>

    hypnotoad => {
       listen  => ['https://*:443?cert=/etc/server.crt&key=/etc/server.key'],
       proxy   => 1,
       workers => 10
     }

### starting secure server<a id="orgheadline43"></a>

    $ ./script/together_apart daemon -l https://[::]:443

## built-in api devops endpoint<a id="orgheadline45"></a>

Target for github app repo release hook trigger post. Existing running version of the application
sets up and restarts public facing webserver proxying with updated symbolic links for
the site-availabe and sites-enabled point to the next blue green service pair in the the versioned
deployment release chain.

## Nginx<a id="orgheadline46"></a>

    upstream together_apart {
      server 127.0.0.1:3000;
    }
    server {
      listen 80;
      server_name localhost;
      location / {
        proxy_pass http://together_apart;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
      }
    }

## restart<a id="orgheadline47"></a>

    hypnotoad ./script/together_apart

## Rolling Deployment<a id="orgheadline51"></a>

### Start first version<a id="orgheadline48"></a>

    ./script/together_apart prefork -P /tmp/first.pid -l http://*:3000?reuse=1

### Start second version<a id="orgheadline49"></a>

    ./script/together_apart prefork -P /tmp/second.pid -l http://*:3000?reuse=1

### Kill the first version<a id="orgheadline50"></a>

    kill -s TERM `cat /tmp/first.pid`

# Appendix A: Literate DevOps Document Overview<a id="orgheadline59"></a>

Applying to dev ops task, using org-mode in emacs to facilate  Knuth outlined ideas of literate programming
capture and automate the operationation tasks of of developing and maintaining a microservice.

This means using the code blocks feature of of org mode to weave together, often as a first draft,
the tasks of setting up these types of programs.  Then having a nice way to make it pretty.

The tangle untangle feature are helpful for publishing out code especially during the start of a project
as its easy to make drastic namespace refactor org things; however, as the project matures less of the the
devops usefulness comes from anything relating to the autocode publishing which usually ceases pretty quick.

Restful projects are nice because it creates a nice method to access the application directly from the the
document providing a redumentary but powerful user interface.

Providing a couple of simple devop endpoints into the application and continous delivery loop comes
about as the feedback resulting from connecting the github repo webhooks triggered by a merge request into master
to a deployment of the new version and subsequent hand off of the service to the new version.

Adding a couple of flourishes using packages and socket reuse make the software development process easier and without
the need of heavy environments once the system is running in production.

## Goals<a id="orgheadline57"></a>

### eliminate common technical debt (versioning, release, deploy, documentation, test)<a id="orgheadline53"></a>

### automatically maintain and update<a id="orgheadline54"></a>

### make it easy to run/work on the software<a id="orgheadline55"></a>

Dev projects like any other open source github project fork
package correctly for debian and incorporate into systemd management

### checklists to help foster better development security practices<a id="orgheadline56"></a>

Harvest low hanging fruit that yeilds nice to have features while in development

-   forensic system analysis via instant replay using atop archive fils + auditd + log files + application virtualized containerization
-   providing a swagger api that allows dev ops tasks to be easily scripted via your favorite language as a client
    creates a feedback path which makes what you can do directly from the devops docs directly or run as a script by
    running emacs as a dynamic language from called from a shell script.  This active documentation is a playbook - an automated one.
-   Use a push system based on ssh and public/private key access.

## Features incorporated into the document  <code>[12/20]</code><a id="orgheadline58"></a>

-   [X] Publishes code into source files
-   [-] Releases the code into the upstream code repository
-   [-] Deploys the code onto the desired runtime platorm (dev, qa, stg, prd)
-   [X] Provisions the runtime infrastructure and like artifacts the application is dependent upon.
-   [X] Capture the functional requirements in automated testable form
-   [-] Understand engineering decisions behind the implementation, design, methodology testing
-   [X] Define the way features are deployed into new versions of this WebService
-   [X] Run tests
-   [X] Provides application documentation
-   [-] Provide development history
-   [X] Provides a reduamentry cli interface to devops/maintence tasks
-   [X] Sets up and runs system from src control repo (github)
-   [X] Provide  way to refer and collaborate among developers
-   [-] Continous Delivery with rollback
-   [X] Worksheet to aid in project management aspects of software development
-   [X] Bridge that first draft proof of concept devops task into part of the crm/orchestration process
-   [X] Allows the stitching together of many pre- [-]existing tools (git, dpkg,
-   [-] Incorporate others work via pull requests in a timely fashion
-   [-] Define Idioms
-   [-] Capture domain specific paculiarities

# Appendix B: System 3rd Party Dependencies/Requirements<a id="orgheadline60"></a>

-   Local: Running in the context of a ordinary linux system account
-   A single VPC, with the usual 3 security group setup - internal, web, and bastion.
-   [Terraform](https://www.terraform.io) and for provisioning infrastructure.
-   [Packer](https://www.packer.io) to build a single general-purpose base AMI.
-   API web application
-   Common library components
-   Github hooks to deploy
-   Riemann monitoring integration.

# Appendix C: REPL /Debugger<a id="orgheadline62"></a>

    perl -d -I/home/mburns/projects/bb/shiftboard/Audition-WebService/lib  Audition-WebService/lib/Audition/WebService.pm daemon

## Testing G7 - Setting up non sticky environment<a id="orgheadline61"></a>

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
