require "spec_helper"

describe InvitationsController do
  include LoginMacros
  include RedirectExpectationHelper

  let(:admin) { create(:admin) }
  let(:user) { create(:user) }

  describe "GET #index" do
    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :index, params: { user_id: user.login }
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin has correct authorization' do
      it "allows admins to access index" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :index, params: { user_id: user.login }
        expect(response).to render_template("index")
      end
    end
  end

  describe "GET #manage" do
    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :manage, params: { user_id: user.login }
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin has correct authorization' do
      it "allows admins to access index" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :manage, params: { user_id: user.login }
        expect(response).to render_template("manage")
      end
    end
  end
end
