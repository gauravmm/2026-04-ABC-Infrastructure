#import "@preview/tiaoma:0.3.0"
#import "@preview/touying:0.6.1": config-page, touying-fn-wrapper
#import "@preview/metropolyst:0.1.0": slide

#let half-page(lhs, rhs) = slide(
  config: config-page(header: none, margin: 0pt),
)[
  #grid(
    columns: (1.2fr, .8fr),
    align: (left + horizon, center + horizon),
    column-gutter: 1em,
    lhs,
    [
      #block(fill: rgb("#baa7af"), width: 100%, height: 100%, stack(
        place(horizon + center, rect(
          fill: tiling(
            size: (5.5cm, 6cm),
            image("../assets/bkg.svg", width: 5.5cm, height: 6cm),
          ),
          width: 100%,
          height: 200%,
        )),
        rhs,
      ))
    ],
  )
]


#let title-page() = touying-fn-wrapper((self: none) => {
  let info = self.info
  block(
    inset: (x: 1em, y: 2em),
    {
      text(size: 1.6em, weight: 700, info.title)
      v(0.4em)
      if info.at("subtitle", default: none) != none {
        text(size: 1.1em, fill: rgb("#555"), info.subtitle)
        v(0.8em)
      }
      if info.at("author", default: none) != none {
        text(size: 1em, info.author)
        linebreak()
      }
      if info.at("institution", default: none) != none {
        text(size: 0.9em, fill: rgb("#555"), info.institution)
        linebreak()
      }
      if info.at("date", default: none) != none {
        v(0.4em)
        text(size: 0.9em, fill: rgb("#555"), info.date)
      }
    },
  )
})
