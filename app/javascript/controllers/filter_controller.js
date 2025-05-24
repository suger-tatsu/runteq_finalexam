
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "item"]

  search() {
    const query = this.inputTarget.value.toLowerCase()

    this.itemTargets.forEach((el) => {
      const text = el.textContent.toLowerCase()
      el.style.display = text.includes(query) ? "block" : "none"
    })
  }
}