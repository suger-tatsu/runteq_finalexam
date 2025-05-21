import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  static values = { url: String }

  connect() {
    this.timeout = null
  }

  search() {
    clearTimeout(this.timeout)

    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      if (query.length < 1 || !this.hasUrlValue) return

      fetch(`${this.urlValue}?q=${encodeURIComponent(query)}`)
        .then(response => response.json())
        .then(data => {
          this.listTarget.innerHTML = ""
          data.forEach((item) => {
            const div = document.createElement("div")
            div.className = "cursor-pointer hover:bg-gray-200 px-2 py-1"
            div.textContent = item
            div.addEventListener("click", () => {
              this.inputTarget.value = item
              this.listTarget.innerHTML = ""
            })
            this.listTarget.appendChild(div)
          })
        })
    }, 300)
  }
}