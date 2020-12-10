use 5.006;
use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::Compile 2.058

use Test::More;

plan tests => 33;

my @module_files = (
    'Amazon/MWS.pm',
    'Amazon/MWS/AmazonPay.pm',
    'Amazon/MWS/Client.pm',
    'Amazon/MWS/Enumeration.pm',
    'Amazon/MWS/Enumeration/FeedProcessingStatus.pm',
    'Amazon/MWS/Enumeration/FeedType.pm',
    'Amazon/MWS/Enumeration/ReportProcessingStatus.pm',
    'Amazon/MWS/Enumeration/ReportType.pm',
    'Amazon/MWS/Enumeration/Schedule.pm',
    'Amazon/MWS/Exception.pm',
    'Amazon/MWS/Feeds.pm',
    'Amazon/MWS/Finances.pm',
    'Amazon/MWS/FulfillmentInventory.pm',
    'Amazon/MWS/FulfillmentOutbound.pm',
    'Amazon/MWS/InboundShipment.pm',
    'Amazon/MWS/Orders.pm',
    'Amazon/MWS/Products.pm',
    'Amazon/MWS/Reports.pm',
    'Amazon/MWS/Routines.pm',
    'Amazon/MWS/Sellers.pm',
    'Amazon/MWS/TypeMap.pm',
    'Amazon/MWS/Uploader.pm',
    'Amazon/MWS/XML/Address.pm',
    'Amazon/MWS/XML/Feed.pm',
    'Amazon/MWS/XML/GenericFeed.pm',
    'Amazon/MWS/XML/Order.pm',
    'Amazon/MWS/XML/OrderlineItem.pm',
    'Amazon/MWS/XML/Product.pm',
    'Amazon/MWS/XML/Response/FeedSubmissionResult.pm',
    'Amazon/MWS/XML/Response/OrderReport.pm',
    'Amazon/MWS/XML/Response/OrderReport/Item.pm',
    'Amazon/MWS/XML/ShippedOrder.pm'
);



# no fake home requested

my @switches = (
    -d 'blib' ? '-Mblib' : '-Ilib',
);

use File::Spec;
use IPC::Open3;
use IO::Handle;

open my $stdin, '<', File::Spec->devnull or die "can't open devnull: $!";

my @warnings;
for my $lib (@module_files)
{
    # see L<perlfaq8/How can I capture STDERR from an external command?>
    my $stderr = IO::Handle->new;

    diag('Running: ', join(', ', map { my $str = $_; $str =~ s/'/\\'/g; q{'} . $str . q{'} }
            $^X, @switches, '-e', "require q[$lib]"))
        if $ENV{PERL_COMPILE_TEST_DEBUG};

    my $pid = open3($stdin, '>&STDERR', $stderr, $^X, @switches, '-e', "require q[$lib]");
    binmode $stderr, ':crlf' if $^O eq 'MSWin32';
    my @_warnings = <$stderr>;
    waitpid($pid, 0);
    is($?, 0, "$lib loaded ok");

    shift @_warnings if @_warnings and $_warnings[0] =~ /^Using .*\bblib/
        and not eval { +require blib; blib->VERSION('1.01') };

    if (@_warnings)
    {
        warn @_warnings;
        push @warnings, @_warnings;
    }
}



is(scalar(@warnings), 0, 'no warnings found')
    or diag 'got warnings: ', ( Test::More->can('explain') ? Test::More::explain(\@warnings) : join("\n", '', @warnings) );


