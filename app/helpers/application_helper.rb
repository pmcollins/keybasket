module ApplicationHelper

  def breadcrumbs(object_list)
    bc = []
    path = ''
    #TODO clean this up
    object_list.each do |thing|
      if thing.respond_to? :partial_path
        path += thing.partial_path
        bc.push([thing.to_s, path])
      elsif thing.class == Array
        namespace = thing[0].pluralize
        record = thing[1]
        name = record.to_s
        partial_path = "/#{namespace}/#{record.id}"
        path += partial_path
        bc.push([name, path])
      else
        bc.push(thing)
      end
    end
    '<p class="breadcrumbs">' + render(
      :partial => '/helpers/breadcrumb',
      :collection => bc,
      :spacer_template => '/helpers/breadcrumb_spacer'
    ) + '</p>'
  end

  def m(object_list)
    out = ''
    object_list.each do |thing|
      if thing.respond_to? :partial_path
        out += thing.partial_path
      else
        out += "/#{thing}"
      end
    end
    out
  end

  def user_bar
    return unless session[:contact_id]
    if session[:contact_id]
      return render(
        :partial => '/helpers/contact_bar',
        :object => Contact.find(session[:contact_id])
      )
    end
  end

  def link_to_transfer(transfer)
    if transfer.class == PurchaseOrderApproval
      po = transfer.purchase_order
      return link_to(
        'PurchaseOrder',
        purchase_order_path(
          :company_id => @company.id,
          :vendor_id => po.vendor.id,
          :id => po.id
        )
      )
    else
      return transfer.class
    end
  end

  def nvl(thing, msg='empty')
    thing || "<span class=\"empty\">#{msg}</span>"
  end

end
