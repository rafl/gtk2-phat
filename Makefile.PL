#!/usr/bin/env perl

use strict;
use warnings;
use lib 'ext';
use inc::Module::Install;

name 'Gtk2-Phat';
all_from 'lib/Gtk2/Phat.pm';

phat;

requires Gtk2 => 0;

WriteAll;
