import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  showGentle() {
    document.querySelectorAll('[data-gentle-mode-target="original"]').forEach(el => {
      el.style.display = "none"
    })
    document.querySelectorAll('[data-gentle-mode-target="gentle"]').forEach(el => {
      el.style.display = "block"
    })
  }

  showOriginal() {
    document.querySelectorAll('[data-gentle-mode-target="original"]').forEach(el => {
      el.style.display = "block"
    })
    document.querySelectorAll('[data-gentle-mode-target="gentle"]').forEach(el => {
      el.style.display = "none"
    })
  }
}
