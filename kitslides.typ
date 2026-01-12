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

#let backup() = context {
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


#let normal-slide = body => slide[
  #align(horizon + start, body)
]

#let start-section-slide(name, body) = normal-slide[
  #only(1, new-section(name))
  #body
]


#let KITSlides(
  title: "Title of Presentation",
  shortTitle: "Short Title",
  titleImage: "image.svg",
  author: ("First name", "Name", "F. N. Name"),
  supervisor: "Supervisor",
  
  date: datetime.today(),
  body
) = {

  set text(font: "Arial")

  set page(
    paper: "presentation-16-9", 
    margin: (left: 0.5cm, right: 0.5cm, bottom: 1.5cm, top: 1cm),
    header: context [
      #toolbox.next-heading(h => [
        #place(top + left, dy: 2cm)[
          #text(size: 24pt, [*#h*])
        ]
      ])
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
          let a = query(metadata)
          let indicators = section-slide-counter.final()
            .map(x => x.slide)
            .zip(section-ends)
            .map(((start, end)) => {
              range(start, end + 1).map(i => {
                let target = query(metadata.where(value: (slide: i)))
                let loc = if target.len() > 0 { target.first().location() } else { none }
                let fill = if i == current { black } else { none }

                if loc != none {
                    box[#link(loc)[#circle(radius: slide-circle-size, fill: fill)]]
                  } else {
                    box[some error]
                  }
              }).join([ ])
              }
            )
            .map(x => (x, []))
            .flatten()

          let section-titles = sections
            .map((x) => {
              let target = query(metadata.where(value: (section: x)))
              (link(target.first().location())[#x], [])
            }).flatten()
          let columns = range(section-titles.len()).map(i => if calc.rem(i, 2) == 0 {auto} else {1fr})

          place(left + bottom, dy: -0.5cm)[
              #grid(
                columns: columns,
                row-gutter: 0.5em, 
                ..section-titles, 
                ..indicators
              )
          ]
          line(length: 104%, start: (-2%, 0%), stroke: rgb("#d9d9d9"))

          place(left + bottom, dx: -0.5cm, dy: -0.35cm, float: true)[
            #metadata((slide: logical-slide-counter.get().first()))
            *#toolbox.slide-number / #toolbox.last-slide-number*
            #h(1cm) 
            #custom-date-format(date, pattern: "d. MM. yyyy")
            #h(1cm) 
            #author.at(0) #author.at(1): #shortTitle
          ]

          place(right)[
            #v(20%)
            #image("logos/kitlogo_de_rgb.pdf", height: 70%)
          ]
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

  slide[
    #block(width: 100%)[
      #grid(
        columns: (0.5cm, 4fr, 1fr),
        [],
        [
          #image("logos/kitlogo_de_rgb.pdf", width: 5cm)
          #set align(bottom)

          #text(size: 24pt)[*#title*] 

          *#author.at(0) #author.at(1)* | #custom-date-format(date, pattern: "d. MMMM yyyy", lang: "de") \
          Betreuer: #supervisor
          #v(-1em)
        ],
        [
          #set align(right)

          #image("logos/ISAS_logo.png")
          #v(1.25em)
          #image("logos/IES_logo.png")
          #v(1.25em)
          #image("logos/IOSB_logo.png")
        ]
      )
      #box(width: 100%)[
      ]
    ]
    #set align(bottom)
    #kitblock(color: color.gray)[
      #image("logos/banner_2020_kit.jpg", width: 100%)
    ]
  ]
  
  set page(
    margin: (left: 1cm, right: 1cm, bottom: 1.5cm, top: 3cm),
  )
  normal-slide[
    = Inhaltsverzeichnis

    #toolbox.all-sections((sections, current) => {
      enum(..sections)
    })
  ]

  body
}

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
    #set text(size: 15pt)
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