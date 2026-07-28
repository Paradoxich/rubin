import { Controller } from "@hotwired/stimulus"

// Syncs a badge-styled status picker with a hidden form field.
export default class extends Controller {
  static targets = ["field", "badge", "label"]

  pick(event) {
    const status = event.currentTarget.dataset.status
    if (!status) return

    this.fieldTarget.value = status
    this.labelTarget.textContent = event.currentTarget.textContent.trim()
    this.badgeTarget.className = `badge type-body-sm status-field__badge badge--${status}`

    this.element.querySelectorAll("[data-status]").forEach((el) => {
      el.classList.toggle("is-active", el.dataset.status === status)
    })
  }
}
