class Enfant < ApplicationRecord
  extend FriendlyId
  friendly_id :nom_et_prénom, use: :slugged

  audited
  
  belongs_to :compte, counter_cache: true
  belongs_to :classroom
  belongs_to :tarif_type

  has_one :organisation, through: :compte

  has_many :reservations, dependent: :destroy
  has_many :absences
  has_many :prestations

  accepts_nested_attributes_for :reservations, reject_if: proc { |attributes| attributes[:prestation_type_id].blank? or attributes[:début].blank? or attributes[:fin].blank?}, allow_destroy: true

  default_scope { order(Arel.sql('enfants.nom, enfants.prénom')) }

  self.per_page = 10

  def nom_et_prénom
    "#{self.nom} #{self.prénom}"
  end

  def prénom_et_nom
    "#{self.prénom} #{self.nom}"
  end

end