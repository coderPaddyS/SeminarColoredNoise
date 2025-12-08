#import "@preview/subpar:0.2.2"

= Rauschberechnungsmöglichkeiten
  - Ein diskreter stochastischer Prozess $x_k$ simuliert einen stetigen stochastischen Prozess $x(t, omega)$
  - Alle Algorithmen nutzen die selben Zufallszahlen
  - Phasenrandomisierung @done1992x
    - Python-Code: @DoneNoise
    - $ x(t) tilde sum_omega sqrt(S(omega)) cos(omega t - phi.alt(omega)) $
    - direkte Generierung im Zeit-Bereich
    - Wähle dabei $S(omega)$ entsprechend dem Potenzgesetz für die gewünschte Rauschart
    - Phase $phi.alt(omega) in [0, 2 pi]$ ist zufällig gefällt
      $arrow$ Phasenrandomisierung
    - Amplitude fest gewählt
      - durch Konstruktion perfektes PSD wie in @BildPhasenrandomisierung
    - Beobachtung durch @timmer1995generating: Phase der niedrigen Frequenzen dominieren
    - Erzeugt ein periodisches Rauschen
      #subpar.grid(columns: 2,
        caption: [Abweichung einer 2-dimensionalen zufälligen Bewegung mit pinkem Rauschen erzeugt durch Phasenrandomisierung],
        figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-noise.svg")),
        figure(image("plots/1000/deviation/Phasenrandomisierung-Done-2-sum.svg")),
      )
    #subpar.grid(columns: 2,
        caption: [Links: Erzeugtes Rauschen des Phasenrandomisierung-Algorithmus, Rechts: Spektralenleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.],
        figure(image("plots/1000/Phasenrandomisierung-Done-0-noise.svg")),
        figure(image("plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
        figure(image("plots/1000/Phasenrandomisierung-Done-1-noise.svg")),
        figure(image("plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
        figure(image("plots/1000/Phasenrandomisierung-Done-2-noise.svg")),
        figure(image("plots/1000/Phasenrandomisierung-Done-2-psd.svg")),
        label: <BildPhasenrandomisierung>
      )
  - Timmer-Koenig-Algorithmus @timmer1995generating
    // - Python-Code: @TimmerKoenigNoise
    - Erzeugt Rauschen im Frequenz-Bereich
    - Generiere zufällige komplexe Zahl $z_i$ für jede Frequenz $omega_i$
      - Zwei zufällige (Gauß-Verteilung) zahlen $a,b$
      - Skalieren mit $sqrt(1/2 S(omega_i))$
      $arrow z_i = a + b i$ 
      - Bestimme negative Frequenzen $-omega_i$ durch $f(-omega_i) = f^*(omega_i)$
      - Inverse Fourier-Transformation
    - Sowohl Phase als auch Amplitude zufällig gewählt
        #subpar.grid(columns: 2,
          caption: [Links: Erzeugtes Rauschen des Timmer-Koenig-Algorithmus, Rechts: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.],
          figure(image("plots/1000/Timmer-Koenig-0-noise.svg")),
          figure(image("plots/1000/Timmer-Koenig-0-psd.svg")),
          figure(image("plots/1000/Timmer-Koenig-1-noise.svg")),
          figure(image("plots/1000/Timmer-Koenig-1-psd.svg")),
          figure(image("plots/1000/Timmer-Koenig-2-noise.svg")),
          figure(image("plots/1000/Timmer-Koenig-2-psd.svg")),
        )
  - Fraktionale Differenzierung @kasdin1995discrete
    - Berechnung im Frequenz-Bereich durch einen FIR-Filter
      - Python-Code: @FractionalDiffFreq
    - Berechnung direkt im Zeit-Bereich durch einen AR-Filter
      - Python-Code: @FractionalDiffTime
    - Beide berechnen dasselbe Rauschsignal falls komplette Koeffizientenfolge genutzt wird
  #place(top, float: true, scope: "parent", [
      #block(width: 90%, fill: aqua)
      #subpar.grid(columns: 3, 
      caption: [Links: Erzeugtes Rauschen der Fraktionale Differenzierung Algorithmen, Rechts: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.],
      figure(image("plots/1000/FracDiffFreq-0-noise.svg"),),
      figure(image("plots/1000/FracDiffFreq-1-noise.svg")),
      figure(image("plots/1000/FracDiffFreq-2-noise.svg")), <FDAlpha2>,
      figure(image("plots/1000/FracDiffFreq-0-psd.svg")),
      figure(image("plots/1000/FracDiffFreq-1-psd.svg")),
      figure(image("plots/1000/FracDiffFreq-2-psd.svg")), <FDAlpha2PSD>,
    )
  ])
    - Approximation der Frequenz-Bereich-Methode durch Abschneiden der Koeffizienten ab $p$ ($h_k = 0 thick forall k > p$) entfernt niedrige Frequenzen (Nyquist-Theorem) 
      - resultiert in PSD mit konstantem Bereich bei niedrigen Frequenzen
      #subpar.grid(columns: 2,
        caption: [Links: Erzeugtes Rauschen des Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich mit einem Abbruch nach $5 "und" 100$ Schritten (von oben nach unten), Rechts: Spektraleleistungsdichte des erzeugten Rauschens.],
        figure(image("plots/FracDiffFreq_cutoff_5.svg")),
        figure(image("plots/FracDiffFreq_cutoff_5-psd.svg")),
        figure(image("plots/FracDiffFreq_cutoff_100.svg")),
        figure(image("plots/FracDiffFreq_cutoff_100-psd.svg")),
      )
    - Selbige Approximation führt bei Zeit-Bereich-Methode zu minimalen Unterschieden
      
      #subpar.grid(columns: 2,
        caption: [Erzeugtes Rauschen des Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich mit einem Abbruch nach $2$ Schritten. (Vgl. @FDAlpha2 und @FDAlpha2PSD)],
        figure(image("plots/1000/FracDiffTime_cutoff_5-2-noise.svg")),
        figure(image("plots/1000/FracDiffTime_cutoff_5-2-psd.svg")),
      )