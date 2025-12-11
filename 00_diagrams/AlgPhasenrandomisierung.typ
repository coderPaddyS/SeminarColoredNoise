#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Oben: Erzeugtes Rauschen des Phasenrandomisierung-Algorithmus, Unten: Spektralenleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.
      ],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-noise.svg")),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-noise.svg")),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-noise.svg")),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg")),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg")),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg")),
      label: <BildPhasenrandomisierung>
    )
]
