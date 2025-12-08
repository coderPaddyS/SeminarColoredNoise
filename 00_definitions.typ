#import "@preview/subpar:0.2.2"

#let default-figure = figure
#let subfigure = subpar.grid.with(
  numbering-sub: "a)",
  // supplement: "asdfasdf",
)

#let topcol(body) = {
  place(top, float: true, scope: "column", body)
}

#let topfull(body) = {
  place(top, float: true, scope: "parent", body)
}