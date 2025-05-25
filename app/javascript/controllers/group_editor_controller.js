import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  connect() {}

  toggle(event) {
    const targetCheckbox = event.target
    const studentId = targetCheckbox.value

    if (targetCheckbox.checked) {
      this.checkboxTargets.forEach(cb => {
        if (cb !== targetCheckbox && cb.value === studentId) {
          cb.checked = false
        }
      })
    }
  }
}
