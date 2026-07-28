import { Controller } from "@hotwired/stimulus"

// Closes an inline editor: follows its cancel link when it has one
// (edit restores the row by frame navigation), otherwise removes the
// element (the new editor just disappears).
export default class extends Controller {
  static targets = ["link"]

  connect() {
    this.boundEscape = this.dismissOnEscape.bind(this)
    document.addEventListener("keydown", this.boundEscape)
  }

  disconnect() {
    document.removeEventListener("keydown", this.boundEscape)
  }

  dismiss() {
    this.hasLinkTarget ? this.linkTarget.click() : this.element.remove()
  }

  dismissOnEscape(event) {
    if (event.key !== "Escape") return

    // An open dropdown inside the editor claims Escape first.
    if (this.element.querySelector('[aria-expanded="true"]')) return

    this.dismiss()
  }
}
