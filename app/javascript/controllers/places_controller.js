import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [
    "field",
    "distance",
    "amountPaid",
    "totalAmount",
    "baseFare",
    "returnTripRow",
    "returnTripFee",
  ];

  connect() {
    if (typeof google != "undefined") {
      this.initMap();
    }
  }

  initMap() {
    this.fieldTargets.forEach((field) => {
      new google.maps.places.Autocomplete(field);
    });
    this.distanceService = new google.maps.DistanceMatrixService();
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault();
    }
  }

  calculateDistance() {
    const origin = this.fieldTargets[0].value;
    const destination = this.fieldTargets[1].value;

    if (origin && destination) {
      this.distanceService.getDistanceMatrix(
        {
          origins: [origin],
          destinations: [destination],
          travelMode: "DRIVING",
          unitSystem: google.maps.UnitSystem.METRIC,
        },
        (response, status) => {
          if (status === "OK") {
            const distance = response.rows[0].elements[0].distance.text;
            const duration = response.rows[0].elements[0].duration.text;
            const distanceValue = response.rows[0].elements[0].distance.value / 1000; // Convert meters to kilometers
            const baseFare = Math.round(distanceValue * 10); // Rs 10 per km, rounded to nearest integer
            this.distanceTarget.textContent = `Distance: ${distance}, Estimated time: ${duration}`;
            this.updateCostBreakdown(baseFare);
          } else {
            this.distanceTarget.textContent = "Unable to calculate distance";
            this.resetCostBreakdown();
          }
        }
      );
    }
  }

  updateCostBreakdown(baseFare) {
    let totalAmount = baseFare;
    let returnTripFee = 0;

    this.baseFareTarget.textContent = baseFare.toFixed(2);

    if (this.element.querySelector("#booking_return_trip").checked) {
      returnTripFee = baseFare;
      totalAmount = baseFare * 2;
      this.returnTripRowTarget.style.display = "";
      this.returnTripFeeTarget.textContent = returnTripFee.toFixed(2);
    } else {
      this.returnTripRowTarget.style.display = "none";
    }

    this.totalAmountTarget.textContent = totalAmount.toFixed(2);
    this.amountPaidTarget.value = totalAmount.toFixed(2);
  }

  resetCostBreakdown() {
    this.baseFareTarget.textContent = "0.00";
    this.returnTripFeeTarget.textContent = "0.00";
    this.totalAmountTarget.textContent = "0.00";
    this.returnTripRowTarget.style.display = "none";
    this.amountPaidTarget.value = "0.00";
  }

  toggleReturnTrip() {
    const baseFare = parseFloat(this.baseFareTarget.textContent);
    this.updateCostBreakdown(baseFare);
  }
}