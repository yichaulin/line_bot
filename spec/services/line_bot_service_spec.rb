require "rails_helper"

describe "LineBotService", :type => :services do
  let(:klass) {LineBotService}
  let(:event) do 
    {"replyToken"=>"00000000000000000000000000000000", "type"=>"message", "timestamp"=>1451617200000, "source"=>{"type"=>"user", "userId"=>"Udeadbeefdeadbeefdeadbeefdeadbeef"}, "message"=>{"id"=>"100001", "type"=>"text", "text"=>"Hello,world"} }
  end

  describe "sticker_object" do
    it "should return sticker object" do
      obj = klass.new(event).sticker_object

      expect(obj[:type]).to eq('sticker')
      expect(obj[:stickerId]).not_to be_nil
      expect(obj[:packageId]).not_to be_nil
    end
  end
end
