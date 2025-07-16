import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["menu"]

  connect() {
    document.addEventListener("turbo:before-visit", () => {
      this.close()
    })
  }

  toggle() {
    this.menuTarget.classList.toggle("-translate-x-full")
  }

  close() {
    if (this.hasMenuTarget) {
    this.menuTarget.classList.add("-translate-x-full")
    }
  }
}
