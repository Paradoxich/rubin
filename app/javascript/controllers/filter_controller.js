import { Controller } from "@hotwired/stimulus"

// Submits a filter form when a controlled field changes, or when a
// menu option is chosen (status filters, etc.).
export default class extends Controller {
  static targets = ["form", "field"]

  submit() {
    this.formTarget.requestSubmit()
  }

  select(event) {
    const status = event.currentTarget.dataset.status ?? ""

    if (this.hasFieldTarget) {
      this.fieldTarget.value = status
    }

    this.element.querySelectorAll("[data-status]").forEach((el) => {
      el.classList.toggle("is-active", el.dataset.status === status)
    })

    this.submit()
  }
}
