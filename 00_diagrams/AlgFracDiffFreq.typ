#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Oben: Erzeugtes Rauschen der Fraktionale Differenzierung Algorithmen, Unten: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.
      ],
      figure(image(width: width, "/plots/1000/FracDiffFreq-0-noise.svg"),),
      figure(image(width: width, "/plots/1000/FracDiffFreq-1-noise.svg")),
      figure(image(width: width, "/plots/1000/FracDiffFreq-2-noise.svg")), <FDAlpha2>,
      figure(image(width: width, "/plots/1000/FracDiffFreq-0-psd.svg")),
      figure(image(width: width, "/plots/1000/FracDiffFreq-1-psd.svg")),
      figure(image(width: width, "/plots/1000/FracDiffFreq-2-psd.svg")), <FDAlpha2PSD>,
    )
]
