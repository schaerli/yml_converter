require 'csv'
require 'yaml'
require 'roo'
require 'tempfile'

class Xlsx < ActiveRecord::Base
  self.table_name = :xlsxs

  belongs_to :order

  mount_uploader :xls, YmlUploader

  
  def self.create_from_xls(file)
    @translations = {}
      
    xls_file = ::Roo::Excel.new(file.first)
  
    tmp_file = Tempfile.new('foo')
    tmp_file.write(xls_file.to_csv)
    tmp_file.rewind

    column_index_to_get_values_from = 2
    CSV.parse(tmp_file, col_sep: ',')[1..-1].each do |row|
   
      locale_key, value = row[0, column_index_to_get_values_from]
     
      next if locale_key.blank?
      puts "  - Value blank for locale_key: #{locale_key}" if value.blank?
     
      add_translation(locale_key, value)
    end

    File.write("translated.yml", @translations.to_yaml, encoding: 'utf-8')

    buffer = StringIO.new
    buffer << @translations.to_yaml
    buffer.rewind

    buffer
  end

  def self.translation_hash(key_segments)
    storage_hash = @translations
   
    key_segments[0..-2].each do |key_segment|
      storage_hash = storage_hash.fetch(key_segment) { |key| storage_hash[key_segment] = {} }
    end
   
    storage_hash
  end

  def self.add_translation(locale_key, value)
    key_segments = locale_key.split('.')
    translation_hash(key_segments)[key_segments.last] = value
  end

end