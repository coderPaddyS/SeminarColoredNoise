#import "/00_definitions.typ": subfigure
= Rauscharten
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
    #subfigure(columns: 2,
      caption: [
        Rauscharten (von oben nach unten): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen.
        Links das generierte Rauschsignal, rechts das Integral über das Rauschsignal.
      ],
      figure(image("plots/1000/Timmer-Koenig-0-noise.svg"), caption: []),<RauschartenWhite>,
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-0-sum.svg"), caption: [])],
      [#figure(image("plots/1000/Timmer-Koenig-1-noise.svg"), caption: [])<RauschartenPink>],
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-1-sum.svg"), caption: [])],
      [#figure(image("plots/1000/Timmer-Koenig-2-noise.svg"), caption: [])<RauschartenBrown>],
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-2-sum.svg"), caption: [])],
    )<Rauscharten>
