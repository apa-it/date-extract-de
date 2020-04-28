#!/usr/bin/env perl

use Test::More;

use warnings;
use strict;
use utf8;

use_ok 'Date::Extract::DE';

my @examples = (
    {   text =>
            'Einmal gab es bereits einen Pop-up-Store in der Bezirkshauptstadt: Barbara Rapolter, die fünf Jahre ihre Boutique „spiriti‘m“ in der Innenstadt betrieb, bot für kurze Zeit Ende Mai 2019 Mode in der ehemaligen Styx-Filiale am Rathausplatz an. VP-Stadträtin Ute Reisinger und Zunftzeichen-Obfrau Ilse Kossarz wollen das Modell um die temporären Geschäfte, die vorübergehend in Leerstände ziehen, weiter forcieren. Am Montag, 20. Jänner, findet um 19 Uhr im Wachauerhof eine Info-Veranstaltung statt. Max Homolka, Geschäftsführer des Stadtmarketing Enns, erzählt dabei von seinen Erfahrungen.',
        dts => [qw/2020-01-20/]
    },
    {   text =>
            'GEMEINLEBARN Die „Kreative Runde“ in Gemeinlebarn lädt am Mittwoch, 15. Jänner, ab 15 Uhr zu einer „Mittendrin“-Veranstaltung in das Feuerwehrhaus Gemeinlebarn recht herzlich ein.

    TRAISMAUER Am Samstag, 18. Jänner, findet ab 10 Uhr in der Städtischen Turnhalle Traismauer ein Dart- Turnier in mehreren Kategorien statt. Organisiert wird das Turnier vom SC Traismauer. Um Anmeldung wird gebeten.

    WAGRAM Die Landjugend lädt am Samstag, 18. Jänner, ab 19.30 Uhr in den Landgasthof Huber in Wagram zum Ball.

    GEMEINLEBARN Am Donnerstag, 23. Jänner, findet ab 19.30 Uhr im Gasthof Windhör in Gemeinlebarn ein Wirtshaussingen der Lewinger Gigerl statt.

    TRAISMAUER Der Musikverein Traismauer lädt am Sonntag, 26. Jänner, ab 16 Uhr in die Städtische Turnhalle zum Jugend-Faschingskonzert.
',
        dts => [qw/2020-01-15 2020-01-18 2020-01-18 2020-01-23 2020-01-26/]
    },
    {   text =>
            'Ein besonders wichtiges Thema in der Gemeinde ist derzeit natürlich der Ausbau des Glasfasernetzes, der im Frühjahr starten soll. „Wer noch die günstigen Konditionen nutzen will – der Anschluss kostet pro Haushalt 300 Euro – der hat noch bis 17.Februar dazu Zeit“, berichtete die Ortschefin.',
        dts => [qw/2020-02-17/]
    },
    {   text => 'Die (un)heimlichen Miterzieher“. Anschließend
    Diskussion. Eintritt 5 Euro. Eine Veranstaltung des Katholischen
    Bildungswerks. Infos bei Charlotte Ennser',
        dts => []
    }
);

my $ref_dt = DateTime->new(
    year       => 2020,
    month      => 01,
    day        => 14,
    hour       => 0,
    minute     => 0,
    second     => 0,
    nanosecond => 0,
    time_zone  => 'Europe/Vienna',
);

my $parser = Date::Extract::DE->new( reference_dt => $ref_dt );
foreach (@examples) {
    my $dates = $parser->extract( $_->{text} );
    my $expected = [ map { $_->as_iso } @$dates ];
    is_deeply( $dates, $expected, 'All expteced dates found' );
}
done_testing;
