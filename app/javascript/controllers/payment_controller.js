import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cardFields"]

  connect() {
    this.toggleCardFields()
  }

  toggleCardFields() {
    const selectedMethod = this.element.querySelector('select[name="booking[payment_mode]"]').value
    if (selectedMethod === 'card') {
      this.cardFieldsTarget.style.display = 'block'
    } else {
      this.cardFieldsTarget.style.display = 'none'
    }
  }
}