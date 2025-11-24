#import "ieee-template.typ": ieee


#import "@preview/hydra:0.6.2"
#import "@preview/subpar:0.2.2"

#let appendix = [
  #include "appendix.typ"
]

#show: ieee.with(
  title: [
    Generierung von Samples von farbigem Rauschen – Methoden, Implementierung und Vergleich],
  seminar: [Seminar WS25/26: Moderne Methoden der Informationsverarbeitung],
  abstract: [
    #h(0.5em)Diese Ausarbeitung stellt verschiedene Rauscharten die dem Potenzgesetz $norm(1/f^alpha)$ genügen vor,
    reißt kurz die mathematischen Grundlagen und Modellierungen von Rauschen an und vergleicht verschiedene Methoden zur Generierung von Rauschen mit gewünschter spektraler Leistungsdichte.
  ],

  authors: (
    (
      name: "Patrick Schneider",
    ),
  ),
  bibliography: bibliography("refs.bib", full: true),
  figure-supplement: [Abb.],
  paper-size: "a4",
  appendix: appendix
)

= Einleitung
  - Rauschen beschreibt zufällige Signale
  - d.h. Beobachtungen die zufällig wirken, nicht berechenbar sind
  - Tritt natürlich auf, z.B. Schall einer (Meeres-)Welle, Spannungsschwankungen in einem Leiter
  - Oftmals eine Beschreibung großer und komplizierter Systeme mit vielen Unbekannten
  - Repräsentieren einen Zustand hoher Entropie und vieler Informationen
  - Rauschen ist zumeist unerwünscht und lenkt vom gewünschten Ergebnis ab
    - Z.b. Audioaufnahmen @prasadh2017efficiency, Medizinische Bildaufnahmen wie MRT und Ultraschall @yousuf2011new
  - Um Rauschen zu erkennen muss man Rauschen verstehen
  - Damit auch eine Klassifizierung/Differenzierung von Rauscharten
  - Und Möglichkeiten Rausch selbst zu generieren
  - Diese Ausarbeitung über die Arbeiten von Timmer und Koenig @timmer1995generating sowie Kasdin @kasdin1995discrete aus 1995 geht auf die unterschiedlichen Rauschfarben anhand des $1/f^alpha$ Potenzgesetzes ein und vergleicht vorgestellte Methoden zur Generierung von farbigem Rauschen.
= Mathematische Beschreibung
  - Stochastischer Prozess
    - Wahrscheinlichkeitsraum $(Omega, cal(F), P)$, $(Z, cal(Z))$ Raum mit $sigma$-Algebra $cal(Z)$
    - Menge an Zufallsvariablen $ X_t: Omega arrow Z ,omega mapsto X_t (omega)$ mit $t in RR_+$
    - Prozess ist linear wenn alle $X_t$ lineare Abbildungen sind
    - Hier meist $x(t) := X_t$
    - Stationär (im engeren Sinne) wenn translationsinvariant, d.h. $(x(t_1), dots, x(t_n)) = (x(t_1 + s), dots, x(t_n + s))$ 
    - Hier verwendete Definition sind zeitstetig
      - überabzählbare Indexmenge, genauer Teilintervall von $RR$
    - Wertestetig falls $Z subset.eq RR$, sonst wertediskret.
  - Klassisches Model eines wertediskreten Stochastischen Prozesses ist eine endliche Markovkette, z.B.
    - Münzwurf, gleiche, unabhängige Wahrscheinlichkeit pro Münzwurf für Kopf/Zahl
    - Zufallsvariable $X_t$ beschreibt dabei die Differenz "Kopf - Zahl" nach $t$ Würfen
    - Hängt nicht davon ab, wann geworfen wird $arrow$ unabhängige Zuwächse
  - Wertestetig, zeitdiskret ist ein Irrweg auf reellen Zahlen
    - $ cases(x_0 &= thick 0, x_n &= thick x_(n-1) + thick  omega_n) $<Irrweg> mit $w_n$ unabhängig zufällig gewählt 
    #figure(image("plots/random_walk.svg"), caption: [
      Normalverteilter, zeitdiskreter Irrweg mit 1000 Schritten
    ])
  - Rauschen ist im Allgemeinen eine Überlagerung von beliebig vielen harmonischen Schwingungen
    - $ f(t) = sum_i a_i dot sin(omega_i t - phi.alt_i) $
    - $(a_i)_(i in NN) subset RR, (omega_i)_(i in NN) subset RR, (phi_i)_(i in NN) subset [0, 2pi]$
    - Perfektes/echtes Rauschen kann nicht diskret generiert werden
    - Da sehr kompliziert ist Rauschen effektiv zufällig und üblicherweise als zeitstetiger und wertestetiger stochastischer Prozess modelliert
  - Rauschen nach dieser Definition periodisches Signal
    - Fourier-Transformation
      - $cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) d t$
      - Überträgt eine Funktion vom Zeit-Bereich in den Frequenz-Bereich
    - Inverse Fourier-Transformation
      - $f(t) = 1/sqrt(2 pi) integral_(-infinity)^(+infinity) cal(F)(f)(omega)e^(i omega t) d t$
      - Überträgt eine Funktion vom Frequenz-Bereich in den Zeit-Bereich
  - Rauschen kann durch verschiedene Eigenschaften klassifiziert werden, z.B. wie ähnlich ist es zu sich selbst
  - Autokorrelationsfunktion
    - $ &R(t_1,t_2)  colon.eq E{x(t_1)x(t_2)} \
                    &= integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f(x_1, x_2; t_1, t_2) d x_1 d x_2 $
    - Dabei ist $f$ die Produktdichte der Zufallsvariablen
    - Symmetrische Definition:
      $ R(t, tau) colon.eq R(t - tau / 2, t + tau / 2) $
    - $R(tau)$ ist gerade, d.h. $R(tau) = R(-tau)$
    - Für stationäre Prozesse $ R(tau) colon.eq R(t + tau, t) $ mit beliebigem $t$ da invariant unter translation.
    - Nicht jeder stochastische Prozess ist stationär, deswegen
    - Asymptotisch stationärer Prozess wenn $ lim_(t arrow infinity) R(t, tau) eq R(tau) $
  - Spektrale Leistungsdichte (PSD)
    - Klassifikation verschiedener Rauschsignale
    - $S(omega) colon.eq cal(F)(R(tau))(omega) = integral_(-infinity)^infinity R(tau)e^(-j omega tau) d tau$
    - Fouriertransformierte der Autokorrelationsfunktion
    - Für die Konvergenz der Fouriertransformation muss die Autokorrelationsfunktion absolut integrierbar sein
      - $integral_(-infinity)^(+infinity) |R(tau) d tau| < infinity$
    - Für reelle $R(tau)$ Vereinfachung $ S(omega) = 2 integral_0^infinity R(tau) cos(omega tau) d tau $<FTReelEinfach>
    - Gibt den Anteil an Leistung des Signals pro Frequenz an
      - Also auch maßgeblich die Form des Rauschsignals
  - Computer können nur zeitdiskret und wertediskret simulieren. Eine Diskretisierung von @Irrweg kann als Differenzgleichung geschrieben werden:
    $ x_(k+1) &= sum_(n=0)^k integral_(t_n)^(t_(n+1)) omega(tau) d tau \
              &= sum_(n=0)^(k-1) omega_n + integral_(t_k)^(t_(k+1)) omega(tau) d tau
              &= x_k + omega_k $
    - Das resultiert in der Spektralenleistungsdichte
      $ S_d = Q/(2 sin(omega (Delta t)/2))^2 tilde.eq Q/(omega^2) $
      wobei die Approximation für Frequenzen gilt und $Q$ die Varianz von dem gewählten $w_k$ Prozess ist.
  - Brownsche Bewegung
    - Stochastischer Prozess mit den Bedingungen
      1. $B_0 = 0$
      2. Für $0 <= t_0 < t_1 < ... < t_m, m in NN$ ist $B_t_i - B_t_(i-1)$ stochastisch unabhängig und normalverteilt
      3. $B(I), I subset RR$ ist stetig 
    - Eine Realisierung eines Wiener-Prozess, wobei ein Wiener-Prozess ein stochastischer Prozess mit Bedingungen 2 und 3 ist
    - @Irrweg ist ein Modell einer Brownschen Bewegung.
  - Fraktionale Brownsche Bewegung
    - Verallgemeinerung von Brownscher Bewegung
    - Auf stochastische Unabhängigkeit der Zuwächse in 2. wird verzichtet
  - Fraktionale Differenzierung
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
    #subpar.grid(columns: 2,
      caption: [
        Rauscharten (von oben nach unten): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen.
        Links das generierte Rauschsignal, rechts das Integral über das Rauschsignal.
      ],
      [#figure(image("plots/1000/Timmer-Koenig-0-noise.svg"), caption: [])<RauschartenWhite>],
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-0-sum.svg"), caption: [])],
      [#figure(image("plots/1000/Timmer-Koenig-1-noise.svg"), caption: [])<RauschartenPink>],
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-1-sum.svg"), caption: [])],
      [#figure(image("plots/1000/Timmer-Koenig-2-noise.svg"), caption: [])<RauschartenBrown>],
      [#figure(image("plots/1000/deviation/1d/Timmer-Koenig-2-sum.svg"), caption: [])],
    )<Rauscharten>
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
      #subpar.grid(columns: 2,
        caption: [Links: Erzeugtes Rauschen der Fraktionale Differenzierung Algorithmen, Rechts: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.],
        figure(image("plots/1000/FracDiffFreq-0-noise.svg")),
        figure(image("plots/1000/FracDiffFreq-0-psd.svg")),
        figure(image("plots/1000/FracDiffFreq-1-noise.svg")),
        figure(image("plots/1000/FracDiffFreq-1-psd.svg")),
        figure(image("plots/1000/FracDiffFreq-2-noise.svg")), <FDAlpha2>,
        figure(image("plots/1000/FracDiffFreq-2-psd.svg")), <FDAlpha2PSD>,
      )
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
= Vergleich
  - Geschwindigkeit
    - Phasenrandomisierung sehr langsam
    - Timmer-Koenig-Algorithmus sehr schnell
    - Wie zu erwarten sind die beiden Fraktionale Differenzierung Methoden ähnlich
  - Komplexitätsklassen
    - Timmer-Koenig-Algorithmus $O(n log(n))$ wegen Fourier-Transformation
    - Phasenrandomisierung ist $O(n^2)$ wegen $n$ Summen über $n/2$ Frequenzen
    - Fraktionale Differenzierungsmethoden sind in $O(n log(n) + p)$ und $O(n dot p)$
  - Phasenrandomisierung, Timmer-Koenig-Algorithmus und der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich nur für die Generierung von langen Rauschsignalen
  - Der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich kann für Echtzeitgenerierung verwendet werden
    - Es werden nur wenige alte Werte für einen neuen Wert benötigt. Die Koeffizientenfolge kann einmal vorberechnet werden.
  #figure(caption: [
    Berechnungszeit der Algorithmen in Sekunden.
  ],image("time/100000.0/combined/all.svg"))
  - Güte der Rauschapproximationen
    - Nur Phasenrandomisierung trifft das Potenzgesetz für Rauschen punktgenau
    - Dafür große Varianz
    #subpar.grid(columns: 2,
      caption: [Links: Integral der verschiedenen generierten Rauschsignalen. Rechts: Normierung von links auf den Bereich $[-1,1]^2$. \ $n$-te Reihe: $alpha = n - 1$.],
      figure(image("plots/1000/deviation/combined/sum-0.svg")),
      figure(image("plots/1000/deviation/combined/scaled-0.svg")),
      figure(image("plots/1000/deviation/combined/sum-1.svg")),
      figure(image("plots/1000/deviation/combined/scaled-1.svg")),
      figure(image("plots/1000/deviation/combined/sum-2.svg")),
      figure(image("plots/1000/deviation/combined/scaled-2.svg")),
    )
  
= Zusammenfasung/Ausblick
  - Rauschen als eigentlich Überlagerte harmonische Schwingung wird als stochastischer Prozess, oftmals als Brownsche Bewegung modelliert.
  - Anhand der Spektralenleistungsdichte kann Rauschen in verschiedene Kategorien unterteilt werden.
  - Weißes, Pinkes und Braunes Rauschen kann auf verschiedene Arten sowohl im Zeit- als auch im Frequenz-Bereich generiert werden
  - Dabei ist der Fraktionale-Differenzierung-Algorithmus im Zeit-Bereich am Besten für Echtzeitgenerierung geeignet
  - Sowohl der Timmer-Koenig-Algorithmus als auch der Fraktionale-Differenzierung-Algorithmus im Frequenz-Bereich eignen sich für die Generierung von längeren Rauschsignalen.
  - Der Algorithmus nach Done @done1992x eignet sich aufgrund des exakten PSD für präzise Analysen
  - Dieser ist auch am Einfachsten zu implementieren und zu verstehen