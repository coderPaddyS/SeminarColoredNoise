#import "/00_definitions.typ": *

#topfull[
  #let width = 75%;
    #subfigure(columns: 3,
      caption: [
        Rauscharten (von links nach rechts): Weißes Rauschen, Pinkes Rauschen, Braunes Rauschen.
        Oben das generierte Rauschsignal, unten das Integral über das Rauschsignal, also die summierte Abweichung über die Zeit.
      ],
      figure(image("/plots/1000/timeseries_done-0-noise.svg", width: width), caption: []),<RauschartenWhite>,
      [#figure(image("/plots/1000/timeseries_done-1-noise.svg", width: width), caption: [])<RauschartenPink>],
      [#figure(image("/plots/1000/timeseries_done-2-noise.svg", width: width), caption: [])<RauschartenBrown>],
      [#figure(image("/plots/1000/deviation/1d/timeseries_done-0-sum.svg", width: width), caption: []) <RauschartenWhiteDev>],
      [#figure(image("/plots/1000/deviation/1d/timeseries_done-1-sum.svg", width: width), caption: []) <RauschartenPinkDev>],
      [#figure(image("/plots/1000/deviation/1d/timeseries_done-2-sum.svg", width: width), caption: []) <RauschartenBrownDev>],
    )<AbbRauscharten>
]