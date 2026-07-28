import { Controller } from "@hotwired/stimulus"

// Removes its element — closes the inline new-brief editor without a round trip.
export default class extends Controller {
  dismiss() {
    this.element.remove()
  }
}
