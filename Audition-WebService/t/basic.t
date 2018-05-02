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
my $desired_apart = { 'even' => ['p', 'i', ' ', 'e'], 'odd'  => ['s', 'l', 't', 'm']};

# Test the biz domain functionality.
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
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
    $t->post_ok($url=>json=>$test_data)->status_is(200);
    $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/lastResult');
    $t->post_ok($url=>json=>$test_data)->status_is(200);
};

# Test invalid authentication.
my $url = $t->ua->server->url->userinfo('bad:terrible')->path('/split');
$t->post_ok($url => json => $test_data)->status_is(401);
$url = $t->ua->server->url->userinfo('bad:terrible')->path('/join');
$t->post_ok($url => json  => $desired_apart)->status_is(401);

# Test with valid signature and credentials
my $good_signature = sha1(encode_json($desired_apart));
$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
$url->query({signature => $good_signature});
$t->post_ok($url => json => $desired_apart)->status_is(200);

# Test for missing signature
my $url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
$t->post_ok($url => json => $test_data)->status_is(403);
$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
$t->post_ok($url => json => $test_data)->status_is(403);

# Test for tampered signature
my $bad_signature = sha1($desired_together . "corruption");
$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
$url->query({signature => $bad_signature});
$t->post_ok($url => json => $test_data)->status_is(403);

$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
$url->query({signature => $bad_signature});
$t->post_ok($url => json => $desired_apart)->status_is(403);


# Test with valid signature
my $good_signature = sha1($desired_together);
$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/split');
$url->query({signature => $good_signature});
$t->post_ok($url => json)->status_is(200);

$url = $t->ua->server->url->userinfo('TBD:TBD')->path('/join');
$url->query({signature => $good_signature});
$t->post_ok($url => json)->status_is(200);

done_testing($number_of_tests);
__END__
