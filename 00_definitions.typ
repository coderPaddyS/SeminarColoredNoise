#import "@preview/subpar:0.2.2"

#let default-figure = figure
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

#let topcol(body) = {
  place(top, float: true, scope: "column", body)
}

#let topfull(body) = {
  place(top, float: true, scope: "parent", body)
}