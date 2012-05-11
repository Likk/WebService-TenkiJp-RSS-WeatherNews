package WebService::TenkiJp::RSS::WeatherNews;

=head1 NAME

WebService::TenkiJp::RSS::WeatherNews - tenki.jp Weather RSS Reader

=head1 SYNOPSIS

  use WebService::TenkiJp::RSS::WeatherNews;
  my $f = WebService::TenkiJp::RSS::WeatherNews->new(pref => 16)->forecast;

=head1 DESCRIPTION

WebService::TenkiJp::RSS::WeatherNews is tenki.jp Weather RSS Reader

=cut

use strict;
use warnings;
use utf8;
use Carp;
use XML::Feed;
use URI;

use base qw(Class::Accessor::Fast);
__PACKAGE__->mk_accessors(qw/pref/);

our $VERSION = '0.01';

sub new {
  my $class = shift;
  my %args  = @_;

  my $self = bless {%args}, $class;
  $self->{base_url} = q{http://rss.rssad.jp/rss/tenki};
  return $self;
}

sub forecast {
  my $self = shift;
  my %args = @_;
  my $pref = defined $args{pref} ? $args{pref} : $self->pref;
  Carp::confess('requested pref code') unless $pref;

  my $feed = XML::Feed->parse( URI->new("@{[$self->{base_url}]}/forecast/pref_@{[$pref]}.xml"));
  if(defined $feed){
    my @items = ();
    for my $item ( $feed->entries ) {
      push @items ,$item->{entry};
    }
    return \@items;
  }
  Carp::confess('Cant get rss data');
}

sub forecast_description {
  my $self = shift;
  my %args = @_;
  my $pref = defined $args{pref} ? $args{pref} : $self->pref;
  Carp::confess('requested pref code') unless $pref;

  my $feed = XML::Feed->parse( URI->new("@{[$self->{base_url}]}/forecast/description_@{[$pref]}.xml"));
  if(defined $feed){
    my @items = ();
    for my $item ( $feed->entries ) {
      push @items ,$item->{entry};
    }
    return \@items;
  }

}
1;

=head1 AUTHOR

likkradyus E<lt>perl {at} li {dot} que {dot} jpE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
