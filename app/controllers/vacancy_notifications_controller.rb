class VacancyNotificationsController < ApplicationController

  before_filter :find_property

  def create
    VacancyNotification.transaction do
      contact = Contact.create(params[:contact])
      vacancy_notification = VacancyNotification.create(
        :contact_id => contact.id,
        :property_id => @property.id
      )
      vacancy_notification.floor_plan_ids = params[:floor_plan_ids]
    end
    redirect_to ''
  end

end
