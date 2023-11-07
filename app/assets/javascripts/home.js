(function() {


    // 绑定事件到继续购物按钮
    $('#continue-shopping').on('click', function() {
      // 刷新页面
      location.reload();
    });

  // 购物车
    $('.add-to-cart-btn').on('click', function() {
      var $this = $(this),
          $stock = $('input[name="stock"]'),
          $prog = $this.find('i');

      if ($stock.length > 0 && parseInt($stock.val()) <= 0) {
        alert("购买数量至少为 1");
        return false;
      }

      $.ajax({
        url: $this.attr('href'),
        method: 'post',
        data: { ticket_id: $this.data('ticket-id'), stock: $stock.val() },
        beforeSend: function() {
          if (!$prog.hasClass('fa-spin')) {
            $prog.addClass('fa-spin');
          }
          $prog.show();
        },
        statusCode: {
          401: function() {
            // 如果用户未授权，则重定向到登录页
            window.location.href = '/users/sign_in'; // 假设 '/sign_in' 是登录页面的路径
          }
        },
        success: function(data) {
          if ($('#order_modal').length > 0) {
            $('#order_modal').remove();
          }
          $('body').append(data);
          $('#order_modal').modal();
        },
        complete: function() {
          $prog.hide();
        },
        error: function(xhr) {
          if (xhr.status === 422) {
            var error = JSON.parse(xhr.responseText);
            alert(error.error); // 这将显示错误消息
          }
        }
      })

      return false;
    })

  })()
  