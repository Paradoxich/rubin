import { Controller } from "@hotwired/stimulus"

// Auto-dismisses flash messages after a short delay.
export default class extends Controller {
  static values = { delay: { type: Number, default: 3200 } }

  connect() {
    this.timeout = setTimeout(() => this.dismiss(), this.delayValue)
  }

  dismiss() {
    this.element.remove()
  }

  disconnect() {
    clearTimeout(this.timeout)
  }
}
