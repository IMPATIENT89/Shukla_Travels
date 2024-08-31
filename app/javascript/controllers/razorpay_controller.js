// app/javascript/controllers/razorpay_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.loadRazorpayScript()
  }

  loadRazorpayScript() {
    if (window.Razorpay) {
      this.initializeRazorpay()
    } else {
      const script = document.createElement('script')
      script.src = 'https://checkout.razorpay.com/v1/checkout.js'
      script.async = true
      script.onload = () => this.initializeRazorpay()
      document.head.appendChild(script)
    }
  }

  initializeRazorpay() {
    const options = {
      key: "rzp_test_CK6ZBSK19gceDg",
      order_id: this.data.get("orderId"),
      customer_id: this.data.get("customerId"),
      recurring: "0",
      handler: (response) => {
        this.handlePaymentSuccess(response)
      },
      notes: {
        "note_key 1": `Booking Activated for ${this.data.get("customerEmail")}`,
      },
      color: "#F37254",
    }

    this.rzp = new Razorpay(options)
    this.buttonTarget.disabled = false
  }

  openRazorpay(event) {
    event.preventDefault()
    if (this.rzp) {
      this.rzp.open()
    } else {
      console.error("Razorpay not initialized")
    }
  }

  handlePaymentSuccess(response) {
    console.log(response.razorpay_payment_id)
    console.log(response.razorpay_order_id)
    console.log(response.razorpay_signature)

    // You can add AJAX call here to update the server
    // For now, we'll just redirect
    window.location.href = `/bookings/${this.data.get("bookingId")}`
  }
}