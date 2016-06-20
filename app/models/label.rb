# == Schema Information
#
# Table name: labels
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Label < ActiveRecord::Base
# #3
  has_many :labelings
# #4
  has_many :topics, through: :labelings, source: :labelable, source_type: :Topic
# #5
  has_many :posts, through: :labelings, source: :labelable, source_type:  :Post

  def self.update_labels(label_string)
    return Label.none if label_string.blank?
    label_string.split(",").map do |label|
      Label.find_or_create_by(name: label.strip)
    end
  end
end
