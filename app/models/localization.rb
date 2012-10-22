class Localization < ActiveRecord::Base
  belongs_to :blurb
  belongs_to :locale
  belongs_to :published_version, :class_name => 'Version'
  has_many :versions

  validates_presence_of :blurb_id, :locale_id

  after_create :create_first_version
  
  # Scopes
  scope :ordered, joins(:blurb).order(:blurbs => :key)
  scope :in_locale, lambda { |locale| where(:locale_id => locale.id) }
  scope :in_locale_with_blurb, lambda { |locale| includes(:blurb).in_locale(locale).ordered }
  
  def alternates
    blurb.localizations.joins(:locale).where(:locales => { :enabled => true }).order(:locale => :key)
  end

  def as_json(options = nil)
    super :only => [:id, :draft_content], :methods => [:key]
  end

  def key
    blurb.key
  end

  def key_with_locale
    [locale.key, blurb.key].join('.')
  end

  def latest_version
    versions.last
  end

  def next_version_number
    versions.count + 1
  end
  
  def publish
    self.class.where(:id => self.id).publish
    reload
  end

  def project
    blurb.project
  end

  def revise(attributes = {})
    latest_version.revise attributes
  end
  
  def self.publish
    scoped.map do |s|
      latest = Version.uniq(:id).select([:id, :localization_id, :content]).where(:localization_id => s.id).order(:localization_id).reverse_order.order(:id).first
      where(:id => s.id).update_all(:published_version_id => latest.id, :published_content => latest.content)
    end
  end
  
  private

  def create_first_version
    versions.build(:content => draft_content).tap do |version|
      version.number = 1
      version.save!
    end
  end
end
