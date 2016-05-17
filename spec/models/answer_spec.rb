# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Answer, type: :model do
  let(:question) {Question.create!(title: "New Question title", body: "New Question Body", resolved: true)}
  let(:answer) { Answer.create!(body: "New Answer Body", question: question) }


  describe "attributes" do
    it "has a body attribute" do
      expect(answer).to have_attributes(body: "New Answer Body")
    end
  end

end
