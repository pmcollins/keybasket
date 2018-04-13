class RenterMailer < ActionMailer::Base

  def vacancy_notification(vacancy_notification, unit)
    contact = vacancy_notification.contact
    property = vacancy_notification.property
    moveout_notice = unit.rental_agreement.moveout_notice
    manager = vacancy_notification.property.manager
    @subject = "New vacancy at #{property.name}"
    @body = {
      :contact => contact,
      :unit => unit,
      :property => property,
      :moveout_notice => moveout_notice,
      :manager => manager
    }
    @recipients = ''
    @from = ''
    @sent_on = Time.now
    @headers = {}
  end

end
