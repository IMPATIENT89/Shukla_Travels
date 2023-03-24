# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

 <%= render 'shared/errors', obj: @hoste %>
      <%= form_with(model: @hoste, local: true) do |form| %>
      <div class="mb-3">
        <%= form.label :host_full_name, "Your Full Name" %>
        <%= form.text_field :host_full_name, class: "form-control", placeholder: "Enter your full name" %>
      </div>
      <div class="mb-3">
        <%= form.label :email, "Email" %>
        <%= form.text_field :email, class: "form-control", placeholder: "Enter your email address" %>
      </div>
      <div class="mb-3">
        <%= form.label :phone, "Phone" %>
        <%= form.text_field :phone, class: "form-control", placeholder: "Enter your phone number" %>
      </div>
      <div class="mb-3">
        <%= form.label :password, "Password"%>
        <%= form.password_field :password, class: "form-control", placeholder: "Enter your password" %>
      </div>
      <div class="mb-3">
        <%= form.label :password_confirmation, "Confirm password" %>
        <%= form.password_field :password_confirmation, class: "form-control", placeholder: "Please enter the password again" %>
      </div>
      <div class="mb-3">
        <%= form.label :no_of_cars, "Number of Cars" %>
        <%= form.text_field :no_of_cars, class: "form-control", placeholder: "Enter the number of cars that you want to be rented" %>
      </div>
      <div class="mb-3">
       <%= form.submit "Sign Up", class: "btn btn-primary" %>
      </div>
<% end %>
* ...
