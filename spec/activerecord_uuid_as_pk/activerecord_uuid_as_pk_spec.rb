require "spec_helper"


describe ActiveRecordUUIDAsPK, ".find_by_formatted_id" do

  before do
    uuid = UUIDTools::UUID.parse("488995f0-a0b4-11e2-9e96-0800200c9a66")
    Account.create!(:id => uuid.raw, :name => "user1")
  end


  it "returns a found model" do
    o = Account.find_by_formatted_id("488995f0-a0b4-11e2-9e96-0800200c9a66")
    o.name.should == "user1"
  end


  it "returns nil when no model found" do
    o = Account.find_by_formatted_id("dba654cd-c798-483b-9eff-a0e68ce10846")
    o.should be_nil
  end

end


describe ActiveRecordUUIDAsPK, "#before_create" do

  context "when uuid is set UUIDTools::UUID" do
    it "converts the uuid to raw" do
      uuid = UUIDTools::UUID.parse("28316607-02d0-4069-917a-8c29b25674d4")
      o = Account.create!(:id => uuid, :name => "user1")
      o.id.should == uuid.raw
    end
  end


  context "when uuid is set raw uuid string" do
    it "does nothing" do
      uuid = UUIDTools::UUID.parse("ec9621be-5293-4f35-aa27-f993c754ec5c")
      o = Account.create!(:id => uuid.raw, :name => "user1")
      o.id.should == uuid.raw
    end
  end


  context "when uuid is set uuid format string" do
    it "converts the uuid string to raw" do
      o = Account.create!(:id => "5864d76a-2738-415d-9e76-87326ae9d73d", :name => "user1")
      o.id.should == UUIDTools::UUID.parse("5864d76a-2738-415d-9e76-87326ae9d73d").raw
    end
  end


  context "when uuid is set other string" do
    it "generates a new uuid" do
      uuid = UUIDTools::UUID.parse("a7b62e8f-02ea-4ee2-adbd-ce579e2a1ab2")
      UUIDTools::UUID.stub(:timestamp_create).and_return(uuid)
      o = Account.create!(:id => "other_string", :name => "user1")
      o.id.should == uuid.raw
    end
  end


  context "when uuid is neither Stirng nor UUIDTools::UUID" do
    it "generates a new uuid" do
      uuid = UUIDTools::UUID.parse("3acab61b-1dbc-4636-8aa5-726a777b64b7")
      UUIDTools::UUID.stub(:timestamp_create).and_return(uuid)
      o = Account.create!(:id => 1, :name => "user1")
      o.id.should == uuid.raw
    end
  end


  context "when uuid is nil" do
    it "generates a new uuid" do
      uuid = UUIDTools::UUID.parse("a7b62e8f-02ea-4ee2-adbd-ce579e2a1ab2")
      UUIDTools::UUID.stub(:timestamp_create).and_return(uuid)
      o = Account.create!(:id => nil, :name => "user1")
      o.id.should == uuid.raw
    end
  end

end


describe ActiveRecordUUIDAsPK, "#formatted_id" do

  context "when uuid is set value" do
    it "returns a uuid string" do
      o = Account.create!(:id => "71366243-a184-418f-bce1-3d1f5c28d669")
      o.formatted_id.should == "71366243-a184-418f-bce1-3d1f5c28d669"
    end
  end


  context "when uuid is nil" do
    it "returns nil" do
      o = Account.new
      o.formatted_id.should be_nil
    end
  end

end


describe ActiveRecordUUIDAsPK, "#hex_id" do

  context "when uuid is set value" do
    it "returns a uuid string" do
      uuid = UUIDTools::UUID.parse("a3ea6c43-3971-426f-b488-99c5d141bce5")
      o = Account.create!(:id => uuid.to_s)
      o.hex_id.should == uuid.hexdigest
    end
  end


  context "when uuid is nil" do
    it "returns nil" do
      o = Account.new
      o.hex_id.should be_nil
    end
  end

end
