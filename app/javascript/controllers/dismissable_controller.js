import { Controller } from "@hotwired/stimulus"

// Removes its element — closes the inline new-brief editor without a round trip.
export default class extends Controller {
  connect() {
    this.boundEscape = this.dismissOnEscape.bind(this)
    document.addEventListener("keydown", this.boundEscape)
  }

  disconnect() {
    document.removeEventListener("keydown", this.boundEscape)
  }

  dismiss() {
    this.element.remove()
  }

  dismissOnEscape(event) {
    if (event.key !== "Escape") return

    // An open dropdown inside the editor claims Escape first.
    if (this.element.querySelector('[aria-expanded="true"]')) return

    this.dismiss()
  }
}
