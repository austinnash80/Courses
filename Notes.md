# Show page Temp:

<p id="notice"><%= notice %></p>

<div class="page-header ">
</br>
  <h1 class="text-center"><strong>Course Update - <%= @updatesheet.seq_number %><%= @updatesheet.seq_version %></strong> </br><small>Recieved: <%= @updatesheet.date_received.strftime("%b %-d, %Y")%></small></h1>
  <div class="col-lg-offset-2">
    <%= link_to 'Back to Index', updatesheets_path, class: 'btn btn-default' %> <%= link_to 'Edit Entry', edit_updatesheet_path(@updatesheet), class: 'btn btn-default' %>
  </div>
</div>
</br>
<div class="col-lg-offset-2 col-lg-8">
<div class="well well-white" >
  <h3 class=""><strong>Details</strong></h3>
</br>

  <h4>
    <strong>Sequoia Number:</strong>
    <%= @updatesheet.seq_number %><%= @updatesheet.seq_version %> - <%= @updatesheet.seq_title %>
  </h4>

  <h4>
    <strong>PES Number:</strong>
    <%= @updatesheet.pes_number %><%= @updatesheet.pes_version %>
  </h4>

</br>
  <p>
      <strong>Hold:</strong>
      <%= @updatesheet.extra_boolean %>
  </p>

  <p>
    <strong>Update Course:</strong>
    <%= @updatesheet.update_course %>
  </p>
</div>
# end

# Simple Form Sample

## New page
<div class="page-header ">
</br>
  <h1 class="text-center">Add New Postcard Mailing</h1>
  <div class="col-lg-offset-3">
    <%= link_to 'Back to Index', postcard_mailings_path, class: 'btn btn-default' %>
  </div>
</div>

<%= render 'form', postcard_mailing: @postcard_mailing %>
## end

## the Form - Postcard Mailing
    <%= simple_form_for(@postcard_mailing) do |f| %>

      <%= f.error_notification %>
    </br>
    <div class="well well-white col-lg-offset-3 col-lg-6">
    </br>
    <div class="row">
      <div class="col-lg-offset-4">
        <%= f.input :date_sent, label: 'Mailing Date' %>
      </div>
    </div>
    </br>
    <div class="row">
      <div class="col-lg-3">
        <%= f.input :sent, label: 'Mailing Complete?', as: :radio_buttons, :checked => ['Yes', true] %>
      </br>
        <%= f.input :company, label: 'Company', collection: @companies, as: :radio_buttons %>
      </div>
      <div class="col-lg-3">
        <%= f.input :version, label: 'Postcard Type', collection: @postcard_type, as: :radio_buttons %>
      </div>
    </div>
    </br>
    <!-- </br> -->
    <div class="row">
      <div class="col-lg-3">
        <%= f.input :number_sent, label: 'Number sent' %>
      </div>
    </div>
    </br>
    <%= f.input :note, label: false, placeholder: 'Add any notes about this mailing' %>
    </br>
    <%= f.button :submit, 'Submit', class: 'btn btn-primary' %>

    <% end %>
## End Form
# end

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

* ...
