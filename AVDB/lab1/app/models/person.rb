class Person < ActiveRecord::Base
  belongs_to  :mother,    class_name: :Person, foreign_key: :mother_id
  belongs_to  :father,    class_name: :Person, foreign_key: :father_id
  has_one     :spouse,    class_name: :Person, foreign_key: :spouse_id

  enum sex: [:male, :female]

  def children
    Person.where("father_id = ? or mother_id = ?", self.id, self.id)
  end


end
