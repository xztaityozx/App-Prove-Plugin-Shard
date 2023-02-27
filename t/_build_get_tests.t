use Test2::V0;
use strictures 2;

use Test2::Bundle::Extended;
use Test2::Tools::Spec;
use App::Prove::Plugin::Shard;

describe 'about App::Prove::Plugin::Shard::get_tests' => sub {
  my $t_files = [
    "1.t",  "2.t",  "3.t",  "4.t",  "5.t",  "6.t",  "7.t",  "8.t",  "9.t",  "10.t",
    "11.t", "12.t", "13.t", "14.t", "15.t", "16.t", "17.t", "18.t", "19.t", "20.t",
  ];
  my $tests = [
    +{
      shard_number => 1,
      total_shards => 2,
      expected     => [ "1.t", "3.t", "5.t", "7.t", "9.t", "11.t", "13.t", "15.t", "17.t", "19.t", ]
     },
    +{
      shard_number => 2,
      total_shards => 2,
      expected     => [ "2.t", "4.t", "6.t", "8.t", "10.t", "12.t", "14.t", "16.t", "18.t", "20.t", ]
     },
    +{
      shard_number => 1,
      total_shards => 3,
      expected     => [ "1.t", "4.t", "7.t", "10.t", "13.t", "16.t", "19.t" ]
     },
  ];

  for my $tt (@$tests) {
    my $shard_number = $tt->{shard_number};
    my $total_shards = $tt->{total_shards};
    describe sprintf( "when shard_number=%d, total_shards=%d", $shard_number, $total_shards ) => sub {
      before_all 'setup' => sub {
      };

      it "to be expected" => sub {
        ## no critic (ProtectPrivateSubs)
        my $sub = App::Prove::Plugin::Shard::_build_get_tests( $shard_number, $total_shards );
        my @actual = $sub->( sub { @$t_files } );
        is @{ $tt->{expected} }, @actual;
      };
    }
  }
};

done_testing;
