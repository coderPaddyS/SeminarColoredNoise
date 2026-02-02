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

#show heading.where(level: 3): set text(size: 20pt)
#show math.equation: set text(size: 20pt)
// #set math.text(size: 12pt)

#start-section-slide(name: "Grundlagen")[
  = Motivierendes Beispiel
  #only(1)[
      #toolbox.side-by-side[
    #figure(
      caption: [
        //   Reinforcement Learning. \ Quelle: Wikipedia @vonmegajuice_eigenes_werk
        //  Quelle: Wikipedia @Lugiadoom_Wikipedia_Image_7100074
        ],
        image("images/Reinforcement_learning_diagram.svg", width: 12cm),
        // image("images/Highimgnoise.jpg", width: 8cm)
      )
  ][
      #figure(
        caption: [
          Aktienkurs der Porsche-Aktie vom \ 12.01.2025 -- 12.01.2026. \ Quelle: https://www.finanzen.net @porscheaktie
        ],
        image("images/aktienkurs.png", width: 12cm)
      )
  ]
  ]
  // #only(2)[
  // #figure(
  //   // caption: [
  //   //   Reinforcement Learning. \ Quelle: Wikipedia @vonmegajuice_eigenes_werk
  //   // ],
  // )
  // ]
]

#slide(alignment: top)[
  = Mathematische Modellierung
  === Zeitabhängiger Stochastischer Prozess
  - Wahrscheinlichkeitsraum $Omega$
  - Indexmenge $cal(T) subset.eq RR$
  - Zielmenge $Z$
  - $X colon Omega times cal(T) -> Z, (omega, t) mapsto X(omega,t) colon.eq X_t (omega)$
  #only("2")[
  - z.$thin$B. $Omega = {0,1}, thick Z = RR$
    #v(1cm)
    #definition(name: "Irrweg (Random Walk)")[
      $ cases(X_0 &= thick 0, X_n &= thick X_(n-1) + thick  omega_n) $<Irrweg> mit $w_n$ unabhängige und identische verteilte Zufallsvariablen über $Z$. 
    ]
  ]
  #only("2")[
    #place(top + right, float: false, scope: "column")[
      #v(-2.2cm)
      #figure(image("plots/random_walk.svg", width: 12cm))
    ]
  ]
]

#slide(alignment: top)[
  = Überlagerung Harmonischer Schwingungen
  #toolbox.side-by-side[
  - $f(t) = integral_cal(T) a(x) dot sin(omega(x)t - phi(x)) dif x$ #v(0.25em)
  - Zumeist $cal(T)$ abzählbar
  #list(marker: $arrow.r.double$)[
    $f(t) = sum_i a_i dot sin(omega_i t - phi_i)$
  ]
  #only("2-")[
  - $f$ automatisch periodisch
  ]
  #only(2)[
    - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ \ für $i in {2, ..., 10}$
  ]
  #only(3)[
    - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ \ für $i in {2, ..., 25}$
  ]
  #only(4)[
    - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ \ für $i in {2, ..., 50}$
  ]
  #only(5)[
    - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ \ für $i in {2, ..., 100}$
  ]
  ][
  #align(horizon + right)[
    #v(-1cm)
    #only(2)[#image(width: 15cm, "plots/Überlagerung-10.svg")]
    #only(3)[#image(width: 15cm, "plots/Überlagerung-25.svg")]
    #only(4)[#image(width: 15cm, "plots/Überlagerung-50.svg")]
    #only(5)[#image(width: 15cm, "plots/Überlagerung-100.svg")]
    ]
  ]
]

// #slide(alignment: top)[
//   = Mathematische Modellierung
//   #toolbox.side-by-side[

//     === Zeitabhängiger Stochastischer Prozess
//     - Wahrscheinlichkeitsraum $Omega$
//     - Indexmenge $cal(T) subset.eq RR$
//     - Zielmenge $Z$
//     - $X colon Omega times cal(T) -> Z, (omega, t) mapsto X(omega,t)$
//     #only("3-")[
//     - z.$thin$B. $Omega = {0,1}, thick Z = RR$
//       #definition(name: "Irrweg (Random Walk)")[
//         $ cases(X_0 &= thick 0, X_n &= thick X_(n-1) + thick  omega_n) $<Irrweg> mit $w_n$ unabhängige und identische verteilte Zufallsvariablen über $Z$. 
//       ]
//     ]
//   ][
//     #only(3)[
//       #figure(image("plots/random_walk.svg"))
//     ]
//     #only("4-")[
//       === Überlagerung Harmonischer Schwingungen
//       - $f(t) = integral_cal(T) a(x) dot sin(omega(x)t - phi(x)) dif x$
//       - Zumeist $cal(T)$ abzählbar
//       #set list(marker: $arrow.r.double$)
//       - $f(t) = sum_i a_i dot sin(omega_i t - phi_i)$
//       #set list(marker: kit-bullet-point)
//     ]
//     #only("5-")[
//       - $f$ automatisch periodisch
//     ]
//     #only(6)[
//       - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 10}$
//     ]
//     #only(7)[
//       - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 50}$
//     ]
//     #only(8)[
//       - z.$thin$B. $a_i = 1, thin omega_i = i^2, phi_i = 0$ für $i in {2, ..., 100}$
//     ]
//     #align(center)[
//     #only(6)[#image(width: 50%, "plots/Überlagerung-10.svg")]
//     #only(7)[#image(width: 50%, "plots/Überlagerung-50.svg")]
//     #only(8)[#image(width: 50%, "plots/Überlagerung-100.svg")]
//     ]
//   ]
// ]

#slide(alignment: top)[
  = Analyse von Rauschsignalen
  #v(-1cm)
  #only((1,2))[
    #toolbox.side-by-side[
      #definition(name: "Fourier-Transformation")[
        Zeit-Bereich $arrow.double$ Frequenz-Bereich
        $ cal(F)(f)(omega) colon.eq 1/sqrt(2 pi) integral_(-infinity)^(+infinity) f(t) e^(-i omega t) dif t $
      ]
    ][
      #only(2)[
        #definition(name: "Inverse-Fourier-Transformation")[
          Zeit-Bereich $arrow.double.l$ Frequenz-Bereich
          $ f(t) = 1/sqrt(2 pi) integral_(-infinity)^(+infinity) cal(F)(f)(omega)e^(i omega t) dif t $<IFT>
        ]
      ]
    ]
    #toolbox.side-by-side[
      #image("plots/Überlagerung-10.svg")
    ][
      #align(center + horizon)[
        #show math.equation: set text(size: 32pt)
        #only(1)[
          $arrow.double.long.r^(cal(F)(dot))$
        ]
        #only(2)[
          $arrow.double.long.l^(cal(F)^(-1)(dot))$
        ]
      ]
    ][
      #image("plots/Überlagerung-fft-10.svg")
    ]
  ]
  #only("3-4")[
    #toolbox.side-by-side[
      === Stochastischer Prozess
    #definition(name: [Autokorrelationsfunktion $R_X (tau)$])[
      $R_X (tau)$ beschreibt wie ähnlich das Signal $X$ zu sich selbst ist innerhalb eines Fensters mit Breite $tau$.
  // $ R_X (t_1,t_2)  &colon.eq "E"{X_(t_1)X_(t_2)} \
  //                     &thick = integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f_(X X)(t_1, t_2) dif x_1 dif x_2 $
  //     $ R_X (t, tau) := R_X (t - tau / 2, t + tau / 2) $
  //     $ R_X (tau) := R_X (t, tau) $
    ]
    ][
      === Harmonische Schwingungen
    #definition(name: "Spektrale Leistungsdichte (PSD)")[
      Die spektrale Leistungsdichte $S(omega)$ gibt den Energieanteil pro Frequenz $omega = 2 pi f$ an. \
      \
      // $ S(omega) := abs(cal(F)(X)(omega))^2 $
    ]
    ]
  ]
  #only(3)[
    #v(-1em)
    #toolbox.side-by-side(columns: (1fr, auto, 1fr))[
      #show: align.with(center)
      #image("plots/rect-signal.svg", width: 9cm)
    ][
      #align(center + horizon)[
        #show math.equation: set text(size: 32pt)
        
        $arrow.double.long.r^(R_X (2))$
      ]
    ][
      #show: align.with(center)
      #image("plots/rect-acr.svg", width: 9cm)
    ]
  ]
  #only("4,7")[
    - Autokorrelationsfunktion und PSD hängen zusammen
    #set list(marker: $arrow.r.double$)
    - Wiener-Chintschin-Theorem:
  ]
  #only("4-")[
$ S(omega) colon.eq cal(F)(R(tau))(omega) $<EqSPD>

  ]
  #only("5,6")[
    #toolbox.side-by-side[
      #definition(name: "Beispiel: Irrweg")[
        $ X = cases(X_0 &= thick 0, X_n &= thick X_(n-1) + thick  omega_n) $
        Ist $X$ ein Irrweg mit $Q = "Var"(omega_k)$, dann ist 
        $ S(omega) = Q/(2 sin(omega (Delta t)/2))^2 tilde.eq Q/(omega^2) $
      ]
    ][
      #only(5)[
        #image("plots/random_walk.svg", width: 12cm)
      ]
      #only(6)[
        #image("plots/random_walk-psd.svg", width: 12cm)
      ]
    ]
  ]
  #only(7)[
    - Rausch-Klassifikation durch PSD. Hier: $S(omega) prop 1/omega^alpha$
  ]
]


#let width = 100%
#start-section-slide(name: "Rauscharten")[
  = Weißes Rauschen $(alpha = 0)$
    #grid(columns: 3,
      [],[],[],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-0-noise-labelless.svg", width: width))
        #place(top + center, float: false, dy: -0.5em)[
          Signal $x_k$
        ]
      ],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-0-sum-labelless.svg", width: width))
        #place(top + center, float: false, dy: -0.5em)[
          Abweichung $ x_(k+1) = x_k + omega_k$
        ]
      ],
      [
        #figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd-labelless.svg"))
        #place(top + center, float: false, dy: -0.5em)[
          PSD $ = "const"$
        ]
      ]
        // #place(top + center, float: false)[
        //   sdfsaf
        // ]
    )
]
#slide[
  = Pinkes Rauschen $(alpha = 1)$
    #subfigure(columns: 3,
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-1-noise-labelless.svg", width: width))
        #place(top + center, float: false, dy: -0.5em)[
          Signal $x_k$
        ]
      ],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-1-sum-labelless.svg", width: width))
        #place(top + center, float: false, dy: -0.5em)[
          Abweichung $ x_(k+1) = x_k + omega_k$
        ]
      ],
      [#figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd-labelless.svg"))
        #place(top + center, float: false, dy: -0.5em)[
          PSD $ prop f^(-1)$
        ]
      ]
    )
]
#slide[
  = Braunes Rauschen $(alpha = 2)$
  #subfigure(columns: 3,
    [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-2-noise-labelless.svg", width: width),)
      #place(top + center, float: false, dy: -0.5em)[
        Signal $x_k$
      ]
    ],
    [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-2-sum-labelless.svg", width: width),) 
      #place(top + center, float: false, dy: -0.5em)[
        Abweichung $ x_(k+1) = x_k + omega_k$
      ]
    ],
    [#figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd-labelless.svg"),)
      #place(top + center, float: false)[
        PSD $ prop f^(-2)$
      ]
    ]
  )
]

#start-section-slide(name: "Verfahren", alignment: top)[
  = Rauschsimulation
  - Ziel: Zu gegebenem $alpha$ generiere diskrete Rauschsignale (Samples) mit $S(omega) prop norm(1/omega^alpha)$ 
  
  #show: later
  #definition(name: [Simulation eines stetigen Prozesses])[
    Ein zeitdiskreter Prozess $tilde(X)_k$ mit Schrittweite $Delta t$ simuliert einen zeitstetigen Prozess $X(t, omega)$ falls: \
    $ R_tilde(X)(tau) = R_X (tau Delta t) $  
  ]

  #reveal-item(start: 1)[
  - Intuitiv: "Diskretisierung ist in jedem Zeitfenster ähnlich zum stetigen Signal"
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
    #only("1-")[
      - Idee: Wähle Amplituden und Frequenzen fest (deterministisch)
        #show: later
        - Aber Phasenverschiebung zufällig 
    ]
    #only("3-")[
    - Nach Diskretisierung und $S(omega) = norm(1/omega^alpha)$ 
    #set list(marker: $arrow.r.double$)
    - $x_k = sum_omega sqrt(norm(1/omega^alpha)) cos(omega k dot Delta t - phi.alt(omega))$
    ]
  ][
    #only("1-2")[
    #align(center)[
      #v(-3cm)
      #image("/plots/Überlagerung-phase-det-100.svg", width: 9cm)
      #show: only.with(2)
      #v(-1cm)
      #image("/plots/Überlagerung-phase-rand-100.svg", width: 9cm)
    ]
    ]
    #show: only.with(3)
    #align(center)[
      #v(-3cm)
      #image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: 9cm)
      #v(-1cm)
      #image("/plots/1000/Phasenrandomisierung-Done-2-psd.svg", width: 9cm)
    ]
    // #subfigure(columns: 2,
    //   figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width)),
    //   figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
    //   figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width)),
    //   figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
    //   figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width)),
    //   figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg")),
    // )
  ]
]

#slide(alignment: top)[
  #toolbox.pdfpc.speaker-note(```md
    - Intuition: Zufällige Phase + x zufällig -> Terme unabhängig zufällig -> Resultat 
  ```)
= Timmer-Koenig
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    - Von Timmer und Koenig in @timmer1995generating
    - Generierung im Frequenz-Bereich
    - #v(2mm)$cal(F)(x)(omega) =& quad 1/sqrt(N) sum_t x(t) cos(omega t) \ &+ i 1/sqrt(N) sum_t x(t) sin(omega t) $
    #show: only.with("2-")
    - Resultat: $cal(F)(x)(omega)$ ist eine komplexe, normalverteilte Zufallsvariable
    #set list(marker: $arrow.r.double$)
    - $cal(F)(x)(omega) = cal(N)(0, 1/2 S(omega)) + i cal(N)(0, 1/2 S(omega))$
    #set list(marker: kit-bullet-point)
    - Idee: Zwei Zufallsvariablen pro Frequenz + Inverse-Fourier-Transformation
  ][
    #show: only.with(3)
    #align(center)[
      #v(-3cm)
      #image("/plots/1000/Timmer-Koenig-2-noise.svg", width: 9cm)
      #v(-1cm)
      #image("/plots/1000/Timmer-Koenig-2-psd.svg", width: 9cm)
    ]
    // #let width = 85%;
    // #subfigure(columns: 2,
    //   figure(image("/plots/1000/Timmer-Koenig-0-noise.svg", width: width)),
    //   figure(image(width: width, "/plots/1000/Timmer-Koenig-0-psd.svg")),
    //   figure(image("/plots/1000/Timmer-Koenig-1-noise.svg", width: width)),
    //   figure(image(width: width, "/plots/1000/Timmer-Koenig-1-psd.svg")),
    // )
  ]
]

#slide(alignment: top)[
= Fraktionale Differenzierung
  #toolbox.side-by-side(columns: (1fr, 1fr))[
    #only("1-2")[
    - Fraktionale = Rekursiv
    - Von Kasdin in @kasdin1995discrete
    - Sowohl Zeit- als auch Frequenzbereich
    ]
    #only("-2")[
    - Idee: Transformiere weißes Rauschen $w_k$ durch eine rekursive Koeffizientenfolge $a_k$
    ]

    #only("2-4")[
      === Frequenz-Bereich:
      - Finite Impulse Response Filter (FIR-Filter)
      - $a_k = (1/2 dot alpha + k - 1) dot a_(k-1)/k$
      - Diskretisierung von \ #v(1mm) $x(t) = &w(t) * F^(-1)(a(omega))(t)\ = &cal(F^(-1))(cal(F)(w) dot a(omega))$
    ]
    #only("3-4")[
      === Zeit-Bereich:
      - Infinite Impulse Response Filter (IIR-Filter)
      - $a_k = (- 1/2 dot alpha + k - 1) dot a_(k-1)/k$
      - $x_k = w_k - sum_i^k a_i x_(k - i)$
    ]
    #only(5)[
      === Frequenz-Bereich:
      - $a_k = (1/2 dot alpha + k - 1) dot a_(k-1)/k$
      === Zeit-Bereich:
      - $a_k = (- 1/2 dot alpha + k - 1) dot a_(k-1)/k$
      === Approximationen:
      Berechne $a_k$ nur für $k in {1, ..., p}$
    ]
  ][
    #only("4-")[
      #align(center)[
        #v(-3cm)
        #image("/plots/1000/FracDiffTime-2-noise.svg", width: 9cm)
        #v(-1cm)
        #image("/plots/1000/FracDiffTime-2-psd.svg", width: 9cm)
      ]
      // #subfigure(columns: 2,
      //   figure(image("/plots/1000/FracDiffTime-0-noise.svg", width: width)),
      //   figure(image(width: width, "/plots/1000/FracDiffTime-0-psd.svg")),
      //   figure(image("/plots/1000/FracDiffTime-1-noise.svg", width: width)),
      //   figure(image(width: width, "/plots/1000/FracDiffTime-1-psd.svg")),
      //   figure(image("/plots/1000/FracDiffTime-2-noise.svg", width: width)),
      //   figure(image(width: width, "/plots/1000/FracDiffTime-2-psd.svg")),
      // )
    ]
  ]
]

#start-section-slide(name: "Vergleich", alignment: top)[
  = Eigenschaften
  #v(-1cm)
  #only("1-")[
  - Phasenrandomisierung berechnet periodisches Rauschen
  ]
  #only("2-")[
  - IIR-Filter hat "unendliches Gedächtnis"
    - Berücksichtigt alle vorherigen Zustände
    - Obwohl $a_k$ endliche Folge
  ]
  #only("4-")[
  - FIR-Filter schlecht für kleines $p$
  ]
  #only("7")[
  - IIR- und FIR-Filter berechnen gleiches Rauschen
  - IIR-Filter ist Echtzeitfähig
  ]
  // - Timmer-Koenig schnell und einfach
  #only(1)[
    #let header = ("Timmer-Koenig", "Phasenrandomisierung", "Fraktionale-Differenzierung").map(x => [
      #pad(bottom: 6mm)[#x]
    ])
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      ..header,
      figure(image(width: width, "plots/1000/deviation/single-repeated/Timmer-Koenig-2.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/Phasenrandomisierung-Done-2.svg")),
      figure(image(width: width, "plots/1000/deviation/single-repeated/FracDiffTime-2.svg")),
  )
    #v(1cm)
  ]
  #let width = 100%
  #only(2)[
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      [#pad(bottom: 6mm)[$p=1$]],
      [#pad(bottom: 6mm)[$p=2$]],
      [#pad(bottom: 6mm)[$p=1000$]],
      figure(image(width: width, "plots/FracDiffTime_cutoff_1.svg")),
      figure(image(width: width, "plots/FracDiffTime_cutoff_2.svg")),
      figure(image(width: width, "plots/FracDiffTime_cutoff_full.svg")),
    )
    #v(1cm)
  ]
  #only(3)[
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      [#pad(bottom: 6mm)[$p=1$]],
      [#pad(bottom: 6mm)[$p=2$]],
      [#pad(bottom: 6mm)[$p=1000$]],
      figure(image(width: width, "plots/FracDiffTime_cutoff_1-psd.svg")),
      figure(image(width: width, "plots/FracDiffTime_cutoff_2-psd.svg")),
      figure(image(width: width, "plots/FracDiffTime_cutoff_full-psd.svg")),
    )
    #v(1cm)
  ]
  #only(4)[
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      [#pad(bottom: 6mm)[$p=5$]],
      [#pad(bottom: 6mm)[$p=50$]],
      [#pad(bottom: 6mm)[$p=100$]],
      figure(image(width: width, "plots/FracDiffFreq_cutoff_5.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_50.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_100.svg")),
    )
    #v(1cm)
  ]
  #only(5)[
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      [#pad(bottom: 6mm)[$p=50$]],
      [#pad(bottom: 6mm)[$p=100$]],
      [#pad(bottom: 6mm)[$p=500$]],
      figure(image(width: width, "plots/FracDiffFreq_cutoff_50.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_100.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_500.svg")),
    )
    #v(1cm)
  ]
  #only(6)[
    #set align(center + bottom)
    #grid(columns: 3,
      row-gutter: -4mm,
      [#pad(bottom: 6mm)[$p=100$]],
      [#pad(bottom: 6mm)[$p=500$]],
      [#pad(bottom: 6mm)[$p=1000$]],
      figure(image(width: width, "plots/FracDiffFreq_cutoff_100.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_500.svg")),
      figure(image(width: width, "plots/FracDiffFreq_cutoff_full.svg")),
    )
    #v(1cm)
  ]
]

#slide()[
  #only(1)[
  = Laufzeit und Speicheraufwand
    #toolbox.side-by-side(columns: (1fr, auto))[
  #figure(image("time/10000/combined/all.svg"))
  ][
    #table(columns: 2,
      stroke: none,
      table.hline(y: 1),
      table.vline(x: 1),
      table.header(
        [*Algorithmus*], [*Speicher*]
      ),
      [Done], [$O(n)$],
      [Timmer-Koenig], [$O(n)$], 
      [FIR-Filter], [$O(n + p)$], 
      [IIR-Filter], [$O(p)$],
    )
    #table(columns: 2,
      stroke: none,
      table.hline(y: 1),
      table.vline(x: 1),
      table.header(
        [*Algorithmus*], [*Laufzeit*]
      ),
      [Done], [$O(n^2)$],
      [Timmer-Koenig], [$O(n log(n))$],
      [FIR-Filter], [$O(n log(n) + p)$],
      [IIR-Filter], [$O(n dot p)$]
    )
  ]
  ]
  // #only(2)[
  // #place(top + center, float: false, scope: "column")[
  // #scale(170%)[
  //   #image("time/10000/combined/all.svg", width: 15cm)
  // ]
  // ]
  // ]
]

#slide[
  = Zusammenfassung und Fazit
  - Rauschen lässt sich unterschiedlich modellieren
  - ... und anhand Eigenschaften klassifizieren
  #list(marker: $arrow.r.double$)[
    Rauschen $!=$ Rauschen
  ]
  - Farbiges Rauschen:
    - PSD $prop 1/(omega^alpha)$ 
    - $alpha$ groß $arrow.r.double$ Niedrige Frequenzen dominieren
  - Verschiedene Möglichkeiten farbige Rauschsamples zu generieren
    - Zeit- und Frequenz-Bereich möglich
  - Samples können für z.$thin$B. Reinforcement Learning genutzt werden 
  
  // Intuition für $alpha$
  // Conclusion, wieso, was ist passiert, und wie weiter
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

#slide(alignment: top)[
  = Vorteile der Modellierungen
  #toolbox.side-by-side[
    === Stochastischer Prozess
    - Stochastische Größen
      - Erwartungswert
      - Varianz
      - Mittelwert
      - $dots$
    - Einfache Modellierung
    - Bildet Zufall direkt ab
  ][
    === Harmonische Schwingungen
    - Rauschen als glatte Funktion
    - Periodische Signale
    - Analyse mit Mitteln der Analysis
    - Kein Zufall
    - Physikalisch leichter deutbar
  ]
]

#slide[
  = Autokorellationsfunktion
  #definition(name: [Autokorrelationsfunktion $R_X (tau)$])[
  $R_X (tau)$ beschreibt wie ähnlich das Signal $X$ zu sich selbst ist innerhalb eines Fensters mit Breite $tau$.
  $ R_X (t_1,t_2)  &colon.eq "E"{X_(t_1)X_(t_2)} \
                      &thick = integral_(-infinity)^(infinity) integral_(-infinity)^(infinity) x_1 x_2 f_(X X)(t_1, t_2) dif x_1 dif x_2 $
      $ R_X (t, tau) := R_X (t - tau / 2, t + tau / 2) $
      $ R_X (tau) := R_X (t, tau) $
    ]
]

#slide(alignment: top)[
  #definition(name: "Spektrale Leistungsdichte (PSD)")[
    Die spektrale Leistungsdichte $S(omega)$ gibt den Energieanteil pro Frequenz $omega = 2 pi f$ an. 
    $ S(omega) := abs(cal(F)(X)(omega))^2 $
  ]
]

#slide(alignment: top)[
  = Simulation eines stetigen Prozesses
  #definition(name: [Simulation eines stetigen Prozesses])[
    Ein zeitdiskreter Prozess $tilde(X)_k$ mit Schrittweite $Delta t$ simuliert einen zeitstetigen Prozess $X(t, omega)$ falls: \
    $ R_tilde(X)(k, m) = R_X (k Delta t, m Delta t) $  
  ]
  - Autokorrelationsfunktion und PSD hängen zusammen
  #set list(marker: $arrow.r.double$)
  - Wiener-Chintschin-Theorem:
  $ S(omega) colon.eq cal(F)(R(tau))(omega) = integral_(-infinity)^infinity R(tau)e^(-j omega tau) dif tau $
]

#let width = 75%
#slide(alignment: top)[
  = Phasenrandomisierung
  #v(-1cm)
  #grid(columns: 3,
    column-gutter: -2cm,
    figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width)),
    figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width)),
    figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width)),
    figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
    figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
    figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg")),
  )
]

#slide(alignment: top)[
  = Timmer-Koenig
  #v(-1cm)
  #grid(columns: 3,
    column-gutter: -2cm,
    figure(image("/plots/1000/Timmer-Koenig-0-noise.svg", width: width)),
    figure(image("/plots/1000/Timmer-Koenig-1-noise.svg", width: width)),
    figure(image("/plots/1000/Timmer-Koenig-2-noise.svg", width: width)),
    figure(image(width: width, "/plots/1000/Timmer-Koenig-0-psd.svg")),
    figure(image(width: width, "/plots/1000/Timmer-Koenig-1-psd.svg")),
    figure(image(width: width, "/plots/1000/Timmer-Koenig-2-psd.svg")),
  )
]

#slide(alignment: top)[
  = Fraktionale Differenzierung
  #v(-1cm)
  #grid(columns: 3,
    column-gutter: -2cm,
    figure(image("/plots/1000/FracDiffTime-0-noise.svg", width: width)),
    figure(image("/plots/1000/FracDiffTime-1-noise.svg", width: width)),
    figure(image("/plots/1000/FracDiffTime-2-noise.svg", width: width)),
    figure(image(width: width, "/plots/1000/FracDiffTime-0-psd.svg")),
    figure(image(width: width, "/plots/1000/FracDiffTime-1-psd.svg")),
    figure(image(width: width, "/plots/1000/FracDiffTime-2-psd.svg")),
  )
]

#slide(alignment: center)[
  = FIR
  #let width = 8cm
  #v(-2cm)
  #grid(columns: 3,
    row-gutter: -4mm,
    [#pad(bottom: 6mm)[$p=5$]],
    [#pad(bottom: 6mm)[$p=50$]],
    [#pad(bottom: 6mm)[$p=100$]],
    figure(image(width: width, "plots/FracDiffFreq_cutoff_5-psd.svg")),
    figure(image(width: width, "plots/FracDiffFreq_cutoff_50-psd.svg")),
    figure(image(width: width, "plots/FracDiffFreq_cutoff_100-psd.svg")),
  )
  #v(-1cm)
  #grid(columns: 2,
    row-gutter: -4mm,
    [#pad(bottom: 6mm)[$p=500$]],
    [#pad(bottom: 6mm)[$p=1000$]],
    figure(image(width: width, "plots/FracDiffFreq_cutoff_500-psd.svg")),
    figure(image(width: width, "plots/FracDiffFreq_cutoff_full-psd.svg")),
  )
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
