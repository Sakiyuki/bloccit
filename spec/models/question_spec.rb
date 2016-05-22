# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  resolved   :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { Question.create!(title: "New Question Title", body: "New Question Body", resolved: true)}

  describe "attributes" do
    it "has title, body and resolved" do
      expect(question).to have_attributes(title: "New Question Title", body: "New Question Body", resolved: true)
    end
  end
end
