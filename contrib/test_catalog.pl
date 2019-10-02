#!/usr/bin/perl
#
use strict;
use warnings;

use YAML;
use Data::Dumper;
use Net::Docker::Registry::Client;

my $cfg_file = "/etc/cooverview/config.yml";
my $config = YAML::LoadFile($cfg_file);
my $client = Net::Docker::Registry::Client->new(%$config, trace=>1);

print Dumper($client->catalog());
exit 0;
