require "rqrcode"

class BookingMailer < ApplicationMailer
  def booking_confirmation(booking)
    qrcode = RQRCode::QRCode.new(booking_root_url(booking.id))

    # NOTE: showing with default options specified explicitly
    @svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
    @booking = booking
    @customer = booking.customer

    mail to: @customer.email, subject: "Booking confirmation for trip from #{@booking.booking_from} to #{@booking.booking_to}"
  end

  private
   
  def booking_root_url(booking_id)
    "http://www.google.com"
  end
end
