import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "field", "map", "latitude", "longitude" ]

  connect() {
    if (typeof(google) != "undefined") {
      console.log("hey")
    }
    console.log("places_controller")
  }

}