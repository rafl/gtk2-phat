#!/usr/bin/perl

use 5.008;
use strict;
use warnings;
use ExtUtils::MakeMaker;
use Cwd;
use File::Spec;

our %build_reqs = (
		'perl-ExtUtils-Depends'		=> 0.1,
		'perl-ExtUtils-PkgConfig'	=> 0.1,
		'perl-Glib'					=> 1.0,
		'perl-Gtk2'					=> 1.0
);

unless (eval "use ExtUtils::Depends;"
			."use ExtUtils::PkgConfig;"
			."use Glib::MakeHelper;"
			."use Gtk2::CodeGen;"
			."use Glib '$build_reqs{'perl-Glib'}';"
			."use Gtk2 '$build_reqs{'perl-Gtk2'}';"
			."1") {
	warn "$@";
	WriteMakefile(
			PREREQ_FATAL	=> 1,
			PREREQ_PM		=> {
				'Glib'					=> $build_reqs{'perl-Glib'},
				'Gtk2'					=> $build_reqs{'perl-Gtk2'},
				'ExtUtils::Depends'		=> $build_reqs{'perl-ExtUtils-Depends'},
				'ExtUtils::PkgConfig'	=> $build_reqs{'perl-ExtUtils-PkgConfig'}
			}
	);
	exit 1;
}

mkdir 'build', 0777;

my %pkgconfig = ExtUtils::PkgConfig->find('phat', 'libgnomecanvas-2.0');

Gtk2::CodeGen->parse_maps('phat');
Gtk2::CodeGen->write_boot(ignore => qr/^Gtk2::Phat$/);

our @xs_files = <xs/*.xs>;

our $phat = ExtUtils::Depends->new('Gtk2::Phat', 'Gtk2');
$phat->set_inc($pkgconfig{cflags});
$phat->set_libs($pkgconfig{libs});
$phat->add_xs(@xs_files);
$phat->add_pm('pm/Phat.pm', '$(INST_LIBDIR)/Phat.pm');
my $cwd = cwd();
$phat->add_typemaps(map { File::Spec->catfile($cwd, $_) } File::Spec->catfile('build', 'phat.typemap'));

$phat->install(File::Spec->catfile('build', 'phat-autogen.h'));
$phat->save_config(File::Spec->catfile('build', 'IFiles.pm'));

WriteMakefile(
	NAME			=> 'Gtk2::Phat',
	VERSION_FROM	=> File::Spec->catfile('pm', 'Phat.pm'),
	XSPROTOARG		=> '-noprototypes',
	MAN3PODS		=> {
		'pm/Phat.pm'	=> '$(INST_MAN3DIR)/Gtk2::Phat.$(MAN3EXT)',
		Glib::MakeHelper->do_pod_files(@xs_files)
	},
	$phat->get_makefile_vars(),
	PREREQ_PM		=> {
		Gtk2	=> $build_reqs{'perl-Gtk2'}
	}
);

package MY;
use Cwd;

sub postamble {
	return Glib::MakeHelper->postamble_clean()
		. Glib::MakeHelper->postamble_docs_full(
				DEPENDS	=> $main::phat,
				XS_FILES => \@main::xs_files,
				COPYRIGHT => 'Copyright (C) 2005, 2006 by Florian Ragwitz'
		)
		. Glib::MakeHelper->postamble_rpms(
				PERL_EXTUTILS_DEPENDS	=> $build_reqs{'perl-ExtUtils-Depends'},
				PERL_EXTUTILS_PKGCONFIG	=> $build_reqs{'perl-ExtUtils-PkgConfig'},
				PERL_GLIB				=> $build_reqs{'perl-Glib'},
				PERL_GTK				=> $build_reqs{'perl-Gtk2'}
		);
}

package MAIN;
