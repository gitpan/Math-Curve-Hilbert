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
  $VERSION = '0.01';
}

sub up {
  warn "up\n";
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{right(X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  } else {
    if ($args{max} == $this_level) {
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  }
  return $coords;
}

sub left {
  warn "left \n";
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  } else {
    if ($args{max} == $this_level) {
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  }
  return $coords;
}

sub right {
  warn "right\n";
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{up(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  } else {
    if ($args{max} == $this_level) {
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{up(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  }
  return $coords;
}

sub down {
  warn "down\n";
  my %args = @_;
  my $coords = [];
  my $this_level = $args{level} + 1;
  my ($x,$y) = ($args{X}, $args{Y});
  if ($args{clockwise}) {
    if ($args{max} == $this_level) {
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{left(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{right(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
    }
  } else {
    if ($args{max} == $this_level) {
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
    } else {
      push(@$coords,@{right(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$x++; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{down(clockwise=>0,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
      $$y--; push (@$coords,{X=>$$x,Y=>$$y});
      push(@$coords,@{left(clockwise=>1,X=>$x,Y=>$y,level=>$this_level,max=>$args{max})});
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

  use Math::Curve::Hilbert qw(up down left right);

  # get array of coordinates for 4x4 square
  my $coords = up ( max=>2, level=>0, x=>0, y=>4, clockwise=>1 );

  # print coordinates of the 4th cell on the curve
  print "$coords->[4]{X}, $coords->[4]{Y}\n";


=head1 DESCRIPTION

The Hilbert Curve module provides some useful functions using Hilberts Space-filling Curve. This is handy for things like Dithering, Flattening n-dimensional data, fractals - all kind of things really.

=head2 EXPORT

None by default.

=head1 AUTHOR

A. J. Trevena, E<lt>teejay@droogs.orgE<gt>

=head1 SEE ALSO

L<perl>.

=cut
