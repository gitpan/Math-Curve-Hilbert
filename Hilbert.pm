# Hibert.pm Perl Implementation of Hilberts space filling Curve
package Math::Curve::Hilbert;

use strict;

#
# Set up the module for CPAN, etc

BEGIN {
  use Exporter ();
  use vars qw(@ISA %EXPORT_TAGS @EXPORT @EXPORT_OK $VERSION);
  @ISA = qw(Exporter);
  %EXPORT_TAGS = ( 'all' => [ qw( &up &down &left &right ) ] );
  @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
  @EXPORT = qw( &up &down &left &right );
  $VERSION = '0.03';
}

my %defaults = ( step => 1 );

sub up {
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  my $step = ($args{step} > 0) ? $args{step} :  $defaults{step};
  warn "up -- step : $step / x : $$x / y : $$y \n";
  if ($this_level == 1) {
    warn "first call! \n";
    push (@$coords,{X=>$$x,Y=>$$y});
  }
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{right(X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  } else {
    if ($args{max} == $this_level) {
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  }
  return $coords;
}

sub left {
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  my $step = ($args{step} > 0) ? $args{step}:  $defaults{step};
  warn "left -- step : $step / x : $$x / y : $$y \n";
  if ($this_level == 1) {
    warn "first call! \n";
    push (@$coords,{X=>$$x,Y=>$$y});
  }
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  } else {
    if ($args{max} == $this_level) {
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  }
  return $coords;
}

sub right {
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  my $step = ($args{step} > 0) ? $args{step}:  $defaults{step};
  warn "right -- step : $step / x : $$x / y : $$y \n";
  if ($this_level == 1) {
    warn "first call! \n";
    push (@$coords,{X=>$$x,Y=>$$y});
  }
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  } else {
    if ($args{max} == $this_level) {
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  }
  return $coords;
}

sub down {
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  my $step = ($args{step} > 0) ? $args{step}:  $defaults{step};
  warn "down -- step : $step / x : $$x / y : $$y \n";
  if ($this_level == 1) {
    warn "first call! \n";
    push (@$coords,{X=>$$x,Y=>$$y});
  }
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  } else {
    if ($args{max} == $this_level) {
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$x += $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
      $$y -= $step; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max}, step=>$step)});
    }
  }
  return $coords;
}


1;

__END__

##########################################################################

=head1 NAME

Math::Curve::Hilbert - Perl Implementation of Hilberts space filling Curve

=head1 SYNOPSIS

#!/usr/bin/perl
use Math::Curve::Hilbert qw(up);

print "8x8 with steps of 10 centered in 150x150 square \n";
#get array of coordinates for curve of 8x8 square
my ($startx,$starty) = (39,109);
my $curve = up ( max=>3, level=>0, X=>\$startx, Y=>\$starty, step=>10,clockwise=>1 );

foreach my $coords (@$curve) {
  print "x:$coords->{X} / y: $coords->{Y}\n";
}

=head1 DESCRIPTION

The Hilbert Curve module provides some useful functions using Hilberts Space-filling Curve. This is handy for things like Dithering, Flattening n-dimensional data, fractals - all kind of things really.

Currently this module only provides basic features - an array of coordinates that the curve passes through in a square, rudimentary error checking that the square sides are a power of 4 or negative coordinates are not handled.

=head1 USING

Plotting a curve is pretty easy you use the function for the direction you wish to plot in - for example if plotting from bottom left to bottom right (basic cup) you would call : my $curve = up ( max=>$max, level=>0, X=>\$startx, Y=>\$starty, clockwise=>1 );

The level should map to a power of 4 - for example an 8x8 square would have a max of 3 and a 16x16 square would have a max of 4, in the example above the max is 3 for 4x4.

You can space out coordinates by passing a value to step the points by, this means the coordinates can be used to draw fractals.

=head2 EXPORT

None by default.

up : plot upwards ( up - along - down )

down : plot down (down - along - up )

left : plot left ( left - up/down - right )

right : plot right ( right - up/down - left )

=head1 AUTHOR

A. J. Trevena, E<lt>teejay@droogs.orgE<gt>

=head1 SEE ALSO

L<perl>.

=cut
