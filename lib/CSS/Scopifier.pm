package CSS::Scopifier;
use strict;
use warnings;

# ABSTRACT: Prepends CSS rules to apply scope
our $VERSION = 0.01;

use CSS::Tiny 1.19;

use Moo;
extends 'CSS::Tiny';

sub scopify {
  my ($self, $selector, @arg) = @_;
  my %opt = ref($arg[0]) ? %{$arg[0]} : @arg;
  
  die "scopify() requires string selector argument" 
    unless ($selector && ! ref($selector));
  
  # Merge specified selectors into the root/scoped selector. Useful
  # with  merge => ['html','body'] if scopifying a base css file
  my $root_sel;
  if($opt{merge}) {
    my @list = ref $opt{merge} ? @{$opt{merge}} : ($opt{merge});
    $root_sel = {};
    %$root_sel = ( %$root_sel, %$_ ) for (
      map { delete $self->{$_} } 
      grep { exists $self->{$_} }
      @list
    );
  }

	$self->{"$selector $_"} = delete $self->{$_} for (keys %$self);
  $self->{$selector} = $root_sel if ($root_sel);
  
  return 1;
}


1;

__END__

=pod

=head1 DESCRIPTION

Extends L<CSS::Tiny> adding the C<scopify> method.

=cut

