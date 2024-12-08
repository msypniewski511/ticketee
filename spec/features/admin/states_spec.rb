require "rails_helper"

RSpec.feature "Admins can manage states for tickets" do
  context "Admin users can" do
    before do
      login_as(FactoryBot.create(:user, :admin))
    end

    scenario "create states with valid details" do
      visit admin_root_path
      click_link "States"
      click_link "New State"

      fill_in "Name", with: "Won't Fix"
      fill_in "Color", with: "orange"
      click_button "Create State"

      expect(page).to have_content "State has been created."
    end

    context "update, delete states" do
      let!(:state) { FactoryBot.create(:state) }

      scenario "edit state with valid details" do
        visit admin_states_path
        within('li', text: "A state") do
          click_link "Edit State"
        end

        fill_in "Name", with: "new name"
        click_button "Update State"

        expect(page).to have_content "State has been updated."
      end

    end
  end
end
