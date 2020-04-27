package Amazon::MWS::Finances ;

use Amazon::MWS::Routines qw(:all) ;

my $version        = '2015-05-01' ;
my $finance_service = "/Finances/$version/" ;

define_api_method GetServiceStatus =>
    version => $version,
    raw_body => 0,
    service => "$finance_service",
    module_name => 'Amazon::MWS::Finances',
    parameters => {},
    respond => sub {
        my $root = shift ;
        return $root->{Status} ;
   } ;

define_api_method ListFinancialEventGroups =>
    raw_body => 0,
    version => $version,
    service => "$finance_service",
    parameters => {
        MaxResultsPerPage                    => { type => 'nonNegativeInteger' },
        FinancialEventGroupStartedAfter      => { type => 'datetime', required=>1 },
        FinancialEventGroupStartedBefore     => { type => 'datetime' },
    },
    respond => sub {
        my $root = shift;
        return $root;
    } ;

define_api_method ListFinancialEventGroupsByNextToken =>
    raw_body => 0,
    version => $version,
    service => "$finance_service",
    parameters => {
        NextToken => {
            type     => 'string',
            required => 1,
        },
    },
    respond => sub {
        my $root = shift;
        return $root;
    } ;


define_api_method ListFinancialEvents =>
    raw_body => 0,
    version => $version,
    service => "$finance_service",
    parameters => {
        MaxResultsPerPage     => { type => 'nonNegativeInteger' },
        AmazonOrderId         => { type => 'string' },
        FinancialEventGroupId => { type => 'string' },
        PostedAfter           => { type => 'datetime' },
        PostedBefore          => { type => 'datetime' },
    },
    respond => sub {
        my $root = shift;
        return $root;
    } ;

define_api_method ListFinancialEventsByNextToken =>
    raw_body => 0,
    version => $version,
    service => "$finance_service",
    parameters => {
        NextToken => {
            type     => 'string',
            required => 1,
        },
    },
    respond => sub {
        my $root = shift;
        return $root;
    } ;

1 ;

