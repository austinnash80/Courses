$(document).ready(function(){

// *** Search Functions

    // General Search (id must only be different if they are on the sme page)
    // This can be used on any page if it is the only one there
    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Dashboard CPA Exam Search
    $("#myInputCPA").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListCPA tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Dashboard EA Exam Search
    $("#myInputEA").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListEA tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Sales Report - Day
    $("#myInputDay").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListDay tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Sales Report - week AND Exam data(original)
    $("#myInputWeek").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListWeek tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Sales Report - Month AND Exam data(original)
    $("#myInputMonth").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListMonth tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Sales Report - Year
    $("#myInputYear").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListYear tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

});
