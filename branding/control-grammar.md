# Control grammar

A supplement to the _MMA Branding Guide 2026_ (the PDF beside this file) for interactive controls in
MarineSensitivity apps. The guide sets colour, type and logo use; this page sets what each kind of
control **means**, so that a look never stands for two different jobs. Adopted 2026-09-30 (Atlas
round 4). The Atlas implements it in `atlas/src/lib/ui/` and documents the app-level detail in
`atlas/docs/design/spec.md`.

## One look, one job

| Control    | Look                                                                                   | Job                                                   | Atlas component   |
| ---------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------- | ----------------- |
| **Switch** | Pill with a Gold (`#e8c24a`) fill on the active segment, Navy (`#001a57`) text on it   | Changes the **data**                                  | `Segmented.svelte` |
| **Tabs**   | Plain text labels on a hairline; the active one is bold with a 3 px underline          | Changes the **view** of the same data, in one surface | `Tabs.svelte`     |
| **Spine**  | Vertical strip of icon-over-label buttons; the active one has a Gold fill, Navy text   | Changes the **surface**                               | `Rail.svelte`     |

How to choose:

- If the map, the legend and the table would all show different numbers afterwards, it is a
  **switch**. Examples: Scores | Species; Raster cells | Program areas; a species' model input;
  Delivered | As ingested.
- If the same selection is only being shown a different way, inside the same pane, it is **tabs**.
  Example: the table's Species · Zones · Composition.
- If it opens a different working surface, it is a **spine** entry. The Atlas has four, in this
  order in both lenses and on every viewport: Layers · Details · Table · Report.

A control that matches none of these is a button, a select or a checkbox, not a fourth toggle style.

## Rules

1. **Never style tabs as a pill, or a switch as an underline.** The shape is the meaning.
2. **No tabs inside tabs.** If a surface seems to need a second level, one of the levels is really
   a spine entry or a switch.
3. **A switch has two to four options and always has one selected.** More than four is a select.
4. **The spine is attached to the panel it controls**, on the panel's outer edge, and moves with it.
   The panel docks left by default. Selecting the active entry again collapses the panel. On a phone
   the spine is the bottom bar and the panel is the sheet above it.
5. **A surface takes the width its content needs.** Layers, Details and Report open as a side
   panel; Table takes the whole stage.
6. **The panel header says what is being shown** ("Score · Raster cells", "Cell 3058375"), not the
   name of the spine entry, which is already visible beside it.
7. **Name a surface for what the reader gets.** "Details" holds the flower plot in the Scores lens
   and the species information in the Species lens; neither lens needs its own entry.

## Colour and contrast

- Active fill: Gold with Navy text (9.5:1) in both themes. Gold is never used as text on a light
  ground (1.7:1).
- Tab underline and focus ring: Navy on the light ("paper") theme, Gold on the dark ("navy") theme.
- Inactive labels use the secondary text colour and must still meet 4.5:1.
- Every control has a visible keyboard focus state and a minimum 44 px touch target.

## Data graphics that belong to a layer

A histogram of a layer's values belongs to the **legend**, above the colour ramp and on the ramp's
own axis, with bars in the ramp's colours. It covers the whole layer, so it does not change as the
reader clicks around; a marker shows the clicked cell's or area's value. A click popup states the
value and links to Details.
