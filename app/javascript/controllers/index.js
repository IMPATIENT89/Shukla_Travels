import { application } from "./application"

console.log("controllers loaded");


import HelloController from "./hello_controller"
application.register("hello", HelloController)

import PlacesController from "./places_controller"
application.register("places", PlacesController)

import PaymentController from "./payment_controller";
application.register("payment", PaymentController)

import RazorpayController from "./razorpay_controller";
application.register("razorpay", RazorpayController)