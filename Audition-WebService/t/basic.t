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
