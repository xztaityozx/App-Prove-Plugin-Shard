package App::Prove::Plugin::Shard;

use strictures 2;
use feature qw/say/;

use Class::Method::Modifiers qw/around/;
use App::Prove;
use Carp qw/croak confess/;

our $VERSION = "0.0.1";

use Types::Standard qw(Int ArrayRef);
use Type::Params    qw(signature);
use Feature::Compat::Try;

use Term::ANSIColor qw/:constants/;

sub load {
  my ( undef, $p ) = @_;

  my $ValidInt = Int->where('$_ >= 1');
  my $check = signature( positional => [ $ValidInt, $ValidInt ] );
  my ( $shard_number, $total_shards );
  try {
    ( $shard_number, $total_shards ) = $check->( @{ $p->{args} } )
  }
  catch ($e) {
    croak sprintf( "%sfailed to validate arguments\n%sinner exception:\n%s%s", RED, YELLOW, $e, RESET );
  }

  if ( $shard_number > $total_shards ) {
    croak
      sprintf(
      "%sshard_index must be less than or equal to total_shards. but got: shard_number=%d, total_shards=%d%s\n",
      RED, $shard_number, $total_shards, RESET );
  }

  around 'App::Prove::_get_tests' => _build_get_tests($shard_number, $total_shards);

  return 1;
}

sub _build_get_tests {
  my ($shard_number, $total_shards) = @_;
  return sub {
    my $orig = shift;

    my @test_files = sort $orig->(@_);
    return map { $test_files[$_] } grep { ( $_ % $total_shards ) + 1 == $shard_number } 0 .. $#test_files;
  }
}

sub import { }

1;

__END__;

=head1 NAME

App::Prove::Plugin::Shard - Split tests in multiple subsets (like Jest)

=head1 SYNOPSIS

  # Run tests using shard 1 of 3

  prove -PShard=1,3 ./t

=head1 DESCRIPTION

This plugin allows you to shard your test suite into multiple subsets. It is similar to the `--shard` option in Jest.

=head1 OPTIONS

=over 4

=item B<-P Shard=shard_number,total_shards>

Specifies the shard number and total number of shards. The shard number indicates the index of the shard to be executed and must be a positive integer. The total number of shards indicates the number of shards into which the tests are divided and must also be a positive integer. Shard number must be less than or equal to total shards.

=back

=head1 AUTHOR

xztaityozx <taityonohibi@gmail.com>

=head1 COPYRIGHT AND LICENCE

MIT

=cut
