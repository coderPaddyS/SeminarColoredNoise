#import "@preview/polylux:0.4.0": slide as polylux-slide
#import "@preview/polylux:0.4.0": *
#import "@preview/datify:1.0.0": custom-date-format

// This is the counter used by polylux for the hidden slides
#let logical-slide-counter = counter("logical-slide")
#let section-slide-counter = state("section-slide-counter", ())
#let backup-state = state("backup-section", none)

#let slide-circle-size = 3pt

#let _kit-outer-margin = 3mm
#let _kit-inner-margin = 11mm
#let _kit-top-margin = 10mm
#let _kit-bottom-margin = 11mm

#let kit-green = rgb(0, 150, 130)
#let kit-blue = rgb(70, 100, 170)
#let green = kit-green
#let blue = kit-blue
#let black70 = rgb(64, 64, 64)
#let brown = rgb(167, 130, 46)
#let purple = rgb(163, 16, 124)
#let cyan = rgb(35, 161, 224)
#let lime = rgb(140, 182, 60)
#let yellow = rgb(252, 229, 0)
#let orange = rgb(223, 155, 27)
#let red = rgb(162, 34, 35)

#let navigation-active-color = black
#let navigation-inactive-color = rgb(0,0,0).lighten(50%)

#let kit-rounded-block(radius: 3mm, body) = {
  block(
    radius: (
      top-right: radius,
      bottom-left: radius,
    ),
    clip: true,
    body,
  )
}

#let kit-bullet-point = {
  v(0.5mm)
  kit-rounded-block(radius: 1mm)[
    #align(horizon)[
      #block(fill: kit-green, inset: 1.5mm)
    ]
  ]
}

#let backup() = context {
  pagebreak(weak: true)
  backup-state.update(logical-slide-counter.get().at(0))
}

#let new-section(name) = context {
  if backup-state.get() != none {
    return
  }
  let new = (slide: logical-slide-counter.get().at(0), section: name, end: -1)
  if section-slide-counter.get().len() != 0 {
    let last = section-slide-counter.get().last()
    last.end = logical-slide-counter.get().at(0) - 1
    section-slide-counter.update(sections => {
      sections.pop()
      sections.push(last)
      sections.push(new)
      return sections
    })
  } else {
    section-slide-counter.update((new,))
  }
  toolbox.register-section(name)
  metadata((section: name))
}

#let kitblock(color: black, body) = {
  block(
    inset: 1pt,
    radius: (
      top-right: 0.6cm,
      bottom-left: 0.6cm
    ),
    fill: color,
    block(
    clip: true,
      radius: (
        top-right: 0.6cm,
        bottom-left: 0.6cm
      ),
      fill: white,
      body
    )
  )
}


#let slide(body, alignment: horizon + start) = polylux-slide[
  #if alignment == top or alignment == top + center or alignment == top + left or alignment == top + right or alignment == top + start or alignment == top + end {
    v(1cm)
  }
    #context metadata((slide: logical-slide-counter.get().first()))
    #align(alignment)[
      #set text(18pt)
      #body
    ]
  ]

#let start-section-slide(body, name: none, ..args ) = {
  slide([
    #only(1, new-section(name))
    #body
  ], ..args)
}


#let KITSlides(
  title: "Title of Presentation",
  shortTitle: "Short Title",
  titleImage: "image.svg",
  author: ("First name", "Name", "F. N. Name"),
  supervisor: "Supervisor",
  
  date: datetime.today(),
  body
) = {

  set text(font: "Arial", lang: "de", size: 16pt)

  set figure(supplement: none)

  set page(
    paper: "presentation-16-9", 
    margin: (left: 0.5cm, right: 0.5cm, bottom: 1.5cm, top: 1cm),
    header: context [
      #toolbox.next-heading(h => [
        #place(top + left, dy: 2cm)[
          #text(size: 24pt, [*#h*])
        ]
      ])
      #v(1em)
    ],
    footer: context [

        // So on any other slide
        // TODO: Add other slides as exception
        #if (here().page() != 1) {
          // Groups the slides into the respective sections

          let sections = section-slide-counter.final().map(x => x.section)

          let section-ends = section-slide-counter.final()
              .map(x => x.end)
              .slice(0, -1)
          if backup-state.final() == none {
            section-ends.push(logical-slide-counter.final().last())
          } else {
            section-ends.push(backup-state.final())
          }
          let current = logical-slide-counter.get().first()

          let indicators = section-slide-counter.final()
            .map(x => x.slide)
            .zip(section-ends)
            .map(((start, end)) => {
              let color = if start <= current and current <= end and backup-state.get() == none { navigation-active-color } else { navigation-inactive-color }
              range(start, end + 1).map(i => {
                let target = query(metadata.where(value: (slide: i)))
                let loc = if target.len() > 0 { target.first().location() } else { none }
                let fill = if i == current { color } else { none }

                if loc != none {
                    box[#link(loc)[#circle(radius: slide-circle-size, fill: fill, stroke: color)]]
                  } else {
                    box[some error]
                  }
              }).join([ ])
              }
            )
            .intersperse([])

          let section-titles = sections
            .map((x) => {
              let color = if section-slide-counter.get().len() != 0 and section-slide-counter.get().last().section == x and backup-state.get() == none { navigation-active-color } else { navigation-inactive-color }
              let target = query(metadata.where(value: (section: x)))
              link(target.first().location())[#text(color, x)]
            })
            .intersperse([])
          let columns = range(section-titles.len()).map(i => if calc.rem(i, 2) == 0 {auto} else {1fr})

          let last-slide = if backup-state.final() != none { backup-state.final() } else { toolbox.last-slide-number }

          
          block(inset: (left: -5mm, right: -5mm, top: -1.25cm), {
            set align(horizon)
            grid(
              columns: (auto, 1cm, auto, 1cm, auto, 1fr, auto),
              rows: (1cm, 3mm, 1cm),
              grid.cell(colspan: 7)[
                #grid(
                  columns: columns,
                  row-gutter: 0.5em, 
                  ..section-titles, 
                  // ..indicators
                )
              ],
              grid.cell(colspan: 7)[
              #line(length: 100%, stroke: rgb("#d9d9d9"))
              ],
              [*#toolbox.slide-number / #last-slide*],
              [],
              [#custom-date-format(date, pattern: "dd.MM.yyyy")],
              [],
              [#author.at(0) #author.at(1): #shortTitle],
              [],
              [#image("logos/kitlogo_de_rgb.pdf", height: 70%)]
            )
          })
        } else {
          place(left + bottom, dy: -0.35cm)[
            KIT – Die Forschungsuniversität in der Helmholtz-Gemeinschaft 
          ]

          place(right)[
            #v(25%)
            #link("https://www.kit.edu")[*#text(size: 20pt)[www.kit.edu]*]
          ]
        }
    ]
  )
  show heading.where(level: 1): none
  polylux-slide[
    #block(width: 100%)[
      #grid(
        columns: (0.5cm, 4fr, 1fr),
        [],
        [
          #image("logos/kitlogo_de_rgb.pdf", width: 5cm)
          #set align(bottom)
          #v(-0.6cm)

          #text(size: 24pt)[*#title*] 

          *#author.at(0) #author.at(1)* | #custom-date-format(date, pattern: "d. MMMM yyyy", lang: "de") \
          Betreuer: #supervisor
        ],
        [
          #set align(right)

          #image("logos/ISAS_logo.png")
          #v(0.7em)
          #image("logos/IES_logo.png")
          #v(0.7em)
          #image("logos/IOSB_logo.png")
        ]
      )    ]
    #v(-0.6cm)
    #set align(bottom)
    #kitblock(color: color.gray)[
      #image("logos/banner_2020_kit.jpg", width: 100%)
    ]
  ]
  
  set page(
    margin: (left: 1cm, right: 1cm, bottom: 1.5cm, top: 3cm),
  )

  set list(marker: kit-bullet-point)
  slide[
    #show grid.cell: set text(size: 20pt)
    = Inhaltsverzeichnis

    #toolbox.all-sections((sections, current) => {
      let entries = sections.enumerate()
        // .map(((index,section)) => [#text(size: 16pt)[#{index + 1}. #section]])
        .map(((index,section)) => [#{index + 1}. #section])
        .map(x => (x, []))
        .flatten()
      let columns = entries.map((_) => 0.5fr)

      set text(fill: kit-blue, weight: "bold", size: 16pt)

      grid(columns: 1, rows: (1fr, ..columns, 1fr), [], ..entries)
    })
  ]

  body
}

#let kit-color-block(title: [], color: [], body) = {
  // 80% is a rough heuristic, that produces the correct result for all predefined colors.
  // Might be adjusted in the future
  let title-color = if luma(color).components().at(0) >= 80% {
    black
  } else {
    white
  }
  kit-rounded-block()[
    #block(
      width: 100%,
      inset: (x: 0.5em, top: 0.3em, bottom: 0.4em),
      fill: gradient.linear(
        (color, 0%),
        (color, 87%),
        (color.lighten(85%), 100%),
        dir: ttb,
      ),
      text(fill: title-color, title),
    )
    #block(
      inset: 0.5em,
      above: 0pt,
      fill: color.lighten(85%),
      width: 100%,
      body,
    )
  ]
}

#let kit-info-block(title: [], body) = {
  kit-color-block(title: title, color: kit-green, body)
}

#let kit-example-block(title: [], body) = {
  kit-color-block(title: title, color: kit-blue, body)
}

#let kit-alert-block(title: [], body) = {
  kit-color-block(title: title, color: red.lighten(10%), body)
}

#let definition(name: [], body) = kit-info-block(title: name, body)

#let reveal-item(start: 0, body) = {
  let items = body.children.filter(x => x != [ ])

  for (index, item) in items.enumerate() {
    only(str(start + index + 1) + "-", [#item])
  }
}