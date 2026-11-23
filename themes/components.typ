// Components of the YSU defense theme. Letters in the comments are the
// component codes of the defense deck (ysu-defense-modern.sty).
//
// Rules of the deck: at most three groups of semantic red and at most three
// frame groups per page; the conclusion bar (C) and the red-framed sentence
// (H) exclude each other.

#import "tokens.typ": *

#let _two(n) = if n < 10 { "0" + str(n) } else { str(n) }

// Page margin that full-width bars bleed into.
#let _bleed = 1cm

/// Two blocks side by side with the same height: `left(h)` gets the height
/// of the taller one. Used by label rows, side cards and the paper box.
#let _equal-row(left-width, gap, left, right-body, min-height: 0pt) = layout(size => {
  let rw = size.width - left-width - gap
  let h = calc.max(measure(block(width: rw, right-body)).height, min-height)
  grid(
    columns: (left-width, rw),
    column-gutter: gap,
    left(h), block(width: rw, height: h, right-body),
  )
})

// ---------------------------------------------------------------------------
// Emphasis and tags
// ---------------------------------------------------------------------------

/// Highlighted term: navy bold, kept on one line (原稿 \ysuHL). On navy
/// grounds it turns white.
#let hl(body) = box(strong(body))

/// Key conclusion: red bold, at most one per page (原稿 \ysuKey).
#let key(body) = box(strong(text(fill: ysu-red, body)))

/// F: tag. `kind`: "red" (limit or problem), "navy" or "line" (white outline
/// on navy).
#let tag(kind: "navy", size: 8pt, body) = {
  let (fill, stroke, fg) = if kind == "red" {
    (mix(ysu-red, 10%), none, ysu-red)
  } else if kind == "line" { (none, 0.6pt + white, white) } else {
    (mix(ysu-navy, 12%), none, ysu-navy)
  }
  box(fill: fill, stroke: stroke, radius: 2pt, inset: (x: 4pt, y: 1.5pt), text(
    size: size,
    weight: "bold",
    fill: fg,
    body,
  ))
}

/// Tiered badge: "outline" (white ground + hairline), "soft" (tinted ground
/// + hairline), or "solid" (filled ground, white text); `tone` in "navy" |
/// "red" | "muted". Complements `tag` without altering its defaults.
#let badge(
  variant: "soft",
  tone: "navy",
  height: 12pt,
  width: auto,
  size: 7.5pt,
  inset: (x: 5pt),
  weight: auto,
  body,
) = {
  let (fill, stroke, fg, wt) = if variant == "solid" {
    let c = if tone == "red" { ysu-red } else if tone == "muted" { ysu-muted } else { ysu-navy }
    (c, ysu-border + c, white, "bold")
  } else if variant == "outline" {
    if tone == "red" {
      (white, ysu-border + ysu-red-border, ysu-red, "bold")
    } else if tone == "muted" {
      (white, 0.45pt + ysu-line, ysu-muted, "bold")
    } else {
      (white, ysu-border + mix(ysu-navy, 38%), ysu-navy, "bold")
    }
  } else {
    if tone == "red" {
      (ysu-red-soft, ysu-border + ysu-red-border, ysu-red, "bold")
    } else if tone == "muted" {
      (ysu-tint, 0.45pt + ysu-line, ysu-muted, "medium")
    } else {
      (mix(ysu-navy, 13%), 0.55pt + mix(ysu-navy, 45%), ysu-navy, "bold")
    }
  }
  let final-weight = if weight == auto { wt } else { weight }
  let label = text(size: size, weight: final-weight, fill: fg, body)
  let inner = if width == auto and height == auto { label } else { std.align(center + horizon, label) }
  box(
    width: width,
    height: height,
    fill: fill,
    stroke: stroke,
    radius: ysu-radius-sm,
    inset: inset,
    inner,
  )
}

/// White outline capsule on navy grounds.
#let pill(body) = box(stroke: 0.6pt + white, radius: 0.2cm, inset: (x: 6pt, y: 2pt), text(
  size: 8pt,
  weight: "bold",
  fill: white,
  body,
))

/// Navy capsule with white bold text (cover speaker, tab titles).
#let tab-pill(body) = box(fill: ysu-navy, radius: 0.18cm, inset: (x: 16pt, y: 4.5pt), text(
  weight: "bold",
  fill: white,
  body,
))

/// Navy label with white text, for box edges and row heads.
#let edge-label(red: false, body) = box(
  fill: if red { ysu-red } else { ysu-navy },
  radius: 2pt,
  inset: (x: 5pt, y: 2pt),
  text(size: 9pt, weight: "bold", fill: white, body),
)

/// Navy disc with a white icon. `icon` is any content (an icon font glyph,
/// a symbol, or text).
#let icon-disc(size: 0.42cm, fill: ysu-navy, icon) = box(
  circle(radius: size / 2, fill: fill, inset: 0pt, std.align(center + horizon, text(
    size: 7.5pt * (size / 0.42cm),
    fill: white,
    icon,
  ))),
)

// ---------------------------------------------------------------------------
// Bars
// ---------------------------------------------------------------------------

/// C: conclusion bar at the page bottom, navy gradient ground, white text.
/// A full-width bar bleeds to both page edges.
#let conclude(label: none, red-label: none, pill: none, bleed: true, body) = block(
  width: 100%,
  fill: grad-bar,
  outset: if bleed { (x: _bleed) } else { 0pt },
  radius: if bleed { 0pt } else { 2pt },
  inset: (x: if bleed { 0pt } else { 6pt }, y: 5pt),
  {
    set text(size: 10pt, fill: white)
    show strong: set text(fill: white)
    let head = if red-label != none { tag(kind: "red", size: 10pt, red-label) } else if label != none {
      tag(kind: "line", size: 10pt, label)
    }
    let tail = if pill != none {
      box(stroke: 0.6pt + white, radius: 0.2cm, inset: (x: 6pt, y: 2pt), text(size: 8pt, weight: "bold", pill))
    }
    grid(columns: (auto, 1fr, auto), column-gutter: 0.5em, align: horizon, head, body, tail)
  },
)

/// J: base bar. Full width, tint ground, navy rules on its top and bottom
/// edges, 11 pt bold navy text in the centre.
#let base-bar(bleed: true, body) = block(
  width: 100%,
  height: auto,
  fill: ysu-tint,
  stroke: (top: 1pt + ysu-navy, bottom: 1pt + ysu-navy, x: if bleed { none } else { 1pt + ysu-navy }),
  outset: if bleed { (x: _bleed) } else { 0pt },
  inset: (y: 0.12cm),
  std.align(center, text(size: 11pt, weight: "bold", fill: ysu-navy, body)),
)

/// N: section bar. Navy disc with a white icon, the name, then a hairline.
#let section-bar(icon: none, body) = grid(
  columns: if icon != none { (auto, auto, 1fr) } else { (auto, 1fr) },
  column-gutter: 5pt,
  align: horizon,
  ..if icon != none { (icon-disc(icon),) },
  text(size: 11pt, weight: "bold", fill: ysu-navy, body),
  line(length: 100%, stroke: 0.6pt + ysu-line),
)

// ---------------------------------------------------------------------------
// Boxes
// ---------------------------------------------------------------------------

/// T: title box. Gradient header with a white title (optional icon and a
/// right-hand `aside`, such as "第 3 章"), tint body, navy!35 border.
#let title-box(
  icon: none,
  title: none,
  aside: none,
  width: 100%,
  height: auto,
  body-size: 10pt,
  body,
) = {
  let head-h = 0.6cm
  block(
    width: width,
    height: height,
    radius: 3pt,
    clip: true,
    stroke: 0.6pt + mix(ysu-navy, 35%),
    fill: ysu-tint,
    {
      block(width: 100%, height: head-h, fill: grad-head, inset: (x: 6pt), spacing: 0pt, std.align(
        horizon,
        grid(
          columns: (1fr, auto),
          text(size: 10pt, weight: "bold", fill: white, {
            if icon != none { icon; h(0.5em) }
            title
          }),
          if aside != none { text(size: 9pt, fill: white, aside) },
        ),
      ))
      block(
        width: 100%,
        height: if type(height) == length { height - head-h } else { auto },
        inset: (x: 7pt, top: 0.3cm, bottom: 0.28cm),
        spacing: 0pt,
        text(size: body-size, body),
      )
    },
  )
}

/// Classic name of the title box.
#let tblock(title: none, body) = title-box(title: title, body)

/// P: group box. Navy!6 ground, navy!45 border; the label sits on the top
/// border (`red: true` sets it in red). Holds 2 to 4 sub-boxes.
#let group-box(label: none, red: false, body) = {
  let pad-top = if label == none { 6pt } else { 12pt }
  block(
    width: 100%,
    fill: mix(ysu-navy, 6%),
    stroke: 0.8pt + mix(ysu-navy, 45%),
    radius: 6pt,
    inset: (x: 7pt, top: pad-top, bottom: 6pt),
    {
      if label != none {
        let l = edge-label(red: red, label)
        context {
          let h = measure(l).height
          place(top + left, dx: 1pt, dy: -pad-top - h / 2, l)
        }
      }
      body
    },
  )
}

/// White sub-box inside a group box.
#let sub-box(body) = block(
  width: 100%,
  fill: white,
  stroke: 0.5pt + ysu-line,
  radius: 3pt,
  inset: (x: 5.5pt, y: 4pt),
  body,
)

/// Q: dashed sub-box.
#let dash-box(body) = block(
  width: 100%,
  fill: white,
  stroke: (paint: mix(ysu-navy, 55%), thickness: 0.6pt, dash: (2pt, 1.5pt)),
  radius: 3pt,
  inset: (x: 5.5pt, y: 4pt),
  body,
)

/// K: label row. A navy label block (2 to 4 characters) beside a sub-box of
/// the same height.
#let label-row(label: none, dashed: false, label-width: 1.3cm, body) = _equal-row(
  label-width,
  0.2cm,
  h => block(width: label-width, height: h, fill: ysu-navy, radius: 3pt, std.align(center + horizon, text(
    weight: "bold",
    fill: white,
    label,
  ))),
  (if dashed { dash-box } else { sub-box })(std.align(horizon, body)),
  min-height: 0.8cm,
)

/// W: hollow block arrow with 2 to 4 characters on the shaft. `dir`:
/// "right", "left", "up" or "down".
#let block-arrow(dir: "right", body) = context {
  let t = text(size: 9pt, weight: "bold", fill: ysu-navy, body)
  let s = measure(t)
  let shaft = s.height + 0.18cm
  let head-w = shaft + 0.28cm
  let head-l = head-w / 2 / calc.tan(50deg)
  let len = calc.max(1.1cm, s.width + 6pt + head-l)
  let body-l = len - head-l
  let y0 = (head-w - shaft) / 2
  let shape = polygon(
    fill: ysu-tint,
    stroke: 0.8pt + ysu-navy,
    (0pt, y0),
    (body-l, y0),
    (body-l, 0pt),
    (len, head-w / 2),
    (body-l, head-w),
    (body-l, y0 + shaft),
    (0pt, y0 + shaft),
  )
  let arrow = box(width: len, height: head-w, {
    place(shape)
    if dir in ("right", "left") {
      place(left + horizon, dx: (body-l - s.width) / 2, t)
    }
  })
  let angle = (right: 0deg, down: 90deg, left: 180deg, up: -90deg).at(dir)
  if dir in ("right", "left") and angle == 0deg { arrow } else if dir == "left" {
    box(width: len, height: head-w, {
      place(scale(x: -100%, reflow: true, box(width: len, height: head-w, place(shape))))
      place(left + horizon, dx: head-l + (body-l - s.width) / 2, t)
    })
  } else {
    stack(dir: ltr, spacing: 2pt, std.align(horizon, t), rotate(angle, reflow: true, box(
      width: len,
      height: head-w,
      place(shape),
    )))
  }
}

/// Lightweight solid-line stealth arrow for grid cells and chip chains.
/// Keeps the hollow text-bearing `block-arrow` intact.
#let flow-arrow(len: 0.3cm, dir: "right", color: ysu-navy) = {
  let head = 1.4mm
  let half = 0.8mm
  let st = 0.8pt + color
  if dir == "right" {
    block(width: len, height: 2 * half, spacing: 0pt, {
      place(line(start: (0pt, half), end: (len - 0.3mm, half), stroke: st))
      place(dx: len - head, polygon(fill: color, (0mm, 0mm), (head, half), (0mm, 2 * half)))
    })
  } else {
    block(width: 2 * half, height: len, spacing: 0pt, {
      place(line(start: (half, 0pt), end: (half, len - 0.3mm), stroke: st))
      place(dy: len - head, polygon(fill: color, (0mm, 0mm), (2 * half, 0mm), (half, head)))
    })
  }
}

/// Chain of 16 pt rounded chips connected by `+` or `flow-arrow`. `boxed` is
/// an optional 0-based index highlighted in solid YSU red.
#let chip-chain(items, kind: "plus", boxed: none, height: 16pt, size: 8pt) = {
  let chip(i, it) = {
    let focus = i == boxed
    box(
      height: height,
      fill: if focus { ysu-red } else { ysu-navy-chip },
      stroke: if focus { 0.55pt + ysu-red } else { 0.55pt + mix(ysu-navy, 36%) },
      radius: ysu-radius-sm,
      inset: (x: 5.5pt),
      std.align(center + horizon, box(text(
        size: size,
        weight: "bold",
        fill: if focus { white } else { ysu-navy },
        it,
      ))),
    )
  }
  let sep = if kind == "arrow" {
    flow-arrow(len: 0.40cm)
  } else {
    text(size: 9pt, weight: "bold", fill: ysu-navy)[+]
  }
  let cells = ()
  for (i, it) in items.enumerate() {
    cells.push(chip(i, it))
    if i < items.len() - 1 { cells.push(sep) }
  }
  grid(
    columns: (auto,) * cells.len(),
    column-gutter: if kind == "arrow" { 3.5pt } else { 5.5pt },
    align: center + horizon,
    ..cells,
  )
}

/// Modern card with a flush full-height 2.5 pt left accent bar, 0.5 pt border
/// and 2 pt radius. `tone`: "navy" | "red" | "muted".
#let accent-card(
  tone: "navy",
  fill: auto,
  border: auto,
  accent: auto,
  width: 100%,
  height: auto,
  radius: ysu-radius-sm,
  inset: (left: 9pt, right: 7pt, y: 4.5pt),
  body,
) = {
  let (def-fill, def-border, def-accent) = if tone == "red" {
    (ysu-red-tint, ysu-red-border, ysu-red)
  } else if tone == "muted" {
    (white, ysu-line, ysu-base)
  } else {
    (white, ysu-line, ysu-navy)
  }
  let final-fill = if fill == auto { def-fill } else { fill }
  let final-border = if border == auto { def-border } else { border }
  let final-accent = if accent == auto { def-accent } else { accent }
  block(
    width: width,
    height: height,
    breakable: false,
    fill: final-fill,
    stroke: ysu-border + final-border,
    radius: radius,
    clip: true,
    {
      place(top + left, rect(width: ysu-accent-bar, height: 100%, fill: final-accent))
      pad(..inset, body)
    },
  )
}

/// Top guidance strip built on `accent-card`: tint ground, 2.5 pt left bar,
/// bold terms highlighted in navy.
#let lead-strip(
  accent: ysu-navy,
  fill: ysu-tint,
  border: ysu-line,
  size: 8.6pt,
  inset: (left: 10pt, right: 8pt, y: 4.5pt),
  body,
) = accent-card(
  accent: accent,
  fill: fill,
  border: border,
  inset: inset,
  {
    show strong: set text(fill: ysu-navy)
    text(size: size, fill: ysu-ink, body)
  },
)

/// Numbered white sub-cards (`01`, `02`, ...) with soft navy number badges
/// and 0.45 pt hairline borders.
#let numbered-cards(
  items,
  start: 1,
  spacing: 5.5pt,
  equal-height: false,
  text-size: 8pt,
  leading: 0.46em,
  inset: (x: 6pt, y: 4.5pt),
) = {
  let cards = items.enumerate().map(((i, it)) => block(
    width: 100%,
    height: if equal-height { 100% } else { auto },
    breakable: false,
    fill: white,
    stroke: 0.45pt + ysu-line,
    radius: ysu-radius-sm,
    inset: inset,
    std.align(left + horizon, grid(
      columns: (0.48cm, 1fr),
      column-gutter: 4.5pt,
      align: (center + horizon, left + horizon),
      box(
        width: 0.48cm,
        height: 0.42cm,
        fill: ysu-navy-soft,
        radius: ysu-radius-sm,
        std.align(center + horizon, text(
          size: 7.3pt,
          weight: "bold",
          fill: ysu-navy,
          number-width: "tabular",
          _two(start + i),
        )),
      ),
      text(size: text-size, fill: mix(ysu-ink, 86%), par(leading: leading, it)),
    )),
  ))
  if equal-height {
    grid(
      rows: (1fr,) * cards.len(),
      row-gutter: spacing,
      ..cards,
    )
  } else {
    stack(dir: ttb, spacing: spacing, ..cards)
  }
}

/// Dual-zone panel card with integrated gradient header (`grad-head`),
/// 0.5 pt hairline frame and 2.5 pt radius.
#let panel-card(
  kicker: none,
  icon: none,
  title: none,
  aside: none,
  middle: none,
  footer: none,
  width: 100%,
  height: auto,
  body-fill: ysu-tint,
  body-inset: (x: 7pt, y: 7pt),
  middle-inset: (x: 6pt, top: 6.5pt, bottom: 6pt),
  footer-inset: (x: 7pt, y: 5pt),
  body,
) = {
  let header = block(
    width: 100%,
    fill: grad-head,
    inset: if kicker != none { (x: 9pt, top: 5pt, bottom: 6pt) } else { (x: 8pt, y: 5.5pt) },
    if kicker != none {
      stack(
        spacing: 3pt,
        grid(
          columns: (1fr, auto),
          align: (left + horizon, right + horizon),
          text(size: 7.4pt, weight: "bold", fill: ysu-kicker, kicker),
          if icon != none { text(size: 8.2pt, fill: ysu-kicker, icon) } else if aside != none {
            text(size: 7.4pt, fill: ysu-kicker, aside)
          },
        ),
        text(size: 9.2pt, weight: "bold", fill: white, title),
      )
    } else {
      grid(
        columns: (1fr, auto),
        column-gutter: 4pt,
        align: (left + horizon, right + horizon),
        text(size: 9.8pt, weight: "bold", fill: white, {
          if icon != none { icon; h(0.45em) }
          title
        }),
        if aside != none { text(size: 8.2pt, weight: "bold", fill: ysu-kicker, aside) },
      )
    },
  )
  let rows = (auto,)
  let cells = (header,)
  if middle != none {
    rows.push(auto)
    cells.push(block(
      width: 100%,
      fill: white,
      stroke: (bottom: ysu-border + ysu-line),
      inset: middle-inset,
      middle,
    ))
  }
  rows.push(if height == auto { auto } else { 1fr })
  cells.push(block(
    width: 100%,
    height: if height == auto { auto } else { 100% },
    fill: body-fill,
    inset: body-inset,
    body,
  ))
  if footer != none {
    rows.push(auto)
    cells.push(block(
      width: 100%,
      fill: ysu-tint,
      stroke: (top: ysu-border + ysu-line),
      inset: footer-inset,
      footer,
    ))
  }
  block(
    width: width,
    height: height,
    breakable: false,
    fill: body-fill,
    stroke: ysu-border + ysu-line,
    radius: ysu-radius-md,
    clip: true,
    grid(rows: rows, ..cells),
  )
}

/// H: red-framed sentence. White ground, red border, a red label at the
/// left, navy text. At most one per page, never with a conclusion bar.
/// `soft: true` renders a restrained 2.5% red-tint card with a 2.5 pt left bar.
#let red-frame(label: none, center: false, soft: false, body) = {
  let inner = {
    set text(fill: ysu-navy)
    if center {
      std.align(std.center, { if label != none { edge-label(red: true, label); h(0.5em) }; body })
    } else {
      grid(
        columns: (auto, 1fr),
        column-gutter: 0.5em,
        align: horizon,
        if label != none { edge-label(red: true, label) }, body,
      )
    }
  }
  if soft {
    accent-card(
      tone: "red",
      inset: (left: 9pt, right: 7pt, y: 4.5pt),
      inner,
    )
  } else {
    block(
      width: 100%,
      fill: white,
      stroke: 0.8pt + ysu-red,
      radius: 3pt,
      inset: (x: 6pt, y: 5pt),
      inner,
    )
  }
}

/// A: card with a coloured bar on its top edge.
#let card(accent: ysu-navy, fill: white, inset: (x: 6pt, top: 6.5pt, bottom: 5pt), body) = block(
  width: 100%,
  fill: fill,
  stroke: 0.6pt + ysu-line,
  radius: 2pt,
  clip: true,
  inset: inset,
  {
    place(top + left, dx: -inset.x, dy: -inset.top, rect(width: 100% + 2 * inset.x, height: 2.5pt, fill: accent))
    body
  },
)

/// Card with a navy label on the left and a tint body with a navy edge
/// (原稿 \DefenseCard).
#let side-card(label: none, label-width: 2.35cm, body) = _equal-row(
  label-width,
  0.2cm,
  h => block(width: label-width, height: h, fill: ysu-navy, radius: 3pt, std.align(center + horizon, text(
    weight: "bold",
    fill: white,
    label,
  ))),
  block(width: 100%, fill: ysu-tint, stroke: (left: 2pt + ysu-navy), inset: (x: 8pt, y: 6pt), body),
)

/// Publication box: a navy "论文" label and the bibliographic text. A string
/// is cut before "DOI:".
#let paper-box(label: [论文], body) = {
  let text-body = if type(body) == str {
    let i = body.position("DOI:")
    if i == none { body } else { body.slice(0, i).trim() }
  } else { body }
  _equal-row(
    1.3cm,
    0.15cm,
    h => block(width: 1.3cm, height: h, fill: ysu-navy, radius: 3pt, std.align(center + horizon, text(
      weight: "bold",
      fill: white,
      label,
    ))),
    block(width: 100%, fill: ysu-tint, inset: (x: 8pt, y: 6pt), text(size: 8pt, text-body)),
  )
}

// ---------------------------------------------------------------------------
// Points and numbers
// ---------------------------------------------------------------------------

/// D: numbered points 01, 02, ... in navy tabular figures; continuation
/// lines start under the text. `rule` draws an ysuLine rule above each.
#let points(start: 1, rule: false, spacing: 0.5em, ..items) = {
  let rows = items.pos().enumerate().map(((i, it)) => {
    let row = grid(
      columns: (1.6em, 1fr),
      text(weight: "bold", fill: ysu-navy, number-width: "tabular", _two(start + i)), it,
    )
    if rule { block(width: 100%, stroke: (top: 0.6pt + ysu-line), inset: (top: 5pt), row) } else { row }
  })
  stack(dir: ttb, spacing: spacing, ..rows)
}

/// E: key number. A 3 pt navy rule on the top edge, no frame; muted label,
/// large navy value (red with `key: true`), optional basis line.
#let kpi(label: none, value: none, basis: none, key: false, size: 18pt) = block(
  width: 100%,
  stroke: (top: 3pt + ysu-navy),
  inset: (top: 5pt),
  {
    if label != none { text(size: 8pt, weight: "bold", fill: ysu-muted, label); linebreak() }
    text(size: size, weight: "bold", fill: if key { ysu-red } else { ysu-navy }, number-width: "tabular", value)
    if basis != none { linebreak(); text(size: 8pt, fill: ysu-muted, basis) }
  },
)

// ---------------------------------------------------------------------------
// Figures, equations, tables
// ---------------------------------------------------------------------------

/// Caption line under a figure: muted, footnote size.
#let fig-caption(body) = block(above: 2pt, width: 100%, std.align(center, text(size: 8pt, fill: ysu-muted, body)))

/// Centered figure with its caption (原稿 \DefenseFigure).
#let figure-box(caption: none, body) = {
  std.align(center, body)
  if caption != none { fig-caption(caption) }
}

/// Equation number in the thesis style: muted and small.
#let eq-number(body) = text(size: 8pt, fill: ysu-muted, body)

/// B: equation block. The formula sits on a tint block; `number` is the
/// thesis number such as "(3-5)"; `note` is the reading under it.
#let eq-block(number: none, note: none, body) = block(
  width: 100%,
  fill: ysu-tint,
  inset: (x: 8pt, y: 6pt),
  {
    set text(size: 9pt)
    grid(
      columns: (1fr, auto),
      align: (center + horizon, right + horizon),
      body, if number != none { eq-number(number) },
    )
    if note != none {
      v(4pt)
      text(size: 9pt, note)
    }
  },
)

/// Reading card: tint ground, navy bold title, 9 pt text.
#let reading-card(title: none, body) = block(
  width: 100%,
  fill: ysu-tint,
  inset: (x: 8pt, y: 5pt),
  {
    if title != none { text(weight: "bold", fill: ysu-navy, title); v(4pt, weak: true) }
    text(size: 9pt, body)
  },
)

/// Field screenshot in a night-blue window with three dots and a title.
#let screen-frame(title: none, body) = block(
  fill: ysu-night,
  radius: 4pt,
  inset: (x: 5pt, top: 0pt, bottom: 5pt),
  {
    block(height: 0.42cm, width: 100%, spacing: 0pt, std.align(left + horizon, {
      for _ in range(3) { box(circle(radius: 2.2pt, fill: ysu-night-dot)); h(3pt) }
      if title != none { h(6pt); text(size: 6.5pt, fill: ysu-kicker, title) }
    }))
    body
  },
)

/// Results table: navy header band with white text, a closing navy rule and
/// tinted rows for `mark` (0-based data-row indices, e.g. this work).
#let result-table(columns: auto, header: (), rows: (), mark: (), align: auto, size: 9pt) = {
  let n = header.len()
  let cols = if columns == auto { (auto,) + (1fr,) * (n - 1) } else { columns }
  set text(size: size)
  table(
    columns: cols,
    stroke: none,
    inset: (x: 5pt, y: 3.5pt),
    align: if align == auto { (x, y) => if x == 0 { left + horizon } else { center + horizon } } else { align },
    fill: (x, y) => if y == 0 { ysu-navy } else if (y - 1) in mark { mix(ysu-navy, 8%) },
    table.header(..header.map(h => text(weight: "bold", fill: white, h))),
    ..rows
      .enumerate()
      .map(((i, r)) => if i in mark { r.map(c => strong(c)) } else { r })
      .flatten(),
    table.hline(stroke: 0.8pt + ysu-navy),
  )
}
