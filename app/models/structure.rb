class Structure < ApplicationRecord
  audited

  belongs_to :organisation, inverse_of: :structures

  has_many :classrooms, inverse_of: :structure
  accepts_nested_attributes_for :classrooms, reject_if: proc { |attributes| attributes[:nom].blank? }, allow_destroy: true

  has_many :comptes

  validates :nom, presence: true
  validates_uniqueness_of :nom, scope: [:organisation_id]

  default_scope { order(Arel.sql('structures.nom')) }

  def nom_avec_organisation
    self.organisation.nom + "/" + self.nom 
  end

end