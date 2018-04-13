require "#{File.dirname(__FILE__)}/../test_helper"

class WorkingLinksTest < ActionController::IntegrationTest

  fixtures :logins, :companies, :properties, :units, :addresses,
    :contacts, :managers, :coordinators, :phones, :manager_properties,
    :reports, :account_types, :accounts, :account_updates

  def test_coordinator_links
    post_via_redirect(
      '/user_sessions',
      :user_session => {
        :name => 'sindy',
        :password => 'upiy88'
      }
    )
    assert_response :success
    assert_equal('/companies/1', path)
    @tested_coordinator_paths = {path => true}
    get path
    assert_response :success
    check_all_page_links(@tested_coordinator_paths)
  end

  def test_manager_links
    post_via_redirect(
      '/user_sessions',
      :user_session => {
        :name => 'shosheleh',
        :password => '4223cclj'
      }
    )
    assert_response :success
    @tested_manager_paths = {path => true}
    get path
    assert_response :success
    check_all_page_links(@tested_manager_paths)
  end

  def check_all_page_links(tested_paths)
    find_all_tag(:tag => 'a').each do |tag|
      url = tag.attributes['href']
      next unless url
      next if url =~ /user_sessions/
      next if tested_paths[url]
      puts "get #{url}"
      get url
      tested_paths[url] = true
      assert_response :success
      check_all_page_links(tested_paths)
    end
  end

end
