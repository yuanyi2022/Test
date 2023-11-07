module ApplicationHelper
def show_add_to_order ticket, options = {}
html_class = "btn btn-danger add-to-cart-btn"
    html_class += " #{options[:html_class]}" unless options[:html_class].blank?

    link_to "<i class='fa fa-spinner'></i> 购买".html_safe, orders_path, class:html_class, 'data-ticket-id': ticket.id
  end
end
