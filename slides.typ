#import "@preview/touying:0.6.1": config-common, config-page, only, pause, uncover, utils
#import "@preview/metropolyst:0.1.0": (
  alert, brands, config-info, focus-slide as _focus-slide, metropolyst-theme, slide, title-slide,
)
#import "@preview/cetz:0.4.2"
#import "@preview/dati-basati:0.1.0" as db
#import "@preview/tiaoma:0.3.0"
#import "figures/half-page.typ": half-page, title-page


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
    title: [Infrastructure-based Safety\ For Your Claw],
    subtitle: [Agentic Builders' Collective],
    author: [Dr. Gaurav Manek],
    date: "2026-04-18",
    institution: [Ocellivision, A*STAR],
    logo: image("assets/icon-logo.svg", height: 1.5em),
  ),
)



#half-page[
  #title-page()
][
  #box(fill: color.rgb("#fff"), inset: 1em, radius: .25em, stroke: 2pt + color.rgb("#444"), link(
    "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
  )[
    #tiaoma.qrcode("https://www.gauravmanek.com/lectures/2026/abc-infrastructure/", options: (scale: 4.0), width: 8cm)
  ])
]




#slide(
  title: [Infrastructure-based Safety For Your Claw],
  composer: (1fr, 1.5fr),
  config: config-page(margin: (right: 0pt, bottom: 0pt)),
)[
  #v(1fr)
  *Meta's director of AI alignment lost her emails.*
  #v(1fr)
  _I had to run to my Mac mini like I was defusing a bomb._

  #align(right)[
    -- Summer Yue
  ]
  #v(1fr)
][
  #image("images/meta_email.png", height: 110%)
]


#slide(
  title: [Infrastructure-based Safety For Your Claw],
  composer: (1fr, 1.5fr),
  config: config-page(margin: (right: 0pt, bottom: 0pt)),
)[
  #v(1fr)
  CRITICAL severity issue, but marked as "wontfix".

  *There are plenty of these traps hiding in OpenClaw.*
  #v(1fr)

  _The boundary between "helpful agent" and "accidentally self-destructing" is
  dangerously thin._
  #align(right)[
    -- From the issue.
  ]

  #v(1fr)
][
  #image("images/wontfix.png", height: 100%)
]


#slide(
  title: [Infrastructure-based Safety For Your Claw],
  composer: (1fr, 1fr),
)[
  #v(1fr)
  #image("images/delete.png", width: 100%)
  #v(1fr)

  Claude deleted a 202GB partition.

  _At least the apology was good._
][
  #v(1fr)
  #image("images/replit.png", width: 100%)
  #v(1fr)

  Replit wiped the entire production db of SaaStr.AI.
]

== The Problem

"Pilot Error" is not a good terminal diagnosis for airplane accidents.

== The Paradigm

*The good news: We already know how to deal with this.*

Identity and access management (IAM)

role-based access control (RBAC)
attribute-based access control (ABAC),
and other security paradigms have been developed over decades to manage the risks of human error and malicious actors in complex systems.

IAM, RBAC, ABAC, etc. are all about designing infrastructure to be safe against human mistakes and malicious actors.

#slide[
  #grid(
    columns: (1fr, 1fr), rows: (auto, 1fr), align: (_, y) => if y > 0 { top } else { bottom }, gutter: 1em
  )[
    *What is your threat model?*
  ][
    *What is the blast radius?*
  ][
    A
  ][
    B
  ]
]

== When Designing Infrastructure

1. Minimize the blast radius of a mistake.
2. Make changes reversible where possible.
3. Make actions auditable.
4. Guardrails!
  - "If you want to do X, you must first do Y."
5. Separate responsibilities.
  - Principle of least privilege.
6. You can't audit the Claw, you can audit the channel.


Prefer safety features that are "agent-agnostic", i.e. they don't rely on the agent's internal state or reasoning, but rather on observable actions and their consequences.

General principle: If you can't make it safe, make it easy to recover from mistakes.


== Security vs Capability Tradeoff

Security in the general case is a hard problem.

Any infrastructure must reduce the capabilities of the system to achieve security.


== BenchClaw's Safety Model

1. NO ACCESS TO ITS OWN CODE.
  - Good grief, this is a no-brainer. Why would you even consider giving an agent access to its own code? It's like giving a toddler a box of matches and saying "Don't burn the house down, okay?"
2. Separate 'Claws: Public, Quality, PM.
  - Running in different docker containers.
  - Inside each claw, each session is also sandboxed.
  - Use the same codebase, but different config.
2. Notion:
  - Separate access control (Each claw has read-write and read-only access to specific subtrees.)
  - Reversible, auditable changes (all changes are logged for 30 days and can be reverted.)
3. Claw -> Claw communication is mediated by a "mailbox" page.
  - Quality -> PM: "The evaluation is complete."
  - Auditable!
4. PM Claw
  - Only claw that can access Hive (PM software).
    - Only has non-destructive access to Hive, and all changes are logged by the MCP.
    - MCP checks if a Hive action includes any users outside of Ocellivision. If so, the action is written as a comment instead of executed. (TODO)
    - More destructive tools (e.g. deleting a project) are removed from the MCP.
      - e.g. Deleting an action that is older than 1 day instead just flags it as :trash can emoji:, and hides it from the MCP.
  - has no access to the internet.


== Ideas for Safety Features

1. MCP Gateway
  - A proxy that sits between the PM Claw and Hive, and mediates all access.
  - Can enforce additional specific guardrails, e.g. rate limiting, content filtering, etc.
  - Plug https://github.com/gauravmm/mcp_gateway_maker; it makes generating new gateways really easy.

2. Honeypot/Canary Actions and Tokens
  - Actions that are designed to be "traps" for the agent, e.g. "delete all actions", "delete all projects", etc.
  - If the agent tries to execute these actions, it is a strong signal that something is wrong.
  - These actions can trigger a shutdown of the agent and alert the human operators.

3. Named Entity Recognition (NER) Guardrails
  - Use NER to identify sensitive entities in the agent's actions, e.g. user names, project names, etc.
  - Ban mentioning entities in channels unless a human has previously explicitly allowed it.
  - This can prevent the agent from leaking sensitive information across different users or projects. (i.e. In a channel with Alice about Project X, any attempt by the agent to mention Bob or Project Y should be blocked.)

4. Context Firebreaks for Privileged Agents
  - Every memory item has a "context tag" that indicates which some category of information it belongs to, e.g. "customer X", "project Y", etc.
  - Agents can read any memory item, but when they do, the MCP keeps track of which context tags have been accessed in the current session.
  - Agents can only write to memory items with the least privilege required to write to all of the tags.
    - Human approval is required to downgrade the privilege level of a memory item.
  - (Bell-LaPadula Model, if you are some kind of nerd like me.)


4. Rate Limits and Damage Caps
  - Put hard caps on how much the agent can do in a time window.
  - e.g. no more than 5 messages, 20 edits, or 1 project-wide mutation per hour.
  - Prevents fast cascades when something goes wrong.



#plain-focus-slide[
  // #place(center + horizon, dy: 10pt, image("images/look away now.png", height: 160%))
]


#half-page[][
  #box(fill: color.rgb("#fff"), inset: 1em, radius: .25em, stroke: 2pt + color.rgb("#444"), link(
    "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
  )[
    #tiaoma.qrcode("https://www.gauravmanek.com/lectures/2026/abc-infrastructure/", options: (scale: 4.0), width: 8cm)
  ])
]

