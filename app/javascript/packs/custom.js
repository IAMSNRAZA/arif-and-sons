$(document).on('turbolinks:load', function () {
    // Side Menu Hide Show JS
    $(".burger-menu").on('click', function () {
        $(".burger-menu").toggleClass("toggle-menu");
        // $(".navbar-brand").toggleClass("navbar-logo");
        $(".sidemenu-area").toggleClass("sidemenu-toggle");
        $(".sidemenu").toggleClass("hide-nav-title");
        $(".main-content").toggleClass("hide-sidemenu");
    });

    // Burger menu click show toggle x class
    $(".burger-menu").on('click', function () {
        $(".burger-menu").toggleClass("x");
    });

    // Feather Icon Js
    feather.replace();

    // Tooltip JS
    $('[data-toggle="tooltip"]').tooltip();

    // Gallery Viewer JS
    var console = window.console || {
        log: function () {}
    };
    var $images = $('.gallery-content');
    var $toggles = $('.gallery-toggles');
    var $buttons = $('.gallery-buttons');
    var options = {
        // inline: true,
        url: 'data-original',
        ready: function (e) {
            console.log(e.type);
        },
        show: function (e) {
            console.log(e.type);
        },
        shown: function (e) {
            console.log(e.type);
        },
        hide: function (e) {
            console.log(e.type);
        },
        hidden: function (e) {
            console.log(e.type);
        },
        view: function (e) {
            console.log(e.type);
        },
        viewed: function (e) {
            console.log(e.type);
        }
    };

    function toggleButtons(mode) {
        if (/modal|inline|none/.test(mode)) {
            $buttons
                .find('button[data-enable]')
                .prop('disabled', true)
                .filter('[data-enable*="' + mode + '"]')
                .prop('disabled', false);
        }
    }
    $images.on({
        ready: function (e) {
            console.log(e.type);
        },
        show: function (e) {
            console.log(e.type);
        },
        shown: function (e) {
            console.log(e.type);
        },
        hide: function (e) {
            console.log(e.type);
        },
        hidden: function (e) {
            console.log(e.type);
        },
        view: function (e) {
            console.log(e.type);
        },
        viewed: function (e) {
            console.log(e.type);
        }
    }).viewer(options);
    toggleButtons(options.inline ? 'inline' : 'modal');
    $toggles.on('change', 'input', function () {
        var $input = $(this);
        var name = $input.attr('name');
        options[name] = name === 'inline' ? $input.data('value') : $input.prop('checked');
        $images.viewer('destroy').viewer(options);
        toggleButtons(options.inline ? 'inline' : 'modal');
    });
    $buttons.on('click', 'button', function () {
        var data = $(this).data();
        var args = data.arguments || [];
        if (data.method) {
            if (data.target) {
                $images.viewer(data.method, $(data.target).val());
            } else {
                $images.viewer(data.method, args[0], args[1]);
            }
            switch (data.method) {
                case 'scaleX':
                case 'scaleY':
                    args[0] = -args[0];
                    break;
                case 'destroy':
                    toggleButtons('none');
                    break;
            }
        }
    });

    // FAQ Accordion Js
    $('.accordion').find('.accordion-title').on('click', function () {
        // Adds Active Class
        $(this).toggleClass('active');
        // Expand or Collapse This Panel
        $(this).next().slideToggle('fast');
        // Hide The Other Panels
        $('.accordion-content').not($(this).next()).slideUp('fast');
        // Removes Active Class From Other Titles
        $('.accordion-title').not($(this)).removeClass('active');
    });

    function updateRemainingAmount2() {
        var total = parseFloat($('#order_total').val() || 0);
        var paid = parseFloat($('#order_payed_amount').val() || 0);
        var remaining = total - paid;
        $('#order_remaining_amount').val(remaining);
    }
    $('#order_total, #order_payed_amount').on('input', function() {
      updateRemainingAmount2();
    });

    $(document).on('cocoon:after-insert cocoon:after-remove', function() {
      var total = 0;
      $('input[id="order_item_price"]').each(function() {
        var price = parseFloat($(this).val()) || 0;
        total += price;
      });
      $('#total_price').text(total.toFixed(2)); // output the total price to an element with ID "total_price"

      updateRemainingAmount(total);
      updateOrderTotal(total);
    });

    // $(document).on('change', 'select[name$="[product_id]"], input[name$="[quantity]"]', function() {
    $(document).on('keyup', 'input[name$="[quantity]"]', function() {
      var $nestedFields = $(this).closest('.nested-fields');
      var productId = $nestedFields.find('select[name$="[product_id]"]').val();
      var quantity = $nestedFields.find('input[name$="[quantity]"]').val();

      // Fetch the price via AJAX
      var price = 0;
      if (productId && quantity) {
        $.ajax({
          url: '/products/' + productId + '/price',
          type: 'GET',
          dataType: 'json',
          data: { quantity: quantity },
          async: false,
          success: function(data) {
            price = data.price;
          }
        });
      }
      $nestedFields.find('input[name$="[price]"]').val(price.toFixed(2));
      updateOrderTotal();
    });

    function updateRemainingAmount(total) {
      var paid = parseFloat($('#order_payed_amount').val() || 0);
      var remaining = total - paid;
      $('#order_remaining_amount').val(remaining.toFixed(2));
    }

    function updateOrderTotal() {
      var total = 0;
      $('input[id="order_item_price"]').each(function() {
        var price = parseFloat($(this).val()) || 0;
        total += price;
      });
      $('#order_total').val(total.toFixed(2));
      updateRemainingAmount(total);
    }

    document.querySelector('#new_order').addEventListener('submit', function() {
      debugger;
      document.getElementById("order_remaining_amount").disabled = false;
      document.getElementById("new_order").submit();
    });

});
// Preloader JS
$(window).on('turbolinks:load', function () {
    $('.preloader').fadeOut();
});