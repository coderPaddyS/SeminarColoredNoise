#import "/00_definitions.typ": *

= Rauscharten<Rauscharten>

Das PSD bestimmt die Form des Rauschsignals und häufig natürlich auftretende Rauschsignale weisen ein PSD auf, das einem Potenzgesetz folgt (vgl. @done1992x, @timmer1995generating):
$ S(omega) tilde.basic norm(1/omega^alpha) tilde.basic norm(1/f^alpha), quad omega, alpha in RR $
Gewöhnlich wird $alpha in [0, -2]$ betrachtet, aber auch $alpha > 0$ und $alpha < -2$ treten natürlich auf. Gemäß $alpha$ wird einem Rauschsignal eine Farbe zugesprochen, die dem PSD interpretiert als sichtbares Lichtspektrum entspricht, um die Terminologie zu vereinfachen. Braunes Rauschen ist allerdings eine Ausnahme zu diesem Bezeichnungsschema.

In dieser Ausarbeitung werden die folgenden Farben betrachtet:

#heading(level: 2,numbering: none)[$alpha = 2$: #emph[Braunes Rauschen]]

Die Leistung von braunem Rauschen nimmt quadratisch mit der Frequenz ab.
Entsprechend dominieren die niederen Frequenzen -- das Signal ähnelt einer periodischen Schwingung
mit zufälligen Abweichungen. (Vgl. @RauschartenBrown). Nonchalant lässt sich braunes Rauschen visuell durch ausgeprägte "Berge und Täler"#footnote[
  Als Berg wird hier ein "größeres" Zeitinterval bezeichnet, in dem das Signal deutlich größer als $0$ ist. Im Gegensatz ist ein Tal ein "größeres" Zeitinterval, in dem das Signal deutlich kleiner als $0$ ist.
] erkennen.
Diese spiegeln sich im Integral wie man in @AbbRauschartenPhasenrandomisierung sehr gut erkennen kann wieder und kann als längere Abweichungsphasen vom Erwartungswert gedeutet werden.
Namensgebend ist die Entdeckung durch Robert Brown in @brown1828xxvii in 1828 und die Modellierung einer Brownschen Bewegung.

    // - Niedrige Frequenzen dominieren
    // - Quadratische Abnahme der Leistung mit höheren Frequenzen
    // - Wird durch Irrweg erzeugt,
    // - Entdeckt 1828 von Robert Brown @brown1828xxvii
    // - Hat nur leichte Abweichungen von den niedrigen Frequenzen
    // - Äußert sich durch große Berge und Täler
#include "/00_diagrams/AlgTimmerKoenig.typ"

#heading(level: 2,numbering: none)[$alpha = 1$: #emph[Pinkes Rauschen]]
  Die Leistung von pinkem Rauschen nimmt linear mit der Frequenz ab. Das Signal weist schnelle und starke Schwankungen mit einer leichten, aber schnellen Grundschwingung auf wie in @RauschartenPink zu sehen ist. Visuell lässt sich pinkes Rauschen durch erkennbare, aber sehr kurze, "Berge und Täler" identifizieren. Diese lassen sich ebenfalls in @AbbRauschartenPhasenrandomisierung als große Abweichungen von der $0$ erkennen.

  Allerdings sind diese Abweichungen im Vergleich zu braunem Rauschen geringer, weshalb pinkes Rauschen
 deswegen in explorativen Lernstrategien genutzt (vgl. @eberhard2023pink) wird.
  // - Niedrige Frequenzen dominieren, aber mittlere dennoch ausgeprägt
  // - Lineare Abnahme der Leistung mit höheren Frequenzen
  // - erkennbare Berge und Täler auf, aber mit schnellen und stark ausgeprägten Oszillationen

#heading(level: 2,numbering: none)[$alpha = 0$: #emph[Weißes Rauschen]]
Bei weißem Rauschen ist die Leistung im Verhältnis zur Frequenz konstant. Das Signal weist keine erkennbare Muster auf und ist "gleichbleibend zufällig" (siehe @RauschartenWhite). Visuell lässt sich weißes Rauschen am Mangel von "Bergen und Täler" und am "Bandverhalten"#footnote[
  Als "Bandverhalten" wird hier die Beobachtung bezeichnet, dass die Masse des Rauschsignals nahe am Erwartungswert liegt. Entfernt man die oberen und unteren 25% der Amplituden, schneidet also in @RauschartenWhite bei $y= plus.minus 1$ ab, so verbleibt ca. die Hälfte des Signals.
] erkennen.

Das Integral über weißes Rauschen ist eine Realisierung einer Brownschen Bewegung und damit ein braunes Rauschsignal (siehe #ref(<kasdin1995discrete>, supplement: "S.804")).


    // - Überlagerung aller Frequenzen
    // - Alle Frequenzen gleich wahrscheinlich
    // - Überall gleich starke Leisung
    // - Ist die Ableitung von braunem Rauschen 
    // - ist gleichmäßig und hat keine erkennbaren Berge oder Täler

  // - "Aussehen" der Rauschfunktion durch die spektrale Leistungsdichte bestimmt
  // - Dieses folgt dabei einem Potenzgesetz $S(omega) tilde 1/omega^alpha$
  // - Klassifikation durch $alpha$
  // - Braunes Rauschen @RauschartenBrown
  //   - $alpha = 2$
  //   - Niedrige Frequenzen dominieren
  //   - Quadratische Abnahme der Leistung mit höheren Frequenzen
  //   - Wird durch Irrweg erzeugt,
  //   - Entdeckt 1828 von Robert Brown @brown1828xxvii
  //   - Hat nur leichte Abweichungen von den niedrigen Frequenzen
  //   - Äußert sich durch große Berge und Täler
  // - Pinkes Rauschen @RauschartenPink
  //   - $alpha = 1$
  //   - Niedrige Frequenzen dominieren, aber mittlere dennoch ausgeprägt
  //   - Lineare Abnahme der Leistung mit höheren Frequenzen
  //   - erkennbare Berge und Täler auf, aber mit schnellen und stark ausgeprägten Oszillationen
  // - Weißes Rauschen @RauschartenWhite
  //   - $alpha = 0$
  //   - Überlagerung aller Frequenzen
  //   - Alle Frequenzen gleich wahrscheinlich
  //   - Überall gleich starke Leisung
  //   - Ist die Ableitung von braunem Rauschen #ref(<kasdin1995discrete>, supplement: "S.804")
  //   - ist gleichmäßig und hat keine erkennbaren Berge oder Täler
