import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["source", "checkbox"]

  toggleAll() {
    const checked = this.sourceTarget.checked
    this.checkboxTargets.forEach((el) => {
      el.checked = checked
    })
  }
}
