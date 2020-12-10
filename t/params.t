use warnings;
use strict;

use Test2::V0;
use Devel::Confess;

use Amazon::MWS::Routines qw(process_params);
use DateTime;

subtest 'basic types' => sub {
  my $params = {
    DateTime      => { type => 'datetime' },
    MoreThanOne   => { type => 'nonNegativeInteger' },
    ABoolFlag     => { type => 'boolean' },
    String        => { type => 'string' }
  };

  my $args;
  $args = { MoreThanOne => -5 };
  is { process_params($params, $args) }, {
    MoreThanOne => 1
  }, 'changed non-negative integer to 1';

  $args = { ABoolFlag => 9001 };
  is { process_params($params, $args) }, {
    ABoolFlag => 'true'
  }, 'changed truthy to true';

  $args = { ABoolFlag => 0 };
  is { process_params($params, $args) }, {
    ABoolFlag => 'false'
  }, 'changed falsy to false';

  my $time = DateTime->new(year => 2020, month => 1, day => 1);

  $args = { DateTime => $time };
  is { process_params($params, $args) }, {
    DateTime => '2020-01-01T00:00:00'
  }, 'properly formats a timestamp';

};

subtest 'List types' => sub {
  my $params = { MarketplaceId => { type => 'IdList' } };
  my $first = { MarketplaceId => [ qw( a b c d ) ] };
  is { process_params($params, $first) }, {
    'MarketplaceId.Id.1' => 'a',
    'MarketplaceId.Id.2' => 'b',
    'MarketplaceId.Id.3' => 'c',
    'MarketplaceId.Id.4' => 'd',
  }, 'did List type';
};


subtest 'Enum types' => sub {
  my $params = {
    Color => {
      type => 'List',
      values => [ qw(red orange yellow) ]
    }
  };
  my $first = { Color => 'yellow' };
  is { process_params $params, $first }, {
    Color => 'yellow'
  }, 'did enum type';
};

subtest 'required alternatives' => sub {
  my $params = {
    Id => { type => 'string', required => 'id' },
    since => { type => 'datetime', required => 'date' },
    until => { type => 'datetime', required => 'date' }
  };

  is { process_params($params, { Id => 'sneel' }) },
  { Id => 'sneel' }, 'process the id group';

  my $since = { since => '2020-01-01' };
  ok dies { process_params($params, $since) },
    'requires both args from second group';

  $since->{until} = '2020-02-01';
  is { process_params($params, $since) }, {
    since => '2020-01-01T00:00:00',
    until => '2020-02-01T00:00:00',
  }, 'allows second required group';

};







done_testing;
