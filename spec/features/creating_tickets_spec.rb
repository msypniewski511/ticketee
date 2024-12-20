require "rails_helper"

RSpec.feature "Users can create new tickets" do
  let!(:state) { FactoryBot.create :state, name: "New", default: true }
  let(:user) { FactoryBot.create(:user) }
  before do
    login_as(user)
    project = FactoryBot.create(:project, name: "Internet Explorer")

    visit project_path project
    click_link "New Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Non-standar compilance"
    fill_in "Description", with: "My pages are ugly!"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."
    within(".ticket") do
      expect(page).to have_content "State: New"
      expect(page).to have_content "Author: #{user.email}"
    end
  end

  scenario "when providing invalid attributes" do
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Description can't be blank"
  end

  scenario "with an invalid description" do
    fill_in "Name", with: "Non-standard compilance"
    fill_in "Description", with: "It sucks"
    click_button "Create Ticket"

    expect(page).to have_content "Ticket has not been created."
    expect(page).to have_content "Description is too short"
  end

  scenario "with multiple attachments", js: true do
    fill_in "Name", with: "Add documentation for blink tag"
    fill_in "Description", with: "The blink tag has a speed attributte"

    attach_file("spec/fixtures/speed.txt", class: 'dz-hidden-input', visible: false)
    attach_file("spec/fixtures/gradient.txt", class: 'dz-hidden-input', visible: false)
    attach_file("spec/fixtures/spin.txt", class: 'dz-hidden-input', visible: false)

    click_button "Create Ticket"

    expect(page).to have_content "Ticket has been created."

    within(".ticket .attachments") do
      expect(page).to have_content "speed.txt"
      expect(page).to have_content "gradient.txt"
      expect(page).to have_content "spin.txt"
    end
  end
end
