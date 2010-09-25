require File.dirname(__FILE__) + '/../spec_helper'

describe Asset do
  
  before do
    @asset = create_asset
  end

  it "is valid" do
    @asset.should be_valid
  end
  
  it "responds to named scope by_title" do
    Asset.respond_to?(:by_title).should be_true
  end
  
private
  def create_asset(options = {})
    @asset = Asset.new({:caption => 'test_caption', :title => 'test_title', :asset_file_name => 'test_asset_file_name', :asset_content_type => 'test_asset_content_type'}.merge(options))
    @asset.save
    @asset
  end
end
