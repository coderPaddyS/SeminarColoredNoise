#import "@preview/polylux:0.4.0": *
#import "@preview/datify:1.0.0": custom-date-format

#let KITGreen = rgb(0,150,130)

// This is the counter used by polylux for the hidden slides
#let logical-slide-counter = counter("logical-slide")
#let section-slide-counter = state("section-slide-counter", ())

#let slide-circle-size = 3pt

#let new-section(name) = context {
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
      top-right: 0.5cm,
      bottom-left: 0.5cm
    ),
    fill: color,
    block(
    clip: true,
      radius: (
        top-right: 0.5cm,
        bottom-left: 0.5cm
      ),
      fill: white,
      body
    )
  )
}


#let normal-slide = body => slide[
  #align(horizon + start, body)
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
          section-ends.push(logical-slide-counter.final().last())
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
        ],
        [
          #set align(right)

          #image("logos/ISAS_logo.png")
          // #v(1.25em)
          #image("logos/IES_logo.png")
          // #v(1.25em)
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
