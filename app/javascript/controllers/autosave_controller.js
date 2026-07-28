import { Controller } from "@hotwired/stimulus"

// Debounced autosave for textarea/input fields via form requestSubmit.
export default class extends Controller {
  static targets = ["form", "status"]
  static values = { delay: { type: Number, default: 600 } }

  connect() {
    this.timeout = null
  }

  queue() {
    this.statusTarget.textContent = "Saving…"
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => this.formTarget.requestSubmit(), this.delayValue)
  }

  saved() {
    this.statusTarget.textContent = "Saved"
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
