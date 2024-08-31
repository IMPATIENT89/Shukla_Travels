// app/javascript/controllers/amount_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["baseFare", "returnTripRow", "returnTripFee", "totalAmount", "amountPaid"]

  connect() {
    this.updateAmount()
  }

  updateAmount() {
    const distance = parseFloat(this.element.dataset.distance) || 0
    const isReturnTrip = this.element.querySelector("#booking_return_trip").checked

    const baseFare = distance * 10
    let totalAmount = baseFare

    this.baseFareTarget.textContent = baseFare.toFixed(2)

    if (isReturnTrip) {
      totalAmount *= 2
      this.returnTripRowTarget.style.display = "flex"
      this.returnTripFeeTarget.textContent = baseFare.toFixed(2)
    } else {
      this.returnTripRowTarget.style.display = "none"
    }

    this.totalAmountTarget.textContent = totalAmount.toFixed(2)
    this.amountPaidTarget.value = totalAmount.toFixed(2)
  }
}