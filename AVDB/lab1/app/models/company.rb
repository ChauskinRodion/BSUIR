class Company < ActiveRecord::Base
  belongs_to :head_company ,class_name: :Company, foreign_key: :head_company_id
  belongs_to :chief, class_name: :Person, foreign_key: :chief_id
  belongs_to :accountant, class_name: :Person, foreign_key: :accountant_id


end
