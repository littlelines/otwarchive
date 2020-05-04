# frozen_string_literal: true
require "spec_helper"

describe Admin::UserCreationsController do
  include LoginMacros
  include RedirectExpectationHelper

  describe "GET #hide" do    
    let(:admin) { create(:admin) }
    let(:work) { create(:work) }

    context 'when admin does not have correct authorization' do
      it "denies random admin access" do
        admin.update(roles: [])
        fake_login_admin(admin)
        get :hide, params: { id: work.id, creation_type: 'Work' }
        it_redirects_to_with_error(root_url, "Sorry, only an authorized admin can access the page you were trying to reach.")
      end
    end

    context 'when admin does have correct authorization' do
      it "allows admin with authorization to hide user_creation" do
        admin.update(roles: ['policy_and_abuse'])
        fake_login_admin(admin)
        get :hide, params: { id: work.id, creation_type: 'Work', hidden: true }

        it_redirects_to_with_notice(work_path(work), "Item has been hidden.")
        work.reload
        expect(work.hidden_by_admin).to eq(true)
      end
    end
  end

  describe "GET #set_spam" do
    
  end

  describe "GET #destroy" do
    
  end

  # describe "POST #create" do
  #   before { fake_login_admin(create(:admin, roles: ["communications"])) }

  #   let(:base_params) { { title: "AdminPost Title",
  #                         content: "AdminPost content long enough to pass validation" } }

  #   context "when admin post is valid" do
  #     it "redirects to post with notice" do
  #       post :create, params: { admin_post: base_params }
  #       it_redirects_to_with_notice(admin_post_path(assigns[:admin_post]), "Admin Post was successfully created.")
  #     end
  #   end

  #   context "when admin post is invalid" do
  #     context "with invalid translated post id" do
  #       it "renders the new template with error message" do
  #         post :create, params: { admin_post: { translated_post_id: 0 } }.merge(base_params)
  #         expect(response).to render_template(:new)
  #         expect(assigns[:admin_post].errors.full_messages).to include("Translated post does not exist")
  #       end
  #     end
  #   end
  # end



end
