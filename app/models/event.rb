class Event < ActiveRecord::Base
  has_many :people, :through => :roles, :dependent => :destroy
  has_many :roles, :dependent => :destroy

  def self.import_logo(image, event)
    extension = image.original_filename.split('.').last.downcase
    filename = sanitize_filename("#{event}_logo.#{extension}")

    File.open(Rails.root.join('public', 'documents', filename), 'wb') do |file|
      file.write(image.read)
    end

    filename # Return so transactional logic in controller can complete & save filename to database
  end

  private

  def self.sanitize_filename(filename)
    filename.gsub!(/^.*(\\|\/)/, '')
    filename.gsub!(/[^0-9A-Za-z.\-]/, '_')
  end
end
