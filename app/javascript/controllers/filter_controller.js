import { Controller } from "@hotwired/stimulus"

// Submits a filter form when a controlled field changes, or when a
// menu option is chosen (status filters, etc.).
export default class extends Controller {
  static targets = ["form", "field", "button"]

  submit() {
    this.formTarget.requestSubmit()
  }

  select(event) {
    const status = event.currentTarget.dataset.status ?? ""

    this.fieldTargets.forEach((field) => { field.value = status })

    this.element.querySelectorAll("[data-status]").forEach((el) => {
      el.classList.toggle("is-active", el.dataset.status === status)
    })

    if (this.hasButtonTarget) {
      const label = event.currentTarget.textContent.trim()

      this.buttonTarget.classList.toggle("is-active", status !== "")
      this.buttonTarget.setAttribute(
        "aria-label",
        status ? `Filter by status (${label})` : "Filter by status"
      )
    }

    this.submit()
  }
}
