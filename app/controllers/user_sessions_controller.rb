class UserSessionsController < ApplicationController

  def create
    us = params[:user_session]
    login = Login.authenticate(us[:name], us[:password])
    if login
      user_session = login.user_sessions.create(
        :logged_in_at => DateTime.now,
        :remote_ip => request.remote_ip
      )
      session[:user_session] = user_session #save the record for logouts
      session[:login_id] = login.id
      session[:username] = login.name
      if login.administrator
        administrator = login.administrator
        session[:admin_id] = administrator.id
        session[:contact_id] = administrator.contact_id
        redirect_to '/companies'
      elsif login.coordinator
        coordinator = login.coordinator
        company_id = coordinator.company_id
        session[:coordinator_id] = coordinator.id
        session[:company_id] = company_id
        session[:contact_id] = coordinator.contact_id
        redirect_to("/companies/#{company_id}")
      elsif login.manager
        manager = login.manager
        company_id = manager.company_id
        session[:manager_id] = manager.id
        session[:company_id] = company_id
        session[:property_ids] = manager.properties.map{|p| p.id}
        session[:contact_id] = manager.contact_id
        redirect_to "/companies/#{company_id}/managers/#{manager.id}"
      end
    else
      flash[:notice] = 'Login failed'
      redirect_to '/'
    end
  end

  def destroy
    session[:user_session].update_attributes(
      :logged_out_at => DateTime.now
    )
    session.delete
    flash[:notice] = 'You have logged out.'
    redirect_to '/'
  end

  def index
    @user_sessions = UserSession.find :all
  end

end
