# -*- perl -*-

use strict;
use warnings;
use Test::More;

use_ok('CSS::Scopifier');

ok( 
  my $CSS = CSS::Scopifier->read('t/var/example.css'),
  'New CSS::Scopifier object'
);

is($CSS->write_string,
q~h2 {
	font-family: Georgia, "DejaVu Serif", serif;
	font-size: 1.4em;
	letter-spacing: .1em;
}
h1 {
	font-family: Georgia, "DejaVu Serif", serif;
	font-size: 1.5em;
	letter-spacing: .1em;
}
body {
	font-family: "Palatino Linotype", Freeserif, serif;
	letter-spacing: .05em;
}
~,
'Expected pre-scopify CSS');

ok(
  $CSS->scopify('div.foo'),
  'Call scopify()'
);

is($CSS->write_string,
q~div.foo h2 {
	font-family: Georgia, "DejaVu Serif", serif;
	font-size: 1.4em;
	letter-spacing: .1em;
}
div.foo h1 {
	font-family: Georgia, "DejaVu Serif", serif;
	font-size: 1.5em;
	letter-spacing: .1em;
}
div.foo body {
	font-family: "Palatino Linotype", Freeserif, serif;
	letter-spacing: .05em;
}
~,
'Expected post-scopify CSS');

done_testing;