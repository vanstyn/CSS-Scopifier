package CSS::Scopifier;
use strict;
use warnings;

# ABSTRACT: Prepends CSS rules to apply scope
our $VERSION = 0.01;

use CSS::Tiny 1.19;

use Moo;
extends 'CSS::Tiny';

sub scopify {
  my ($self, $selector) = @_;
  
  die "scopify() requires string selector argument" 
    unless ($selector && ! ref($selector));
  
	$self->{"$selector $_"} = delete $self->{$_} for (keys %$self);
}


1;

__END__

=pod

=head1 DESCRIPTION

Extends L<CSS::Tiny> adding the C<scopify> method.

=cut

