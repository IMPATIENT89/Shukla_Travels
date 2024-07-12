import { Controller } from "@hotwired/stimulus"

export default class PlacesController extends Controller {
  connect() {
    console.log("places_controller");
    alert("hello");
  }

}