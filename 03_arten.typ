#import "/00_definitions.typ": *

= Rauscharten<Rauscharten>
Das PSD bestimmt die Form Rauschsignals
  - "Aussehen" der Rauschfunktion durch die spektrale Leistungsdichte bestimmt
  - Dieses folgt dabei einem Potenzgesetz $S(omega) tilde 1/omega^alpha$
  - Klassifikation durch $alpha$
  - Braunes Rauschen @RauschartenBrown
    - $alpha = 2$
    - Niedrige Frequenzen dominieren
    - Quadratische Abnahme der Leistung mit höheren Frequenzen
    - Wird durch Irrweg erzeugt,
    - Entdeckt 1828 von Robert Brown @brown1828xxvii
    - Hat nur leichte Abweichungen von den niedrigen Frequenzen
    - Äußert sich durch große Berge und Täler
  - Pinkes Rauschen @RauschartenPink
    - $alpha = 1$
    - Niedrige Frequenzen dominieren, aber mittlere dennoch ausgeprägt
    - Lineare Abnahme der Leistung mit höheren Frequenzen
    - erkennbare Berge und Täler auf, aber mit schnellen und stark ausgeprägten Oszillationen
  - Weißes Rauschen @RauschartenWhite
    - $alpha = 0$
    - Überlagerung aller Frequenzen
    - Alle Frequenzen gleich wahrscheinlich
    - Überall gleich starke Leisung
    - Ist die Ableitung von braunem Rauschen #ref(<kasdin1995discrete>, supplement: "S.804")
    - ist gleichmäßig und hat keine erkennbaren Berge oder Täler

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Rauscharten (von links nach rechts): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen.
        Oben das generierte Rauschsignal, unten das Integral über das Rauschsignal, also die summierte Abweichung über die Zeit.
      ],
      figure(image("plots/1000/timeseries_done-0-noise.svg", width: width), caption: []),<RauschartenWhite>,
      [#figure(image("plots/1000/timeseries_done-1-noise.svg", width: width), caption: [])<RauschartenPink>],
      [#figure(image("plots/1000/timeseries_done-2-noise.svg", width: width), caption: [])<RauschartenBrown>],
      [#figure(image("plots/1000/deviation/1d/timeseries_done-0-sum.svg", width: width), caption: [])],
      [#figure(image("plots/1000/deviation/1d/timeseries_done-1-sum.svg", width: width), caption: [])],
      [#figure(image("plots/1000/deviation/1d/timeseries_done-2-sum.svg", width: width), caption: [])],
    )<AbbRauscharten>
]
