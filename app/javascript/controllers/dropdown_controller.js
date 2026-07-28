import { Controller } from "@hotwired/stimulus"

// Toggles a simple menu. Closes on outside click or Escape.
export default class extends Controller {
  static targets = ["menu", "button"]

  connect() {
    this.boundClose = this.closeOnOutsideClick.bind(this)
  }

  toggle(event) {
    event.preventDefault()
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.menuTarget.hidden = false
    this.buttonTarget.setAttribute("aria-expanded", "true")
    document.addEventListener("click", this.boundClose)
  }

  close() {
    this.menuTarget.hidden = true
    this.buttonTarget.setAttribute("aria-expanded", "false")
    document.removeEventListener("click", this.boundClose)
  }

  closeOnOutsideClick(event) {
    if (!this.element.contains(event.target)) this.close()
  }

  disconnect() {
    document.removeEventListener("click", this.boundClose)
  }

  get isOpen() {
    return !this.menuTarget.hidden
  }
}
