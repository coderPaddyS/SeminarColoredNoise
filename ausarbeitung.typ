#import "ieee-template.typ": ieee

#import "@preview/subpar:0.2.2"

#show: ieee.with(
  title: [
    Generierung von Samples von farbigem Rauschen – Methoden, Implementierung und Vergleich],
  abstract: [

  ],
  authors: (
    (
      name: "Patrick Schneider",
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Figur.],
  paper-size: "a4"
)

= Einleitung
  - Rauschen beschreibt zufällige Signale
    - d.h. Beobachtungen die zufällig wirken, nicht berechenbar sind
    - Tritt natürlich auf, z.B. Schall einer (Meeres-)Welle, Spannungsschwankungen in einem Leiter
  - Komplizierte Systeme emitieren
  - Wofür wird Rauschen benötigt?
  - Was ist farbiges Rauschen?
= Mathematische Beschreibung
  - Stochastischer Prozess
    - Wahrscheinlichkeitsraum $(Omega, cal(F), P)$, $(Z, cal(Z))$ Raum mit $sigma$-Algebra $cal(Z)$
    - Menge an Zufallsvariablen $ X_t: Omega arrow Z ,omega mapsto X_t (omega)$ mit $t in RR_+$
    - Prozess ist linear wenn alle $X_t$ lineare Abbildungen sind
    - Hier meist $x(t) := X_t$
    - Stationär (im engeren Sinne) wenn translationsinvariant, d.h. $(x(t_1), dots, x(t_n)) = (x(t_1 + s), dots, x(t_n + s))$ 
  - Autokorrelationsfunktion
    - $ R(t_1,t_2)  &colon.eq E{x(t_1)x(t_2)} \
                    &= integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f(x_1, x_2; t_1, t_2) d x_1 d x_2 $
    - Dabei ist $f$ die Produktdichte der Zufallsvariablen
    - Symmetrische Definition:
      $ R(t, tau) colon.eq R(t - tau / 2, t + tau / 2) $
    - Für stationäre Prozesse $ R(tau) colon.eq R(t + tau, t) $ mit beliebigem $t$ da invariant unter translation.
    - $R(tau)$ ist gerade, d.h. $R(tau) = R(-tau)$
    - Asymptotisch stationärer Prozess wenn $ lim_(t arrow infinity) R(t, tau) eq R(tau) $
  - Fourier-Transformation
    - $cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) d t$
    - Überträgt eine Funktion vom Zeit-Bereich in den Frequenz-Bereich
  - Inverse Fourier-Transformation
    - $f(t) = 1/sqrt(2 pi) integral_(-infinity)^(+infinity) cal(F)(f)(omega)e^(i omega t) d t$
    - Überträgt eine Funktion vom Frequenz-Bereich in den Zeit-Bereich
  - Spektrale Leistungsdichte
    - $S(omega) colon.eq cal(F)(R(tau))(omega) = integral_(-infinity)^infinity R(tau)e^(-j omega tau) d tau$
    - Fouriertransformierte der Autokorrelationsfunktion
    - Für die Konvergenz der Fouriertransformation muss die Autokorrelationsfunktion absolut integrierbar sein
      - $integral_(-infinity)^(+infinity) |R(tau) d tau| < infinity$
    - Für reelle $R(tau)$ Vereinfachung $ S(omega) = 2 integral_0^infinity R(tau) cos(omega tau) d tau $<FTReelEinfach>
    - Gibt den Anteil an Leistung des Signals pro Frequenz an
      - Also auch maßgeblich die Form des Rauschsignals
  - Brownsche Bewegung
    - Stochastischer Prozess mit den Bedingungen
      1. $B_0 = 0$
      2. Für $0 <= t_0 < t_1 < ... < t_m, m in NN$ ist $B_t_i - B_t_(i-1)$ stochastisch unabhängig und normalverteilt
      3. $B(I), I subset RR$ ist stetig 
    - Eine Realisierung eines Wiener-Prozess, wobei ein Wiener-Prozess ein stochastischer Prozess mit Bedingungen 2 und 3 ist
  - Fraktionale Brownsche Bewegung
    - Verallgemeinerung von Brownscher Bewegung
    - Auf stochastische Unabhängigkeit der Zuwächse in 2. wird verzichtet 
= Rauscharten
  - "Aussehen" der Rauschfunktion durch die spektrale Leistungsdichte bestimmt
  - Dieses folgt dabei einem Potenzgesetz $S(omega) tilde 1/omega^alpha$
  - Klassifikation durch $alpha$
  - Braunes Rauschen @RauschartenBrown
    - $alpha = 2$
    - Niedrige Frequenzen dominieren
    - Quadratische Abnahme
    - Erscheint bei Random Walk, Brownsche Bewegung eines Blattes
  - Pinkes Rauschen @RauschartenPink
    - $alpha = 1$
    - Niedrige Frequenzen dominieren, aber mittlere dennoch ausgeprägt
    - Lineare Abnahme
  - Weißes Rauschen @RauschartenWhite
    - $alpha = 0$
    - Überlagerung aller Frequenzen
    - Alle Frequenzen gleich wahrscheinlich
    - Überall gleich starkes Signal/Energie
    #subpar.grid(columns: 2,
      caption: [
        Rauscharten (von oben nach unten): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen.
        Links das generierte Rauschsignal, rechts das Integral über das Rauschsignal.
      ],
      [#figure(image("plots/1000/powerlaw_timber-0-noise.svg"), caption: [])<RauschartenWhite>],
      [#figure(image("plots/1000/deviation/1d/powerlaw_timber-0-sum.svg"), caption: [])],
      [#figure(image("plots/1000/powerlaw_timber-1-noise.svg"), caption: [])<RauschartenPink>],
      [#figure(image("plots/1000/deviation/1d/powerlaw_timber-1-sum.svg"), caption: [])],
      [#figure(image("plots/1000/powerlaw_timber-2-noise.svg"), caption: [])<RauschartenBrown>],
      [#figure(image("plots/1000/deviation/1d/powerlaw_timber-2-sum.svg"), caption: [])],
    )<Rauscharten>
= Rauschberechnungsmöglichkeiten
  - Phasenrandomisierung @done1992x
    - Algorithmus
      - $ x(t) tilde sum_omega sqrt(S(omega)) cos(omega t - phi.alt(omega)) $
      - direkte Generierung im Zeit-Bereich
      - Wähle dabei $S(omega)$ entsprechend dem Potenzgesetz für die gewünschte Rauschart
      - $phi.alt(omega) in [0, 2 pi]$ ist zufällig gefällt
        $arrow$ Phasenrandomisierung
    - Beobachtung: Phase der niedrigen Frequenzen dominieren
        - Phasenrandomisierung hat durch Konstruktion perfektes PSD
        #subpar.grid(columns: 2,
          caption: [$n$-te Reihe: $alpha = n - 1$],
          figure(image("plots/1000/timeseries_done-0-noise.svg")),
          figure(image("plots/1000/timeseries_done-0-psd.svg")),
          figure(image("plots/1000/timeseries_done-1-noise.svg")),
          figure(image("plots/1000/timeseries_done-1-psd.svg")),
          figure(image("plots/1000/timeseries_done-2-noise.svg")),
          figure(image("plots/1000/timeseries_done-2-psd.svg")),
        )

    - Erzeugt ein periodisches Rauschen
        #subpar.grid(columns: 2,
          caption: [Abweichung einer 2-dimensionalen zufälligen Bewegung mit pinkem Rauschen erzeugt durch Phasenrandomisierung],
          figure(image("plots/1000/deviation/timeseries_done-2-noise.svg")),
          figure(image("plots/1000/deviation/timeseries_done-2-sum.svg")),
        )
  - Power Law Spectrum @timmer1995generating
    - Generiere zufällige komplexe Zahl $z_i$ für jede Frequenz $omega_i$
      - Zwei zufällige (Gauß-Verteilung) zahlen $a,b$
      - Skalieren mit $sqrt(1/2 S(omega_i))$
      $arrow z_i = a + b i$ 
      - Bestimme negative Frequenzen $-omega_i$ durch $f(-omega_i) = f^*(omega_i)$
      - Inverse Fourier-Transformation
    - Resultiert zufällige Wahl der Amplitude und Phase
        #subpar.grid(columns: 2,
          caption: [$n$-te Reihe: $alpha = n - 1$],
          figure(image("plots/1000/powerlaw_timber-0-noise.svg")),
          figure(image("plots/1000/powerlaw_timber-0-psd.svg")),
          figure(image("plots/1000/powerlaw_timber-1-noise.svg")),
          figure(image("plots/1000/powerlaw_timber-1-psd.svg")),
          figure(image("plots/1000/powerlaw_timber-2-noise.svg")),
          figure(image("plots/1000/powerlaw_timber-2-psd.svg")),
        )
  - Fraktionale Differenzierung @kasdin1995discrete
    - Berechnung im Frequenz-Bereich durch einen FIR-Filter
    - Berechnung direkt im Zeit-Bereich durch einen AR-Filter
    - Beide berechnen dasselbe Rauschsignal falls komplette Koeffizientenfolge genutzt wird
      #subpar.grid(columns: 2,
        caption: [$n$-te Reihe: $alpha = n - 1$],
        figure(image("plots/1000/f_alpha-0-noise.svg")),
        figure(image("plots/1000/f_alpha-0-psd.svg")),
        figure(image("plots/1000/f_alpha-1-noise.svg")),
        figure(image("plots/1000/f_alpha-1-psd.svg")),
        figure(image("plots/1000/f_alpha-2-noise.svg")),
        figure(image("plots/1000/f_alpha-2-psd.svg")),
      )
    - Approximation der Frequenz-Bereich-Methode durch Abschneiden der Koeffizienten ab p $p$ ($h_k = 0 quad forall k > p$) entfernt niedrige Frequenzen (Nyquist-Theorem) 
      - resultiert in PSD mit konstantem Bereich bei niedrigen Frequenzen
    - Selbige Approximation führt bei Zeit-Bereich-Methode zu minimalen Unterschieden
      
      // #subpar.grid(columns: 2,
      //   caption: [$n$-te Reihe: $alpha = n - 1$],
      //   figure(image("plots/1000/ar_filter_cutoff_100-0-noise.svg")),
      //   figure(image("plots/1000/ar_filter_cutoff_100-0-psd.svg")),
      //   figure(image("plots/1000/ar_filter-1-noise.svg")),
      //   figure(image("plots/1000/ar_filter-1-psd.svg")),
      //   figure(image("plots/1000/ar_filter_cutoff_100-2-noise.svg")),
      //   figure(image("plots/1000/ar_filter_cutoff_100-2-psd.svg")),
      // )
= Vergleich
  - Geschwindigkeit
    - Phasenrandomisierung sehr langsam
      - Naive Implementierung ca. 10 mal langsamer als mit numpy
    - Power Law nach Timber95 sehr schnell
    - Wie zu erwarten sind die beiden Fraktionale Differenzierung Methoden ähnlich
  - Komplexitätsklassen
    - Power Law $O(n log(n))$ wegen Fourier-Transformation
    - Phasenrandomisierung ist $O(n^2)$ wegen $n$ Summen über $n/2$ Frequenzen
    - Fraktionale Differenzierungsmethoden sind in $O(n * log(n))$ und $O(n * p)$

  #figure(image("time/10000/combined/all.svg"))
  - Güte der Rauschapproximationen
    - Nur Phasenrandomisierung trifft das Potenzgesetz für Rauschen punktgenau
    #subpar.grid(columns: 2,
      caption: [$n$-te Reihe: $alpha = n - 1$],
      figure(image("plots/1000/deviation/combined/sum-0.svg")),
      figure(image("plots/1000/deviation/combined/scaled-0.svg")),
      figure(image("plots/1000/deviation/combined/sum-1.svg")),
      figure(image("plots/1000/deviation/combined/scaled-1.svg")),
      figure(image("plots/1000/deviation/combined/sum-2.svg")),
      figure(image("plots/1000/deviation/combined/scaled-2.svg")),
    )
  
= Zusammenfasung/Ausblick
  - 1 - 2 Sätze pro Abschnitt
  - Empfehlung je nach Anwendungsfall
    - Echtzeitgenerierung: Stand jetzt bin ich bei Timmer95
    - Approximationsgüte: Einer von Kasdin, bin ich gerade nicht sicher welcher
    - Einfachheit: Phasenrandomisierung oder Timmer95, tendiere aber zu Phasenrandomisierung
