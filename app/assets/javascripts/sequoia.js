$(document).ready(function(){

// *** Search Functions

    // General Search (id must only be different if they are on the sme page)
    // This can be used on any page if it is the only one there
    $("#myInputCalendarGeneral").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTableCalendarGeneral tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    $("#myInput").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTable tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // For Dashboard Live Chat Answers
    $("#myInputSequoia").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTableSequoia tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    $("#myInputEmpire").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTableEmpire tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    $("#myInputTax").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myTableTax tr").filter(function() {
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

    // Course Status - Pub Dates
    $("#myInputPubdates").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListPubdates tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Course Status - Non Active
    $("#myInputNonactive").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListNonactive tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // Course Status - Course Comments
    $("#myInputComments").on("keyup", function() {
      var value = $(this).val().toLowerCase();
      $("#myListCommments tr").filter(function() {
        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
      });
    });

    // test JS
    	$('.banner .banner-section .banner-section-inner').click(function(){
    		if ($(this).hasClass('active')) {
    			$(this).removeClass('active');
    		} else {
    			$('.banner .banner-section .banner-section-inner').removeClass('active');
    			$(this).addClass('active');
    		}
    	});

      // Test_hp
      var height = $('.footer').height();
      $('.sect-t-footer').css('height', height);

});
