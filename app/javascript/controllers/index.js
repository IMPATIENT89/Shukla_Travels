import { application } from "../application"


import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

console.log("controllers loaded");


import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PlacesController from "./places_controller"
application.register("places", PlacesController)
