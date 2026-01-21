#import "kitslides.typ": *
#import "@preview/subpar:0.2.2"

#let subfigure = subpar.grid.with(
  numbering-sub: "a)",
  show-sub-caption: (num, it) => {
    v(-1em)
    align(left)[
      #num
      #if (it.body != []) {
        it.body
      }
    ]
    v(0.5em)
  },
  grid-styles: it => {
    set std.grid(align: center, column-gutter: 1fr)
    it
  },
  // supplement: "asdfasdf",
)

#show: it => KITSlides(
  author: ("Patrick", "Schneider", "Patrick Schneider"),
  supervisor: "Markus Walker",
  date: datetime(year: 2026, month: 2, day: 5),
  title: [
    Generierung von Samples von farbigem Rauschen –
    Methoden, Implementierung und Vergleich
  ],
  shortTitle: [Generierung von Samples von farbigem Rauschen] ,
  it
)

#start-section-slide(name: "Grundlagen")[
= Motivierendes Beispiel
#show: align.with(center)
#only(2)[
  #figure(
  caption: [
    Aktienkurs der Porsche-Aktie vom 12.01.2025 -- 12.01.2026. @porscheaktie
  ],
  image("images/aktienkurs.png", width: 15cm)
)
]
#only(1)[
  #figure(
    caption: [
      Bildrauschen eines Fotos. @Lugiadoom_Wikipedia_Image_7100074
    ],
    image("images/Highimgnoise.jpg", width: 8cm)
  )
]
]

#slide(alignment: top)[
  = Mathematische Modellierung
  #toolbox.side-by-side[
    === Zeitabhängiger Stochastischer Prozess
    - Wahrscheinlichkeitsraum $Omega$
    - Indexmenge $cal(T) subset.eq RR$
    - Zielmenge $Z$
    - $X colon Omega times cal(T) -> Z, (omega, t) mapsto X(omega,t)$
    #only("3-")[
    - z.$thin$B. $Omega = {0,1}, thick Z = RR$
      #definition(name: "Irrweg (Random Walk)")[
        $ cases(X_0 &= thick 0, X_n &= thick X_(n-1) + thick  omega_n) $<Irrweg> mit $w_n$ unabhängige und identische verteilte Zufallsvariablen über $Z$. 
      ]
    ]
  ][
    #only(3)[
      #figure(image("plots/random_walk.svg"))
    ]
    #only("4-")[
      === Überlagerung Harmonischer Schwingungen
      - $f(t) = integral_cal(T) a(x) dot sin(omega(x)t - phi(x)) dif x$
      - Zumeist $cal(T)$ abzählbar
      #set list(marker: $arrow.r.double$)
      - $f(t) = sum_i a_i dot sin(omega_i t - phi_i)$
      #set list(marker: kit-bullet-point)
    ]
    #only("5-")[
      - $f$ automatisch periodisch
    ]
    #only(6)[
      - z.B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 10}$
    ]
    #only(7)[
      - z.B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 50}$
    ]
    #only(8)[
      - z.B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 100}$
    ]
    #align(center)[
    #only(6)[#image(width: 50%, "plots/Überlagerung-10.svg")]
    #only(7)[#image(width: 50%, "plots/Überlagerung-50.svg")]
    #only(8)[#image(width: 50%, "plots/Überlagerung-100.svg")]
    ]
  ]
]

#slide(alignment: top)[
  = Analyse von Rauschsignalen
  #only("1-2")[
    #toolbox.side-by-side[
      #definition(name: "Fourier-Transformation")[
        $ cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) dif t $
      ]
    ][
      #definition(name: "Inverse-Fourier-Transformation")[
        $ f(t) = 1/sqrt(2 pi) integral_(-infinity)^(+infinity) cal(F)(f)(omega)e^(i omega t) dif t $<IFT>
      ]
    ]
  ]
  #only("2-3")[
    #definition(name: "Autokorrelationsfunktion")[
  $ R_X (t_1,t_2)  &colon.eq "E"{X_(t_1)X_(t_2)} \
                      &thick = integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f_(X X)(t_1, t_2) dif x_1 dif x_2 $
      $ R_X (t, tau) := R_X (t - tau / 2, t + tau / 2) $
      $ R_X (tau) := R_X (t, tau) $
    ]
  ]
  #only("3-")[
    #definition(name: "Spektrale Leistungsdichte (PSD)")[
      $ S(omega) := abs(cal(F)(X)(omega))^2 $
    ]
  ]
  #only("4-")[
    - Autokorrelationsfunktion und PSD hängen zusammen
    #set list(marker: $arrow.r.double$)
    - Wiener-Chintschin-Theorem:
$ S(omega) colon.eq cal(F)(R(tau))(omega) = integral_(-infinity)^infinity R(tau)e^(-j omega tau) dif tau $<EqSPD>
  ]
  #only(5)[
    - PSD eines zeitdiskreten Irrwegs $X_k$ mit $Q = "Var"(omega_k)$ ist
    $ S(omega) = Q/(2 sin(omega (Delta t)/2))^2 tilde.eq Q/(omega^2) $
    
  ]
  #only(6)[
    - Klassifikation durch PSD. Hier: $S(omega) prop 1/omega^alpha$
  ]
]


#let width = 100%
#start-section-slide(name: "Rauscharten")[
  = Weißes Rauschen $(alpha = 0)$
    #subfigure(columns: 3,
      figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width)),
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-0-sum.svg", width: width))],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
    )
]
#slide[
  = Pinkes Rauschen $(alpha = 1)$
    #subfigure(columns: 3,
      [#figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width))],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-1-sum.svg", width: width))],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
    )
]
#slide[
  = Braunes Rauschen $(alpha = 2)$
  #subfigure(columns: 3,
    [#figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width),)],
    [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-2-sum.svg", width: width),) ],
    figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg"),),
  )
]

#start-section-slide(name: "Verfahren", alignment: top)[
  = Rauschsimulation
  #definition(name: [Simulation eines stetigen Prozesses])[
    Ein zeitdiskreter Prozess $tilde(X)_k$ mit Schrittweite $Delta t$ simuliert einen zeitstetigen Prozess $X(t, omega)$ falls: \
    $ R_tilde(X)(k, m) = R_X (k Delta t, m Delta t) $  
  ]

  #reveal-item[
  - "Diskretisierung ist in jedem Zeitfenster ähnlich zum stetigen Signal"
  - Ziel: Zu gegebenem $alpha$ ein diskretes Rauschsignal mit $S(omega) prop norm(1/omega^alpha)$ 
  - Generierung im Zeit- oder Frequenzbereich möglich
  ]
]

#slide(alignment: top)[
= Phasenrandomisierung
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    - Nach Done in @done1992x
    - Generierung im Zeitbereich
    - Beobachtung: Rauschen als Überlagerung harmonischer Schwingungen
    #set list(marker: $arrow.r.double$)
    - $x(t) thin prop sum_omega sqrt(S(omega)) cos(omega t - phi.alt(omega)) $
    #set list(marker: kit-bullet-point)
    - Idee: Zufällige Phasenverschiebung 
    - Nach Diskretisierung und $S(omega) = norm(1/omega^alpha)$ 
    #set list(marker: $arrow.r.double$)
    - $x_k = sum_omega sqrt(norm(1/omega^alpha)) cos(omega k dot Delta t - phi.alt(omega))$
  ][
    #show: only.with(2)
    #v(-3cm)
    #let width = 85%;
    #subfigure(columns: 2,
      figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
      figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
      figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg")),
    )
  ]
]

#slide(alignment: top)[
= Timmer-Koenig
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    - Von Timmer und Koenig in @timmer1995generating
    - Generierung im Frequenz-Bereich
    - $cal(F)(x)(omega) = 1/sqrt(N) sum_t x(t) cos(omega t) + i 1/sqrt(N) sum_t x(t) sin(omega t) $
    - Resultat: $cal(F)(x)(omega)$ ist eine komplexe, normalverteilte Zufallsvariable
    #set list(marker: $arrow.r.double$)
    - $cal(F)(x)(omega) = cal(N)(0, 1/2 S(omega)) + i cal(N)(0, 1/2 S(omega))$
    #set list(marker: kit-bullet-point)
    - Idee: Zwei Zufallsvariablen pro Frequenz + Inverse-Fourier-Transformation
  ][
    #show: only.with(2)
    #v(-3cm)
    #let width = 85%;
    #subfigure(columns: 2,
      figure(image("/plots/1000/Timmer-Koenig-0-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-0-psd.svg")),
      figure(image("/plots/1000/Timmer-Koenig-1-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-1-psd.svg")),
      figure(image("/plots/1000/Timmer-Koenig-2-noise.svg", width: width)),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-2-psd.svg")),
    )
  ]
]

#slide(alignment: top)[
= Fraktionale Differenzierung
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    #only("1-2")[
    - Von Kasdin in @kasdin1995discrete
    - Sowohl Zeit- als auch Frequenzbereich
    ]
    #only("-4")[
    - Idee: Transformiere weißes Rauschen $w_k$ durch eine Koeffizientenfolge $a_k$
    ]

    #only("2-")[
      === Frequenz-Bereich:
      - Finite Impulse Response Filter (FIR-Filter)
      - $a_k = (1/2 dot alpha + k - 1) dot a_(k-1)/k$
      - Diskretisierung von \ $x(t) = w(t) * F^(-1)(a(omega))(t) = cal(F^(-1))(cal(F)(w) dot a(omega))$
    ]
    #only("3-")[
      === Zeit-Bereich:
      - Infinite Impulse Response Filter (IIR-Filter)
      - $a_k = (- 1/2 dot alpha + k - 1) dot a_(k-1)/k$
      - $x_k = w_k - sum_i^k a_i x_(k - i)$
    ]
    #only(5)[
      === Approximationen:
      Berechne $a_k$ nur für $k in {1, ..., p}$
    ]
  ][
    #only("4-")[
      #v(-3cm)
      #let width = 85%;
      #subfigure(columns: 2,
        figure(image("/plots/1000/FracDiffTime-0-noise.svg", width: width)),
        figure(image(width: width, "/plots/1000/FracDiffTime-0-psd.svg")),
        figure(image("/plots/1000/FracDiffTime-1-noise.svg", width: width)),
        figure(image(width: width, "/plots/1000/FracDiffTime-1-psd.svg")),
        figure(image("/plots/1000/FracDiffTime-2-noise.svg", width: width)),
        figure(image(width: width, "/plots/1000/FracDiffTime-2-psd.svg")),
      )
    ]
  ]
]

#start-section-slide(name: "Vergleich")[
  = Eigenschaften
  - Phasenrandomisierung berechnet periodisches Rauschen
  - AR-Filter hat "unendliches Gedächtnis"
    - Berücksichtigt alle vorherigen Zustände
    - Obwohl $a_k$ endliche Folge
  - FIR-Filter schlecht für kleines $p$
  - AR- und FIR-Filter berechnen gleiches Rauschen
  // - Timmer-Koenig schnell und einfach
]

#slide()[
  = Laufzeit und Speicheraufwand
  #toolbox.side-by-side[
  #figure(image("time/10000/combined/all.svg"))
  ][
    #figure(
    table(columns: 3,
      table.header(
        [Algorithmus], [Speicher], [Laufzeit]
      ),
      [Phasenrandomisierung], [$O(n)$], [$O(n^2)$],
      [Timmer-Koenig], [$O(n)$], [$O(n log(n))$],
      [FIR-Filter], [$O(n + p)$], [$O(n log(n) + p)$],
      [AR-Filter], [$O(p)$], [$O(n dot p)$]
    )
  )
  ]
]

#slide[
  #v(-3cm)
  #let width = 90%

  #let header = ("Alle", "Timmer-Koenig", "Phasenrandomisierung", "Fraktionale-Differenzierung").map(x => [
    #pad(bottom: 6mm)[#x]
  ])
  
  #set align(center)
  #set text(14pt)
    #grid(columns: (0cm, 2fr, 2fr, 2fr, 2fr),
      row-gutter: -4mm,
      [], ..header,
      rotate(-90deg)[Weiß],
      figure(image(width: width, "plots/1000/deviation/combined/sum-0.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Timmer-Koenig-0.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-0.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/FracDiffTime-0.svg")),
      rotate(-90deg)[pink],
      figure(image(width: width, "plots/1000/deviation/combined/sum-1.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Timmer-Koenig-1.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-1.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/FracDiffTime-1.svg")),
      rotate(-90deg)[Braun],
      figure(image(width: width, "plots/1000/deviation/combined/sum-2.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Timmer-Koenig-2.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-2.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/FracDiffTime-2.svg")),
  )
]

#slide[
  = Zusammenfassung und Fazit
  Intuition für $alpha$
  Conclusion, wieso, was ist passiert, und wie weiter
]

#backup()

#slide[
  #set align(horizon + center)
  #set text(size: 24pt)
  #v(-3cm)
  =
  *Vielen Dank für die Aufmerksamkeit!*
]

#slide[
  = Quellen
  #bibliography("sliderefs.bib", full: true)
]