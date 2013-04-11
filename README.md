# ActiveRecordUUIDAsPK

`activerecord_uuid_as_pk` is a extension for ActiveRecord to enable to use uuid for `id` attribute (**v1.0.0 tested only MySQL**).


## Installation

Add this line to your application's Gemfile:

    gem 'activerecord_uuid_as_pk'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord_uuid_as_pk


## Usage

1. In a migration file, prevent generate id column and add uuid column (tinyblob).

        class CreateUsers < ActiveRecord::Migration
            def up
                create_table :users, :id => false do |t|
                    t.column :uuid, :tinyblob
                    t.string :user_name
                end
                execute "ALTER TABLE users ADD PRIMARY KEY (`uuid`(16))"
            end
            def down
                drop_table :users
            end
        end

2. Call `uuid_as_primary_key` method in a model class.

        class User < ActiveRecord::Base
            uuid_as_primary_key
        end

3. The `uuid_as_primary_key` method hooks `before_create` callback to set automatically generated uuid as 16 byte binary data to id attirbute.  And this method adds `#formatted_id` to the model to refer formatted uuid.

        user = User.create(:user_name => "foo")
        user.id  #=> "3~\x05v\xCBfAQ\xA2\xE1\xE0\xFC\x04\xFB3\xD1"
        user.formatted_id  #=> "337e0576-cb66-4151-a2e1-e0fc04fb33d1"

4. Of course you can set arbitrary uuid if you set 16 byte binary, a formatted uuid string or UUIDTools::UUID object to `id` attribute.  A formatted uuid string and UUIDTools::UUID object will be converted 16 byte binary data when you save a model.

        user1 = User.create(:id => UUIDTools::UUID.parse("f311427a-954c-46f5-92df-3d37f56b5b41").raw, :user_name => "user1")
        user1.formatted_id
            #=> "f311427a-954c-46f5-92df-3d37f56b5b41"
        user2 = User.create(:id => "206b38d7-3b5f-4645-b5b2-5e7efea1d3ca", :user_name => "user2")
        user2.formatted_id
            #=> "206b38d7-3b5f-4645-b5b2-5e7efea1d3ca"
        user3 = User.create(:id => UUIDTools::UUID.parse("c81836c5-309a-4608-bf1a-5fe343081a92"), :user_name => "user3")
        user3.formatted_id
            #=> "c81836c5-309a-4608-bf1a-5fe343081a92"

5. The `uuid_as_primary_key` method also adds `find_by_formatted_id` class method to retrive model from data store with a formatted uuid string.

        User.find_by_formatted_id("337e0576-cb66-4151-a2e1-e0fc04fb33d1")


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
