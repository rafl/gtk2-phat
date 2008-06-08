package Gtk2::Phat;

use strict;
use warnings;
use Gtk2;
require DynaLoader;
our @ISA = qw(DynaLoader);
our $VERSION = '0.03';

sub dl_load_flags { 0x01 };

bootstrap Gtk2::Phat $VERSION;

=head1 NAME

Gtk2::Phat - Perl interface to the Phat widget collection

=head1 DESCRIPTION

This module allows a perl developer to access the widgets of the Phat widget
collection which is geared toward pro-audio apps. The goal is to eliminate
duplication of effort and provide some standardization.

=head1 SEE ALSO

L<Gtk2>(3pm), L<Gtk2::Phat::index>(3pm)

=head1 AUTHOR

Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005-2008 by Florian Ragwitz

This is free software, licensed under:

  The GNU Lesser General Public License Version 2.1, February 1999

=cut

1;
