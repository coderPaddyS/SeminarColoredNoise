#import "@preview/subpar:0.2.2"
#import "/00_definitions.typ": *

#include "/00_diagrams/AlgFracDiffFreq.typ"
= Rauschberechnungsmöglichkeiten
Ein diskreter stochastischer Prozess $tilde(X)$ simuliert einen stetigen stochastischen Prozess $X(t, omega)$, falls 
$ R_tilde(X)(k, m) = R_X (k Delta t, m Delta t) $
für alle $k, m in floor(cal(T) / (Delta t)) := { t / (Delta t) | t in cal(T) }$ gilt.
Oder in natürlichen Worten, falls die Autokorrelationsfunktion der Diskretisierung $tilde(X)$ für alle Abtastpunkte mit der Autokorrelationsfunktion des stetigen Prozesses $X$ übereinstimmt.
Ein solcher Prozess $tilde(X)$ ist jederzeit genauso ähnlich zu sich selbst wie $X$ sich selbst ähnelt.
Diese Simulationsbedingung überträgt sich direkt auf das PSD (vgl. @EqSPD).

Auf diese Weise werden nun vier Algorithmen vorgestellt, die für $alpha in [0, 2]$ Rauschen gemäß dem $norm(1/f^alpha)$ Potenzgesetz erzeugen.
Aus Gründen der Vergleichbarkeit werden die selben Zufallszahlen für die Algorithmen genutzt.

#heading(level: 2,numbering: none)[Phasenrandomisierung nach @done1992x]

Ziel dieses Algorithmus ist die Generierung eines Rauschsignals direkt im Zeitbereich, die dem Potenzgesetz genügt.
Als Basis dient die Beobachtung
  $ x(t) tilde.basic sum_omega sqrt(S(omega)) cos(omega t - phi.alt(omega)) $
woraus nach Diskretisierung
  $ x_k tilde.basic sum_omega sqrt(S(omega)) cos(omega k dot Delta t - phi.alt(omega)) $
wird, wobei $S(omega) tilde.basic norm(1/omega^alpha)$ das gewünschte PSD ist.
Die Amplitude für jede harmonische Schwingung wird gemäß der zugehörigen Frequenz direkt berechnet und gibt im Fall $S(omega) = norm(1/omega^alpha)$ ein perfektes PSD wieder.
Hier implementiert ist entsprechend die Gleichung
  $ x_k = sum_omega sqrt(norm(1/omega^alpha)) cos(omega k dot Delta t - phi.alt(omega)) $
und die simulierten Rauschsignale sind in @AbbRauschartenPhasenrandomisierung zu sehen.
Nach Konstruktion ist das so erzeugte Signal automatisch $(n dot Delta t)$-periodisch wobei $n$ die Anzahl an Simulationsschritten ist.
Dies lässt sich besonders gut in @Phasenrandomisierung2dDev sehen, in der über die Phasenrandomisierung ein 2-dimensionaler Pfad bestimmt wurde. Dafür wurde ein 2-dimensionales Rauschens $(x, y)$ erzeugt, in dem für jede Dimension unabhängig eine Rauschsignal generiert wurde. Anschließend wurden die Pfadpunkte durch 
$ (tilde(x)_k, tilde(y)_k) = (sum_(i=0)^k x_k, sum_(i=0)^k y_k) $<Pfad>
bestimmt.

#topcol[
  #subfigure(
      columns: 2,
      caption: [
        Abweichung einer 2-dimensionalen zufälligen Bewegung mit pinkem Rauschen erzeugt durch den Phasenrandomisierungsalgorithmus.
      ],
      figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-noise.svg")),
      figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-sum.svg")),
      label: <Phasenrandomisierung2dDev>,
  )
]
  // - Alle Algorithmen nutzen die selben Zufallszahlen
  // - Phasenrandomisierung @done1992x
  //   - Python-Code: @DoneNoise
  //   - direkte Generierung im Zeit-Bereich
  //   - Wähle dabei $S(omega)$ entsprechend dem Potenzgesetz für die gewünschte Rauschart
  //   - Phase $phi.alt(omega) in [0, 2 pi]$ ist zufällig gefällt
  //     $arrow$ Phasenrandomisierung
  //   - Amplitude fest gewählt
  //     - durch Konstruktion perfektes PSD wie in @BildPhasenrandomisierung
  //   - Beobachtung durch @timmer1995generating: Phase der niedrigen Frequenzen dominieren
  //   - Erzeugt ein periodisches Rauschen
  //     #subpar.grid(columns: 2,
  //       caption: [Abweichung einer 2-dimensionalen zufälligen Bewegung mit pinkem Rauschen erzeugt durch Phasenrandomisierung],
  //       figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-noise.svg")),
  //       figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-sum.svg")),
  //     )
#heading(level: 2,numbering: none)[Timmer-Koenig-Algorithmus nach @timmer1995generating]

Dieser Algorithmus basiert auf der Beobachtung in @FTZählbareHarmonischeSchwingung, wodurch ein Rauschen mit abzählbar (sogar endlich) vielen harmonischen Schwingungen approximiert werden kann.
Jede harmonische Schwingung hat höchstens zwei $delta$-Ausschläge. Die Summe dieser wie in @Modell kann nach korrekter Skalierung der Amplitude durch die Inverse-Fourier-Transformation wie in @IFT zu einem Rauschsignal im Zeitbereich transformiert werden.

Daraus ensteht der Algorithmus:

  1. Generiere eine zufällige komplexe Zahl $z_k$ für jede Frequenz $omega_k = a_k + i b_k$ durch zwei zufällig verteilte Zahlen $a_k,b_k tilde cal(N)(0, 1/2 S(omega)) = 1/2 S(omega) cal(N)(0,1)$.
  2. Bestimme die negativen $delta$-Ausschläge von $-omega_i$ durch komplexe Konjugation $overline(z_k) = a_k - i b_k$
  3. Wende die Inverse-Fourier-Transformation auf die $delta$-Ausschläge an.

Die Korrektheit des Algorithmus geht aus #ref(<timmer1995generating>, supplement: "S.708, (9)") hervor.

Im  Das Resultat des Algorithmus lässt sich in @BildTimmerKoenig sehen.
Gegensatz zum Phasenrandomisierungsalgorithmus wird hier sowohl Phase als auch Amplitude zufällig gewählt. 

    // // - Python-Code: @TimmerKoenigNoise
    // - Erzeugt Rauschen im Frequenz-Bereich
    // - Generiere zufällige komplexe Zahl $z_i$ für jede Frequenz $omega_i$
    //   - Zwei zufällige (Gauß-Verteilung) zahlen $a,b$
    //   - Skalieren mit $sqrt(1/2 S(omega_i))$
    //   $arrow z_i = a + b i$ 
    //   - Bestimme negative Frequenzen $-omega_i$ durch $f(-omega_i) = f^*(omega_i)$
    //   - Inverse Fourier-Transformation
    // - Sowohl Phase als auch Amplitude zufällig gewählt

#heading(level: 2,numbering: none)[Fraktionale Differenzierung nach @kasdin1995discrete]

Eine Alternative zur iterativen Berechnung von Rauschsignalen wie in den beiden vorherigen Algorithmen ist eine rekursive Berechnung. In @kasdin1995discrete werden jeweils eine Berechnungsmöglichkeit im Frequenz- und Zeit-Bereich vorgestellt.

Die beiden Methoden nutzen im Frequenz-Bereich einen FIR-Filter und im Zeit-Bereich einen AR-Filter.
Diese Filter werden nach einer Rekursionsvorschrift berechnet und realisieren dadurch eine Fraktionale Differenzierung (vgl. #ref(<kasdin1995discrete>, supplement: "S. 820")). 

Beide Algorithmen berechnen den selben Filter und erzeugen dasselbe Rauschsignal wie in @FracDiff dargestellt.
Aufgrund der Rekursionsvorschrift können die Algorithmen leicht zu Approximationsalgorithmen angepasst werden: 

Anstelle die komplette Koeffizientenfolge zu nutzen, werden im Frequenz-Algorithmus nur die ersten $p$ Koeffizienten genutzt und im Zeit-Bereich nur die letzten $p$ Koeffizienten.

Das führt im Frequenz-Algorithmus zum Fehlen der niederen Frequenzen (Nyquist-Theorem) und im Zeit-Bereich zu "Fehlern" wie in @FracDiffFreqApprox und @FracDiffTimeApprox zu sehen ist.

#topcol[
  #subfigure(columns: 2,
    caption: [Links: Erzeugtes Rauschen des Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich (FIR-Filter) mit einem Abbruch nach $p=5$ und $p=100$ Schritten (von oben nach unten), Rechts: Spektraleleistungsdichte des erzeugten Rauschens.],
    figure(image("plots/FracDiffFreq_cutoff_5.svg")),
    figure(image("plots/FracDiffFreq_cutoff_5-psd.svg")),
    figure(image("plots/FracDiffFreq_cutoff_100.svg")),
    figure(image("plots/FracDiffFreq_cutoff_100-psd.svg")),
    label: <FracDiffFreqApprox>
  )
  #subfigure(columns: 2,
    caption: [Erzeugtes Rauschen des Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich (AR-Filter) mit einem Abbruch nach $2$ Schritten. (Vgl. @FDAlpha2 und @FDAlpha2PSD)],
    figure(image("plots/1000/FracDiffTime_cutoff_5-2-noise.svg")),
    figure(image("plots/1000/FracDiffTime_cutoff_5-2-psd.svg")),
    label: <FracDiffTimeApprox>
  )
]
    // - Berechnung im Frequenz-Bereich durch einen FIR-Filter
    //   - Python-Code: @FractionalDiffFreq
    // - Berechnung direkt im Zeit-Bereich durch einen AR-Filter
    //   - Python-Code: @FractionalDiffTime
    // - Beide berechnen dasselbe Rauschsignal falls komplette Koeffizientenfolge genutzt wird
    // - Approximation der Frequenz-Bereich-Methode durch Abschneiden der Koeffizienten ab $p$ ($h_k = 0 thick forall k > p$) entfernt niedrige Frequenzen (Nyquist-Theorem) 
    //   - resultiert in PSD mit konstantem Bereich bei niedrigen Frequenzen
    // - Selbige Approximation führt bei Zeit-Bereich-Methode zu minimalen Unterschieden
