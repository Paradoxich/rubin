import { Controller } from "@hotwired/stimulus"

// Submits a form when a controlled field changes (status filters, etc.).
export default class extends Controller {
  static targets = ["form"]

  submit() {
    this.formTarget.requestSubmit()
  }
}
