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

== The Threat Model
/*
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
*/

== When Designing Infrastructure

#grid(
  columns: (1.5fr, auto, 1fr),
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
  While being _powerful enough_\
  for the task at hand.
]

== Example: Claude Gmail MCP

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


== Implementing Safety: MCP Gateway

#align(center)[
  #image("images/gateway.png", height: 100%)
]


== Implementing Safety: MCP Gateway
#slide(composer: (1fr, auto))[
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
][
  #image("images/gateway-middle.png", height: 100%)
]

== Implementing Safety

*Agents only communicate through auditable channels.*

- Agents coordinate through shared append-only channels.
- Humans can see the full conversation.
- Agents cannot rewrite the record.
- Suspicious behavior becomes observable early.

*Sandboxing and role separation*

Put agents in separate containers, VMs, repos, or workspaces.
Limit filesystem, network, and credential access by default.
Different agents get different scopes and tools.
No single agent should have end-to-end authority over critical flows.


*Immutable logs and provenance*

Record what the agent saw, decided, and did.
Make postmortems and accountability possible.



== Balls-to-the-wall Ideas

1. Named Entity Recognition (NER) Guardrails for Public Agents
  - Use NER to identify sensitive entities in the agent's actions, e.g. user names, project names, etc.
  - Ban mentioning entities in channels unless a human has previously explicitly allowed it.
  - This can prevent the agent from leaking sensitive information across different users or projects. (i.e. In a channel with Alice about Project X, any attempt by the agent to mention Bob or Project Y should be blocked.)

2. Context Firebreaks for Privileged Agents
  - Every memory item has "context tags" that indicates which category of information it belongs to, e.g. "customer X", "project Y", etc.
  - Agents can read any memory item, but when they do, the MCP keeps track of which tags have been accessed in the current session.
  - Agents can only write to memory/channels with the least privilege required to write to all of the tags.
    - Human approval is required to downgrade the privilege level of a memory item.
  - (Bell-LaPadula Model, if you are some kind of nerd like me.)

3. Cryptographic attestation of user intent.
  - Every user message and/or reaction is signed by the channel to prove that it was actually sent by a human, and not forged by the agent.
  - The agent must present this signed message to the MCP to perform a sensitive action (e.g. mentioning a new entity, downloading a webpage, etc.)


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
