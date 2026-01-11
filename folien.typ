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

#start-section-slide("Grundlagen")[
= Motivierendes Beispiel
Test
]


#let width = 100%
#start-section-slide("Rauscharten")[
  = Weißes Rauschen
    #subfigure(columns: 3,
      figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width), caption: [weißes Rauschen]),<RauschartenWhite>,
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-0-sum.svg", width: width), caption: [Integral weißes Rauschen]) <RauschartenWhiteDev>],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg"), caption: [PSD weißes Rauschen]),
    )
]
#normal-slide[
  = Pinkes Rauschen
    #subfigure(columns: 3,
      [#figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width), caption: [pinkes Rauschen])<RauschartenPink>],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-1-sum.svg", width: width), caption: [Integral pinkes Rauschen]) <RauschartenPinkDev>],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg"), caption: [PSD pinkes Rauschen]),
    )
]
#normal-slide[
  = Braunes Rauschen
  #subfigure(columns: 3,
    [#figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width), caption: [braunes Rauschen])<RauschartenBrown>],
    [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-2-sum.svg", width: width), caption: [Integral braunes Rauschen]) <RauschartenBrownDev>],
    figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg"), caption: [PSD braunes Rauschen]),
  )
]
#start-section-slide("Verfahren")[
= Phasenrandomisierung
#only(2)[Ha]
Test
]

#normal-slide[
= Timmer-Koenig
#only(2)[Ha]
Test
]

#normal-slide[
= Fraktionale Differenzierung
#only(2)[Ha]
Test
]

#start-section-slide("Vergleich")[
= 2. Test 4
Test
]

#backup()

#normal-slide[
  #set align(horizon + center)
  #set text(size: 24pt)
  #v(-3cm)
  =
  *Vielen Dank für die Aufmerksamkeit!*
]

#normal-slide[
  = Quellen
  #bibliography("sliderefs.bib", full: true)
]