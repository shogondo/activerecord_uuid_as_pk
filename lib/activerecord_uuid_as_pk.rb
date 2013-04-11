require "uuidtools"
require "activerecord_uuid_as_pk/version"


module ActiveRecordUUIDAsPK

  require "activerecord_uuid_as_pk/railtie" if defined?(Rails)


  def self.included(base)
    base.send :extend, ClassMethods
  end


  module ClassMethods

    def uuid_as_primary_key()
      self.primary_key = "uuid"

      define_method "formatted_id" do
        return self.id.present? ? UUIDTools::UUID.parse_raw(self.id).to_s : nil
      end

      define_method "hex_id" do
        return self.id.present? ? UUIDTools::UUID.parse_raw(self.id).hexdigest : nil
      end

      before_create do
        if self.id.nil?
          self.id = UUIDTools::UUID.timestamp_create.raw
        elsif self.id.is_a?(UUIDTools::UUID)
          self.id = self.id.raw
        elsif self.id.is_a?(String)
          if self.id.size != 16
            if self.id =~ /^([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{2})([0-9a-f]{2})-([0-9a-f]{12})$/
              self.id = UUIDTools::UUID.parse(self.id).raw
            else
              self.id = UUIDTools::UUID.timestamp_create.raw
            end
          end
        else
          self.id = UUIDTools::UUID.timestamp_create.raw
        end
      end

      (class << self; self end).class_eval do

        define_method "find_by_formatted_id" do |uuid|
          raw_uuid = UUIDTools::UUID.parse(uuid).raw
          return self.find_by_uuid(raw_uuid)
        end

      end
    end

  end

end
