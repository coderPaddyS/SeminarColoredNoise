#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Rauscharten (von links nach rechts): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen erzeugt mit dem Phasenrandomisierung-Algorithmus.
        Oben das generierte Rauschsignal, in der Mitte das Integral über das Rauschsignal, also die summierte Abweichung über die Zeit, unten das PSD des Rauschsignals.
      ],
      figure(image("/plots/1000/Phasenrandomisierung-Done-0-noise.svg", width: width), caption: [weißes Rauschen]),<RauschartenWhite>,
      [#figure(image("/plots/1000/Phasenrandomisierung-Done-1-noise.svg", width: width), caption: [pinkes Rauschen])<RauschartenPink>],
      [#figure(image("/plots/1000/Phasenrandomisierung-Done-2-noise.svg", width: width), caption: [braunes Rauschen])<RauschartenBrown>],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-0-sum.svg", width: width), caption: [Integral weißes Rauschen]) <RauschartenWhiteDev>],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-1-sum.svg", width: width), caption: [Integral pinkes Rauschen]) <RauschartenPinkDev>],
      [#figure(image("/plots/1000/deviation/1d/Phasenrandomisierung-Done-2-sum.svg", width: width), caption: [Integral braunes Rauschen]) <RauschartenBrownDev>],
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-0-psd.svg"), caption: [PSD weißes Rauschen]),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-1-psd.svg"), caption: [PSD pinkes Rauschen]),
      figure(image(width: width, "/plots/1000/Phasenrandomisierung-Done-2-psd.svg"), caption: [PSD braunes Rauschen]),
      label: <AbbRauschartenPhasenrandomisierung>,
    )
]