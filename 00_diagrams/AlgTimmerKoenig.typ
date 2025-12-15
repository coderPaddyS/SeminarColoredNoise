#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Oben: Erzeugtes Rauschen des Timmer-Koenig-Algorithmus, Unten: Spektraleleistungsdichte des erzeugten Rauschens. $n$-te Spalte: $alpha = n - 1$.
      ],
      figure(image(width: width, "/plots/1000/Timmer-Koenig-0-noise.svg"), caption: [weißes Rauschen]),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-1-noise.svg"), caption: [pinkes Rauschen]),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-2-noise.svg"), caption: [braunes Rauschen]),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-0-psd.svg"), caption: [PSD weißes Rauschen]),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-1-psd.svg"), caption: [PSD pinkes Rauschen]),
      figure(image(width: width, "/plots/1000/Timmer-Koenig-2-psd.svg"), caption: [PSD braunes Rauschen]),
      label: <BildTimmerKoenig>,
    )
]
