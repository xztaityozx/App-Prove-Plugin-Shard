use Test2::V0;
use Test2::Tools::Spec;
use Test2::Bundle::Extended;

use strictures 2;

use App::Prove::Plugin::Shard;
use Class::Method::Modifiers qw/around/;

describe "about App::Prove::Plugin::Shard::load argument validation" => sub {
  describe '正常系' => sub {
    my $tests = [
      +{ shard_number => 1, total_shards => 2 },
      +{ shard_number => 2, total_shards => 2 },
    ];

    for my $tt (@$tests) {
      my $shard_number = $tt->{shard_number};
      my $total_shards = $tt->{total_shards};
      describe sprintf( "when shard_number=%d, total_shards=%d", $shard_number, $total_shards ) => sub {
        it "to be ok" => sub {
          around "App::Prove::Plugin::Shard::_build_get_tests" => sub {
            shift;
            my ($a, $b) = @_;
            is $a, $shard_number;
            is $b, $total_shards;
          };
          ok App::Prove::Plugin::Shard::load( +{}, +{ args => [ $shard_number, $total_shards ] } );
        }
      }
    }
  };

  describe '異常系' => sub {
    my $tests = [
      +{ shard_number => 0, total_shards => 1 },
      +{ shard_number => 0, total_shards => 0 },
      +{ shard_number => 3, total_shards => 2 },
    ];

    for my $tt (@$tests) {
      my $shard_number = $tt->{shard_number};
      my $total_shards = $tt->{total_shards};
      describe sprintf( "when shard_number=%d, total_shards=%d", $shard_number, $total_shards ) => sub {
        it "to be croak" => sub {
          my $e = dies sub { App::Prove::Plugin::Shard::load( +{}, +{ args => [ $shard_number, $total_shards ] } )};
          ok $e;
        }
      }
    }
  }
};

done_testing;
