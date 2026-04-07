#import "@preview/touying:0.6.1": config-common, config-page, meanwhile, only, pause, uncover, utils
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
    title: [Infrastructure-based Safety\ For Your 'Claw],
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
  #grid(rows: auto, gutter: 1em)[
    #box(fill: color.rgb("#fff"), inset: 1em, radius: .25em, stroke: 2pt + color.rgb("#444"), link(
      "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
    )[
      #tiaoma.qrcode(
        "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
        options: (scale: 4.0),
        width: 8cm,
      )
    ])
  ][
    *Slides and Code*
  ]
  #pause
  #place(center + horizon, dx: -30pt, dy: 0pt, scale(125%, origin: center + horizon)[
    #image("images/openclaw_sticker.png")
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
#slide()[
  #v(0.4fr)
  #align(center)[
    *"LLM accident" is not a diagnosis, its a thought-terminating cliché.*

    It is like writing "pilot error" in an air-crash report.
  ]

  #v(1fr)
  #line(length: 100%, stroke: .5pt)

  #grid(
    columns: (1fr, auto, auto, auto, 1fr),
    column-gutter: 1em,
  )[~][
    *Bad framing*

    - all blame to the operator
    - the fault was not foreseeable
    - no explanatory value

  ][
    #sym.arrow.r
  ][
    *Useful framing*

    - design defends against operator mistakes
    - failure modes are predictable
    - points to concrete safeguards
  ][~]

  #line(length: 100%, stroke: .5pt)
  #v(1fr)

  #pause
  #align(center)[
    We don't make humans perfect.

    #accent[
      *We design systems that stay safe when humans are imperfect.*
    ]
  ]
  #v(0.4fr)
]


== When Designing Infrastructure

#grid(
  columns: (1.3fr, auto, 1fr),
  column-gutter: 0.8em,
  align: (left, center),
)[
  1. Minimize the *blast radius* of a mistake.

  2. Make changes *reversible* where possible.

  3. Make everything *auditable*.

  4. Monitor the output with *guardrails*

  5. Separation of concerns via *isolation*.
][
  #pause
  #align(center + horizon)[
    #text(size: 1.2em)[
      $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
    ]
  ]
][
  Build a threat model with\ *OWASP's STRIDE* (or others)

  These are general principles for most agentic systems.

]
#pause
#v(1em)
While remaining _powerful enough_ to be useful.


== Example: Claude Gmail Connector

#align(left)[
  #image("images/claude-code-logo.svg", height: 1.5cm)
]
#v(1em)

#grid(
  columns: (1.5fr, auto, auto),
  column-gutter: 0.8em,
  align: (left, center),
)[
  - Can draft emails, but not send them.

  - Can delete emails, but not clear trash.

  - Doesn't run in the background, unless you schedule it.
][
  #pause
  #align(center + horizon)[
    #text(size: 1.2em)[
      $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
    ]
  ]
][
  *blast radius*

  *reversible*

  auditable

  guardrails

  isolation
]

== Example: Notion MCP (new)

#align(left)[
  #image("images/Notion_Logo_0.svg", height: 2cm)
]
#v(1em)

#grid(
  columns: (1.5fr, auto, auto),
  column-gutter: 0.8em,
  align: (left, center),
)[
  - Can edit pages in a project subtree, but not outside it.

  - Every change is logged with diff and actor identity.

  - All changes and deletions are reversible for up to 30 days.

  - Access within a workspace is not limited.

  - Updates to public pages are automatically shown to the world.
][
  #pause
  #align(center + horizon)[
    #text(size: 1.2em)[
      $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
    ]
  ]
][
  blast radius

  *reversible*

  *auditable*

  guardrails

  isolation
]

== Example: GitHub Copilot Agent

#align(left)[
  #image("images/GitHub_Copilot_Lockup_Black.svg", height: 1.5cm)
]
#v(1em)

#grid(
  columns: (1.5fr, auto, auto),
  column-gutter: 0.8em,
  align: (left, center),
)[
  - Can open PRs, but not push directly to `main`.

  - Every change is bundled as a commit and  reviewable as a diff.

  - CI and policy checks gate merges automatically.

  - Cannot access untrusted internet resources (without approval)
][
  #pause
  #align(center + horizon)[
    #text(size: 1.2em)[
      $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
    ]
  ]
][
  *blast radius*

  *reversible*

  *auditable*

  *guardrails*

  *isolation*
]


== Implementing Safety

#slide(title: [Implementing Safety])[
  #grid(columns: (1fr, auto, auto), align: horizon, gutter: 1em)[

    #grid(
      columns: (1fr, 1fr),
      rows: (1fr, 1fr), align: top + left,
      gutter: 1em,
    )[
      #uncover("1-")[
        *Constrain*
        - Sandboxing and isolation
          - Agents doing different tasks run in different environments.
        - Principle of least privilege
      ]
    ][
      #uncover("2-")[
        *Slow Down*
        - Draft-first workflows
          - Final approval from a human.
        - Rate limits and quotas
          - Prevent runaway behavior.
      ]
    ][
      #uncover("3-")[
        *Observe*
        - Audit logs agents can't touch
        - Agents communicate over human channels
      ]
    ][
      #uncover("4-")[
        *Recover*
        - Soft-delete and Rollback
          - Make recovery cheap.
          - Track user recoveries to debug your processes.
      ]
    ]
  ][
    #align(center + horizon)[
      #text(size: 1.2em)[
        $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
      ]
    ]
  ][
    *blast radius*

    *reversible*

    *auditable*

    *guardrails*

    *isolation*
  ]
]


== Implementing Safety: MCP Gateway

#align(center)[
  #image("images/gateway.png", height: 100%)
]


== Implementing Safety: MCP Gateway
#slide(composer: (auto, 1fr))[
  #image("images/gateway-middle.png", height: 100%)
][
  #v(1fr)
  An *MCP Gateway* sits between your 'Claw and the world, mediating access.

  1. Rate limits and damage caps
  2. Audit logs and alerting
  3. Fine-grained access control
  4. Rewrite destructive actions
  5. Content- and context-aware restrictions
  6. Delayed execution
  7. Credential hiding
  8. Honeypot/Canary actions


  #v(1fr)
  _Check out `gauravmm/mcp_gateway_maker` for code + skills!_
]


== Balls-to-the-wall Ideas
#slide(composer: (1fr, auto))[
  1. *Named Entity Recognition (NER) Guardrails*
    - Use NER to identify sensitive entities in output
      - e.g. user names, project names.
    - Ban mentioning entities in channels unless a human has previously explicitly allowed it.
    - Prevent the agent from leaking sensitive information across different users or projects.

  #pause
  2. *Cryptographic attestation of user intent*
    - Every user message and/or reaction is signed by the channel to prove that it was actually sent by a human.
    - The agent presents this signed message to the tool to authorize a sensitive action (e.g. mentioning a new entity, sending an email, etc.)

][
  #meanwhile
  #image("images/crazy-ideas.png", height: 100%)
]


== Balls-to-the-wall Ideas
#slide(composer: (1fr, auto))[
  #v(1fr)
  3. *Context Firebreaks for Privileged Agents*
    - Every source has _context tags_.
    - Agents can read anything, but the tags are monitored.
    - Agents can only write to places with the least privilege required to write to *all* of the tags.
      - Only humans can downgrade the privilege level of information.
  #v(1fr)
  #text(size: 14pt)[Based on the Bell-LaPadula Model, if you are some kind of nerd.]
][
  #image("images/crazy-ideas.png", height: 100%)
]



#half-page[
  #v(2em)
  #text(size: 1.6em, weight: 700)[
    Infrastructure-based Safety For Your 'Claw
  ]

  #v(1fr)

  #align(center)[
    #grid(
      columns: (auto, auto, auto),
      rows: (auto, auto),
      align: horizon,
      gutter: 1em,
    )[*Do this*][][*For this*][
      Constrain\
      Slow Down\
      Observe\
      Recover
    ][
      #align(center + horizon)[
        #text(size: .65em)[
          $mat(delim: #(none, "}"), row-gap: #2em, ; ; ; ;)$
        ]
      ]
    ][
      blast radius\
      reversible\
      auditable\
      guardrails\
      isolation\
    ]
  ]
  #v(1fr)
  #align(center)[
    *Using this*\
    #link("https://github.com/gauravmm/mcp_gateway_maker")[
      #box(
        fill: color.rgb("#fff"),
        inset: (x: 1em, y: 0.8em),
        radius: .35em,
        stroke: 2pt + color.rgb("#444"),
      )[
        #grid(
          columns: (auto, auto),
          column-gutter: 0.9em,
          align: (center, horizon),
        )[
          #image("assets/github.svg", width: 1.5cm)
        ][
          #align(left)[
            #text(size: 0.9em, weight: 700, fill: black)[gauravmm /]
            #linebreak()
            #text(size: 1.05em, fill: black)[mcp_gateway_maker]
          ]
        ]
      ]
    ]
  ]
  #v(2em)
][
  #grid(rows: auto, gutter: 1em)[
    #box(fill: color.rgb("#fff"), inset: 1em, radius: .25em, stroke: 2pt + color.rgb("#444"), link(
      "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
    )[
      #tiaoma.qrcode(
        "https://www.gauravmanek.com/lectures/2026/abc-infrastructure/",
        options: (scale: 4.0),
        width: 8cm,
      )
    ])
  ][
    *Slides and Code*
  ]
]

= Appendix

== BenchClaw's Safety Model

1. *NO ACCESS TO ITS OWN CODE.*
  - Good grief, this is a no-brainer.
  - Why would you even consider giving an agent access to its own code?

2. *Separate 'Claws: Public, Quality, PM.*
  - Running in different docker containers.
  - Use the same codebase, but different config.

2. *Knowledgebase on Notion*
  - RBAC (Role-Based Access Control)
  - Reversible, auditable changes (all changes can be reverted within 30 days.)

3. *Claw #sym.arrow.l.r Claw communication*
  - Via a "mailbox" page on Notion.
  - Auditable!

== BenchClaw's Safety Model (contd.)

4. *Least Privilege*
  - *PM Claw* claw can access Hive (PM software).
    - Checks if a Hive action includes any users outside of Ocellivision.
    - Destructive tools (e.g. deleting a project) are removed or softened.
      - e.g. Deleting an action that is older than 1 day flags it and hides it.
    - Can read QA page titles, but not their content.

  - *Quality Claw* can access QA page contents
    - can only read documents for the current phase of work.
    - can only write fresh documents until a human has reviews them.
    - has no access to the internet at large.

  - *Public Claw* can only access intern pages.
    - used by interns and for testing new tools.

== The LLM Threat Model

#slide(composer: (1fr, 1fr))[
  - *Sampling artifacts*:
    - Hallucinations
    - Brittle behavior from small prompt changes
    - Non-determinism

  - *Theory of mind failures*:
    - Interpreting instructions without modeling intent
    - Poor awareness of hidden context or unstated constraints
    - Overconfidence in incorrect outputs
    - Credulity or gullibility

    #v(1fr)
][
  - *Reward hacking*:
    - Goal drift
    - Difficulty stopping or asking for help
    - Context-window loss: forgetting earlier instructions or decisions

  - *Context Limits*
    - Context rot and context anxiety
    - Can't process large or complex inputs
    - Difficulty maintaining long-term plans

  #v(1fr)
  #callout()[
    #align(center)[
      *Predictable* failures are\
      failures we can *mitigate*.
    ]
  ]
]
