# Rubin

Rails 8 practice lab for **Hotwire** (Turbo + Stimulus), **ViewComponents**, and a portable CSS token layer.

Built to get fluent in the idiom before a Rails frontend take-home — not to claim adjacency from Next.js/React work.

## Stack

- Ruby 4 / Rails 8.1
- Hotwire: Turbo Drive, Frames, Streams + Stimulus
- ViewComponent
- Portfolio design tokens (warm / cool / light) ported as plain CSS variables + Tailwind v4 `@theme` bridge
- SQLite (local), importmap (no JS bundler required)

## Design system

Tokens and type/surface classes come from the portfolio (`app/globals.css` / `docs/DESIGN_SYSTEM.md`):

- Theme primitives via `data-theme="warm|cool|light"`
- Semantic aliases (`--color-bg`, `--color-text-primary`, spacing, radius, type scale)
- Utility bridge so portfolio-style classes work (`bg-color-bg`, `type-h1`, `card-interactive`, …)
- Theme switcher Stimulus controller persists choice in `localStorage`
- Geist Sans / Mono self-hosted as variable woff2 (`app/assets/fonts`), no CDN

## What to poke at

| Surface | Where |
|---|---|
| Turbo Frame inline edit | Click Edit → edit in-frame → Save or Cancel |
| Turbo Streams | Add / change status / remove briefs without full reload — rows join and leave the filtered lane, and the empty state appears when the last one goes |
| Lane filter | The active filter rides along with the create form via the HTML `form` attribute, and with each row's status form as a param |
| List cap | The index shows the five newest briefs; Show all reloads the `briefs` frame with the full lane |
| Stimulus | `dropdown`, `filter`, `status-select`, `dismissable`, `flash`, `theme` in `app/javascript/controllers` |
| ViewComponent | `StatusBadgeComponent`, `BriefRowComponent`, `AvatarComponent` |
| Design tokens | Portfolio warm/cool/light tokens in `app/assets/tailwind/application.css` |
| Theme switcher | `theme_controller.js` + `data-theme` on `<html>` |
| Tests | `test/controllers/briefs_controller_test.rb` asserts the Turbo Stream responses |

## Setup

Homebrew Ruby is keg-only. Put it on your PATH (add to `~/.zshrc` if you want it permanent):

```bash
export PATH="/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/4.0.0/bin:$PATH"
```

Then:

```bash
bin/setup
bin/rails db:seed
bin/dev
```

Open [http://localhost:3000](http://localhost:3000).

`bin/dev` runs Rails and the Tailwind watcher via Foreman.

Run the tests with:

```bash
bin/rails test
```

## Suggested practice order

1. Trace a status change: `BriefRowComponent` → `BriefsController#update` → `update.turbo_stream.erb`
2. Trace inline edit: Edit → `edit.html.erb` Turbo Frame → Save / Cancel
3. Add one new Stimulus behavior (e.g. character count on notes)
4. Extract another ViewComponent (e.g. `GhostButtonComponent`) once a pattern repeats
