import { Controller } from "@hotwired/stimulus"

// Toggles a simple menu. Closes on outside click or Escape.
export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.boundClose = this.closeOnOutsideClick.bind(this)
    this.boundEscape = this.closeOnEscape.bind(this)
  }

  toggle(event) {
    event.preventDefault()
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.menuTarget.hidden = false
    this.buttonTarget.setAttribute("aria-expanded", "true")
    document.addEventListener("click", this.boundClose)
    document.addEventListener("keydown", this.boundEscape)
  }

  close() {
    this.menuTarget.hidden = true
    this.buttonTarget.setAttribute("aria-expanded", "false")
    document.removeEventListener("click", this.boundClose)
    document.removeEventListener("keydown", this.boundEscape)
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) this.close()
  }

  closeOnEscape(event) {
    if (event.key !== "Escape") return

    this.close()
    this.buttonTarget.focus()
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose)
    document.removeEventListener("keydown", this.boundEscape)
  }

  get isOpen() {
    return !this.menuTarget.hidden
  }
}
