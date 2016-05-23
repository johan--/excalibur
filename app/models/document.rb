class Document < ActiveRecord::Base
  include WannabeBool::Attributes
  include RefreshSlug
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged  
  protokoll :ticker, :pattern => "DOC%y####%m"
  belongs_to :owner, polymorphic: true
  
  attr_accessor :image_id
  store_accessor :details, 
  					:public_id, :bytes, :state, :doc_type,
  					:checked, :flagged
  
  attr_wannabe_bool :checked, :flagged

  # Pagination
  paginates_per 30

  cattr_accessor :categories do
    %w(identitas penghasilan pengeluaran kepemilikan)
  end
  
  # validates :public_id, :presence => true
  
  before_create :set_default
  after_create :refresh_friendly_id!
  
  scope :verifieds, -> { 
    where("documents.details->>'state' = :state", state: "verified") 
  }    
  scope :by_types, ->(doc_type) { 
    where("documents.details->>'doc_type' = :type", type: doc_type) 
  }
  scope :identities, -> { 
    where("documents.details->>'doc_type' = :type", type: "identitas") 
  }
  scope :incomes, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti penghasilan") 
  }
  scope :expenses, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti pengeluaran") 
  }
  scope :collaterals, -> { 
    where("documents.details->>'doc_type' = :type", type: "bukti kepemilikan") 
  }
  def transitioning!
    # if self.checked? &&  self.flagged?
    #   self.state_machine.transition_to!(:dropped)
    # else
    #   if self.checked?
    #     self.state_machine.transition_to!(:verified)
    #   elsif self.flagged?
    #     self.state_machine.transition_to!(:flagged)
    #   elsif !self.checked? &&  !self.flagged?
    #     self.state_machine.transition_to!(:uploaded)
    #   end
    # end
  end

  cattr_accessor :identity_proofs do
    ["KTP", "SIM," "Passport", "NPWP", "Kartu Keluarga"]
  end
  cattr_accessor :earning_proofs do
    ["Slip Gaji", "Surat Keterangan Masa Kerja", 
      "Laporan Keuangan Bisnis", "Akta Perusahaan", "SIUP", "TDP",
      "Surat Izin Praktek", "Sertifikat Profesi"]
  end
  cattr_accessor :expense_proofs do
    ["Buku Tabungan", "Bukti Bayar Listrik", "Lain-lain"]
  end
  cattr_accessor :collateral_proofs do
    ["BPKB", "Girik", "SHGB", "SHGB", "SHM"]
  end      
  # def identity_proof
  #   ["KTP", "SIM", "Passport", "NPWP", "Kartu Keluarga"]
  # end

  def earning_proof
  end

  def expense_proof
  end

  def collateral_proof
    
  end

private
  def slug_candidates
    [ :ticker ]
  end

  def set_default
    self.checked = 'no'
    self.flagged = 'no'
    self.state = 'new'
    self.category = check_category
  end

  def check_category
    if self.identity_proofs.include? self.doc_type
      return 'identitas'
    elsif  self.earning_proofs.include? self.doc_type
      return 'penghasilan'
    elsif  self.expense_proofs.include? self.doc_type
      return 'pengeluaran'
    elsif  self.collateral_proofs.include? self.doc_type
      return 'kepemilikan'
    end
  end

end