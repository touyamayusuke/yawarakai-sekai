import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "current"]

  connect() { this.update() }
  update() {
    const len = (this.inputTarget.value || "").length
    if (this.currentTarget) this.currentTarget.textContent = len
  }

  // 入力中も反映
  input(event) { this.update() }
}