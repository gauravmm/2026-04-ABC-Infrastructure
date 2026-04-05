#import "@preview/touying:0.6.1": config-common, config-page, only, pause, uncover
#import "@preview/metropolyst:0.1.0": (
  alert, brands, config-info, focus-slide as _focus-slide, metropolyst-theme, slide, title-slide,
)
#import "@preview/cetz:0.4.2"
#import "@preview/dati-basati:0.1.0" as db
#import "@preview/tiaoma:0.3.0"

#let accent(body) = text(fill: rgb("#78334e"), body)
#let callout(body) = block(
  fill: rgb("#e8d0d8"),
  width: 100%,
  outset: (x: 8pt, y: 0pt),
  inset: (x: 0pt, y: 16pt),
  radius: 8pt,
)[#body]
#let shadow-image(path, ..args) = layout(avail => context {
  let img = image(path, ..args)
  let (width: w, height: h) = measure(img, width: avail.width)
  box(width: w, height: h, clip: false, stroke: 1pt + black)[
    #for (offset, opacity) in ((7pt, 5%), (5pt, 10%), (3pt, 15%), (1pt, 18%)) {
      place(dx: offset, dy: offset, rect(width: w, height: h, fill: rgb(0, 0, 0, opacity), stroke: none))
    }
    #place(top + left, img)
  ]
})

#show strong: it => text(weight: 700, it.body)

#let plain-focus-slide(align: horizon + center, body) = _focus-slide(
  align: align,
  config: config-page(
    fill: rgb("#baa7af"),
    background: block(
      width: 130%,
      height: 130%,
      fill: tiling(
        size: (5.5cm, 6cm),
        image("assets/bkg.svg", width: 5.5cm, height: 6cm),
      ),
    ),
  ),
  body,
)

#show: metropolyst-theme.with(
  font: ("Roboto",),
  accent-color: rgb("#78334e"),
  header-background-color: rgb("#542437"),
  focus-background-color: rgb("#542437"),
  focus-text-color: white,
  main-background-color: white,
  main-text-color: rgb("#333333"),
  progress-bar-background: rgb("#78334e"),
  config-info(
    title: [Infrastructure-based Safety For Your Claw],
    subtitle: [Agentic Builders' Collective],
    author: [Dr. Gaurav Manek],
    date: "2026-04-18",
    institution: [Ocellivision, A*STAR],
    logo: image("assets/icon-logo.svg", height: 1.5em),
  ),
)

// Title slide
#title-slide()

#slide(
  title: [Infrastructure-based Safety For Your Claw],
  composer: (1fr, 1fr),
)[
  - Two groups of attendees who want to meet *across groups*, not within groups.
  - In use at US universities for visit days, qualifier exams, and welcome courses
  - scales to hundreds of attendees, with:
    - hybrid in-person/remote attendance
    - individual requests
    - departmental policies
    - last-minute changes
][
  #shadow-image("images/meta_email.png", width: 100%)
]

== The data model

#slide(composer: (1fr, 1fr))[
  1. *Visitors*: one group of attendees, each with personal requests and constraints
  2. *Hosts*: another group of attendees, each with personal requests and constraints
  3. *Meetings*: the currently scheduled meetings between visitors and hosts
][
  // #include "figures/data-model.typ"
]

#plain-focus-slide[
  // #place(center + horizon, dy: 10pt, image("images/look away now.png", height: 160%))
]


#slide(
  config: config-page(
    header: none,
    background: box(width: 100%, height: 100%, clip: true)[
      #place(
        top + center,
        rect(),
        // image("images/conclusion.png", width: 100%, height: 100%, fit: "cover"),
      )
    ],
  ),
)[
  #grid(
    columns: (1.2fr, 0.8fr),
    align: (center, left),
    column-gutter: 2.5em,
    [
      *Cursed in theory.*

      *Excellent for the workload.*

      #v(1fr)
    ],
    [ #pause
      #align(center + horizon)[
        #box(fill: color.rgb("#fff"), inset: 1em, radius: .25em, stroke: 2pt + color.rgb("#444"))[
          #link("https://www.gauravmanek.com/lectures/2026/abc-infrastructure/")[
            #tiaoma.qrcode(
              "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
              options: (scale: 4.0),
              width: 8cm,
            )
          ]
          *Scan for more!*
        ]
      ]
    ],
  )
]
