require 'tabledata'
require 'spreadsheet'

class Yml < ActiveRecord::Base
  self.table_name = :ymls

  belongs_to :order

  mount_uploader :yml, YmlUploader
  
  def self.create_from_yml(file)
    yml                 = ::YAML.load(File.open(file))
    @locale             = yml.keys[0]
    hash_without_locale = yml.values[0]

    xls = rebuild_(hash_without_locale)

    export_in_xls(xls)
  end

  def self.import_from_more_yaml(files)
    xls = {}
    files.each do |f|
      yml                 = ::YAML.load( File.open(f) )
      @locale             = yml.keys[0]
      hash_without_locale = yml.values[0]

      if @locale === "de-CH"
        xls.merge!( rebuild_(hash_without_locale) )
      end
    end
    
    export_in_xls(xls)
  end  

  def self.export_in_xls(export)
    sheet_name                   = @locale
    Spreadsheet.client_encoding  = 'UTF-8'
    book                         = Spreadsheet::Workbook.new
    sheet1                       = book.create_worksheet
    sheet1.name                  = sheet_name
    sheet1.row(0).height         = 18
    format                       = Spreadsheet::Format.new(color: :black, weight: :bold, size: 12)
    sheet1.row(0).default_format = format


    sheet1.row(0).concat ["Key", "#{sheet_name}"]

    i = 0
    export.each do |key, value|
      sheet1.row(i+1).push key, value
      i += 1
    end

    # binding.pry
    buffer = StringIO.new
    book.write(buffer)
    buffer.rewind

    buffer
    # book.write "i18n-unstranslated-#{Time.zone.now.day}-#{Time.zone.now.month}-#{Time.zone.now.year}.xls"
  end
  
  def self.rebuild_(hash)
    result = {}
    recursive_rebuild_(hash, result, [])

    result
  end

  def self.recursive_rebuild_(hash, result, stack)
    hash.each do |key, value|
      case value
        when Hash # not a Leaf
          recursive_rebuild_(value, result, stack+[key])
        else # Leaf value
          result[(stack+[key]).join('.')] = value
      end
    end
  end  

  def self.rebuild(hash)
    result = {}
    recursive_rebuild(hash, result, [])

    result
  end  

  def self.recursive_rebuild(hash, result, stack)
    hash.each do |key, value|
      case value
        when Hash # not a Leaf
          recursive_rebuild(value, result, stack+[key])
        when Array # Leaf, with many values
          final_stack = stack+[key]
          value.each do |leaf|
            result[leaf] = final_stack
          end
        else # Leaf value
        result[value] = stack+[key]
      end
    end
  end

end
