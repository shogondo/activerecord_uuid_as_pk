require "activerecord_uuid_as_pk"
require "rails"


module ActiveRecordUUIDAsPK

  class Railtie < Rails::Railtie

    initializer "activerecord_uuid_as_pk.initialize" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, ActiveRecordUUIDAsPK
      end
    end

  end

end
