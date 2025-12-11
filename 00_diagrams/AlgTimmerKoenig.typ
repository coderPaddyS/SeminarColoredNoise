#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Oben: Erzeugtes Rauschen des Timmer-Koenig-Algorithmus, Unten: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Reihe: $alpha = n - 1$.
      ],
      figure(image(width: width, "/plots/1000/Timmer-Koenig-0-noise.svg")),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-1-noise.svg")),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-2-noise.svg")),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-0-psd.svg")),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-1-psd.svg")),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-2-psd.svg")),
    )
]
