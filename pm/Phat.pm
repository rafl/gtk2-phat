package Gtk2::Phat;

use strict;
use Gtk2;
require DynaLoader;
our @ISA = qw(DynaLoader);
our $VERSION = 0.02;

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

Copyright (C) 2005, 2006 by Florian Ragwitz

This library is free software; you can redistribute it and/or modify it under
the terms of the GNU Library General Public License as published by the Free
Software Foundation; either version 2 of the License, or (at your option) any
later version.

This library is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Library General Public License for more
details.

You should have received a copy of the GNU Library General Public License along
with this library; if not, write to the Free Software Foundation, Inc., 59
Temple Place - Suite 330, Boston, MA  02111-1307  USA.

=cut

1;
