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
