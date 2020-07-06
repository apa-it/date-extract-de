#!/usr/bin/env perl

use Test::More;

use warnings;
use strict;
use utf8;

use Date::Simple;

use_ok 'Date::Extract::DE';

my @examples = (
    {   text =>
            'Einmal gab es bereits einen Pop-up-Store in der Bezirkshauptstadt: Barbara Rapolter, die fünf Jahre ihre Boutique „spiriti‘m“ in der Innenstadt betrieb, bot für kurze Zeit Ende Mai 2019 Mode in der ehemaligen Styx-Filiale am Rathausplatz an. VP-Stadträtin Ute Reisinger und Zunftzeichen-Obfrau Ilse Kossarz wollen das Modell um die temporären Geschäfte, die vorübergehend in Leerstände ziehen, weiter forcieren. Am Montag, 20. Jänner, findet um 19 Uhr im Wachauerhof eine Info-Veranstaltung statt. Max Homolka, Geschäftsführer des Stadtmarketing Enns, erzählt dabei von seinen Erfahrungen.',
        dts => [ { date => '2020-01-20', context => '20. Jänner' } ]
    },
    {   text =>
            'GEMEINLEBARN Die „Kreative Runde“ in Gemeinlebarn lädt am Mittwoch, 15. Jänner, ab 15 Uhr zu einer „Mittendrin“-Veranstaltung in das Feuerwehrhaus Gemeinlebarn recht herzlich ein.

    TRAISMAUER Am Samstag, 18. Jänner, findet ab 10 Uhr in der Städtischen Turnhalle Traismauer ein Dart- Turnier in mehreren Kategorien statt. Organisiert wird das Turnier vom SC Traismauer. Um Anmeldung wird gebeten.

    WAGRAM Die Landjugend lädt am Samstag, 18. Jänner, ab 19.30 Uhr in den Landgasthof Huber in Wagram zum Ball.

    GEMEINLEBARN Am Donnerstag, 23. Jänner, findet ab 19.30 Uhr im Gasthof Windhör in Gemeinlebarn ein Wirtshaussingen der Lewinger Gigerl statt.

    TRAISMAUER Der Musikverein Traismauer lädt am Sonntag, 26. Jänner, ab 16 Uhr in die Städtische Turnhalle zum Jugend-Faschingskonzert.
',
        dts => [
            { date => '2020-01-15', context => '15. Jänner' },
            { date => '2020-01-18', context => '18. Jänner' },
            { date => '2020-01-18', context => '18. Jänner' },
            { date => '2020-01-23', context => '23. Jänner' },
            { date => '2020-01-26', context => '26. Jänner' },
        ]
    },
    {   text =>
            'Ein besonders wichtiges Thema in der Gemeinde ist derzeit natürlich der Ausbau des Glasfasernetzes, der im Frühjahr starten soll. „Wer noch die günstigen Konditionen nutzen will – der Anschluss kostet pro Haushalt 300 Euro – der hat noch bis 17.Februar dazu Zeit“, berichtete die Ortschefin.',
        dts => [ { date => '2020-02-17', context => '17.Februar' } ]
    },
    {   text => 'Die (un)heimlichen Miterzieher“. Anschließend
    Diskussion. Eintritt 5 Euro. Eine Veranstaltung des Katholischen
    Bildungswerks. Infos bei Charlotte Ennser',
        dts => []
    },
    {   text =>
            'Am Freitag, den 1.5. finden zahlreiche Veranstaltung heuer nur vorm Bildschirm statt.',
        dts => [ { date => '2020-05-01', context => '1.5.' } ]
    },
    {   text =>
            'Der beliebte Markt wird heuer vom 4. bis zum 6. Mai am Hauptplatz stattfinden',
        dts => [
            map { { date => $_, context => '4. bis zum 6. Mai' } }
                qw/2020-05-04 2020-05-05 2020-05-06/
        ]
    },
    {   text =>
            'Am 11. und 14. Mai finden Sondersprechstundentage des Bürgermeisters statt',
        dts => [
            map { { date => $_, context => '11. und 14. Mai' } }
                qw/2020-05-11 2020-05-14/
        ]
    },
    {   text =>
            'Zwischen 11. und 14. Mai 2021 werden verstärkt Sternschnuppen zu beobachten sein',
        dts => [
            map { { date => $_, context => 'Zwischen 11. und 14. Mai 2021' } }
                qw/2021-05-11 2021-05-12 2021-05-13 2021-05-14/
        ]
    },
    {   text =>
            'Das Angebot gilt vom 29. Mai bis zum 2. Juni zu den üblichen Bedingunen',
        dts => [
            map { { date => $_, context => '29. Mai bis zum 2. Juni' } }
                qw/2020-05-29 2020-05-30 2020-05-31 2020-06-01 2020-06-02/
        ]
    },
    {   text =>
            "Grazer Augartenfest: Das 40. Augartenfest in Graz (geplant am 27. Juni) fällt ins Wasser.",
        dts => [ { date => '2020-06-27', context => '27. Juni' } ]
    },
    {   text =>
            "Genauso ist es beim Auftritt der Saxofon-Queen Candy Dulfer, der nun am 14. November stattfindet.",
        dts => [ { date => '2020-11-14', context => '14. November' } ]
    },
    {   text =>
            "Am 16. März wurden viele Veranstaltung der kommenden Monate abgesagt",
        dts => [ { date => '2020-03-16', context => '16. März' } ]
    },
    {   text => "Vom 5.7.2021 bis 8.7.2021 findet das Festival statt",
        dts  => [
            map { { date => $_, context => '5.7.2021 bis 8.7.2021' } }
                qw/2021-07-05 2021-07-06 2021-07-07 2021-07-08/
        ]
    },
    {   text => "MATTERSBURG Nun ist es endgültig beschlossene Sache:
Der Mattersburger Musiksommer findet heuer nicht statt. Die Veranstaltungsreihe
(an drei Freitagen im August spielen stets Musikbands plus Vorgruppen auf) ist ein fixer
Bestandteil bei den Mattersburger Events und auch heuer waren die
Termine (für 7. 14. und 21. August) und die Bands fixiert.",
        dts => [
            map { { date => $_, context => '14. und 21. August' } }
                qw/2020-08-14 2020-08-21/
        ]
    },
    {   text => "MATTERSBURG Nun ist es endgültig beschlossene Sache:
Der Mattersburger Musiksommer findet heuer nicht statt. Die Veranstaltungsreihe
(an drei Freitagen im August spielen stets Musikbands plus Vorgruppen auf) ist ein fixer
Bestandteil bei den Mattersburger Events und auch heuer waren die
Termine (für 7., 14. und 21. August) und die Bands fixiert.",
        dts => [
            map { { date => $_, context => '7., 14. und 21. August' } }
                qw/2020-08-07 2020-08-14 2020-08-21/
        ]
    },
    {   text =>
            "Musik soll Bewohner den Sommer lang begleiten. Die Termine der
Hoftour (Konzerte jeweils von 17 bis 18 Uhr) auf einen Blick:
 24. Juni: 21. Bezirk, Paul Speiser-Hof, Freytaggasse 1-9, Stiege 19.
 30. Juni: 21. Bezirk, Schlingerhof, Brünner Str. 34-38, Stiege 24.
 1. Juli: 2. Bezirk, Köppl-Hof, Saikogasse 6, Platz bei Stiege 44.
 8. Juli: 21. Bezirk, Prager Straße 93-99/Stiege 25.
 4. August: 22. Bezirk, Quadenstraße 65-67, Hof zw. Stg 7 und 10.
 11. August: 10. Bezirk, Olof-Palme-Hof, Ada-Christen-Gasse 2, Innenhof Stiege A und B.
Weitere Termine werden auf wohnpartner-wien.at/aktuelles/news veröffentlicht.
Bei Schlechtwetter werden die Auftritte nicht
stattfinden.",
        dts => [
            { date => '2020-06-24', context => '24. Juni' },
            { date => '2020-06-30', context => '30. Juni' },
            { date => '2020-07-01', context => '1. Juli' },
            { date => '2020-07-08', context => '8. Juli' },
            { date => '2020-08-04', context => '4. August' },
            { date => '2020-08-11', context => '11. August' },
        ]
    }
);

my $ref_date = Date::Simple::ymd( 2020, 01, 01 );
my $parser = Date::Extract::DE->new(
    reference_date => $ref_date,
    lookback_days  => 31
);
my $i = 0;
foreach (@examples) {
    ++$i;
    my $dates          = $parser->extract( $_->{text} );
    my $got_dates      = [ map { $_->as_iso } @$dates ];
    my $expected_dates = [ map { $_->{date} } @{ $_->{dts} } ];
    is_deeply(
        $got_dates,
        $expected_dates,
        sprintf(
            'Example %s: All expected dates found ([%s] vs. [%s])',
            $i,
            join( ' ', @$got_dates ),
            join( ' ', @$expected_dates )
        )
    );

    my $extractions = $parser->extract_with_context( $_->{text} );
    my $expected    = $_->{dts};
    is_deeply( $extractions, $expected,
        sprintf( 'Example %s: All expected extractions found', $i, ) );
}
done_testing;
