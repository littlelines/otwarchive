# frozen_string_literal: true
require "spec_helper"

describe Admin::AdminUsersController do
  include LoginMacros
  include RedirectExpectationHelper

  describe "GET #index" do
    let(:admin) { create(:admin) }
 
    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :index
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin has correct authorization' do
      it "allows admins to access index" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #bulk_search" do
    let(:admin) { create(:admin) }
 
    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :bulk_search
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin has correct authorization' do
      it "allows admins to access index" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :bulk_search
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "GET #show" do
    let(:admin) { create(:admin) }
    let(:user) { create(:user) }

    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :show, params: { id: user.login }
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin has correct authorization' do
      it "allows admins to access index" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :show, params: { id: user.login }
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #update" do
      let(:admin) { create(:admin) }
      let(:user) { create(:user) }
  
      context 'when admin does not have correct authorization' do
        it "denies random admin access" do
          admin.update(roles: [])
          fake_login_admin(admin)
          get :update, params: { id: user.login, user: { roles: [] } }
          it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
        end
      end
  
      context 'when admin has correct authorization' do
        role = FactoryBot.create(:role)

        # it "allows admins to access index" do
        #   admin.update(roles: ['policy_and_abuse'])
        #   fake_login_admin(admin)
        #   get :update, params: { id: user.login, user: { roles: [role.id.to_s] } }
        #   expect(user.roles.include?(role)).to be_truthy
        # end
      end
    end

    # describe "GET #update_status" do
    #   let(:admin) { create(:admin) }
    #   let(:user) { create(:user) }
  
    #   context 'when admin does not have correct authorization' do
    #     it "denies random admin access" do
    #       admin.update(roles: [])
    #       fake_login_admin(admin)
    #       get :update, params: { id: user.login, admin_action: 'suspend', suspend_days: '3' }
    #       it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
    #     end
    #   end
  
    #   context 'when admin has correct authorization' do
    #     it "allows admins to access index" do
    #       admin.update(roles: ['policy_and_abuse'])
    #       fake_login_admin(admin)
    #       get :update, params: { id: user.login, user: { admin_action: 'suspend', suspend_days: '3' } }
    #       expect(user.suspended).to be_truthy
    #     end
    #   end
    # end


  end
end
