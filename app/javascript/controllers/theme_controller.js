import { Controller } from "@hotwired/stimulus"

const STORAGE_KEY = "rubin-theme"
const THEMES = ["warm", "cool", "light"]

// Mirrors the portfolio's data-theme switching (warm / cool / light).
export default class extends Controller {
  static targets = ["button"]

  connect() {
    const saved = window.localStorage.getItem(STORAGE_KEY)
    const theme = THEMES.includes(saved) ? saved : "warm"
    this.apply(theme)
  }

  select(event) {
    const theme = event.currentTarget.dataset.themeValue
    if (!THEMES.includes(theme)) return
    this.apply(theme)
    window.localStorage.setItem(STORAGE_KEY, theme)
  }

  apply(theme) {
    document.documentElement.dataset.theme = theme
    this.buttonTargets.forEach((button) => {
      button.classList.toggle("is-active", button.dataset.themeValue === theme)
    })
  }
}
