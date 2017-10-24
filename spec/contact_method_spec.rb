
RSpec.describe Virtuous::ContactMethod do

    describe "#types" do
        it "returns an array of contact method types" do 
            VCR.use_cassette("contact_method") do
                @contact_method = Virtuous::ContactMethod.types
            end
            expect(@contact_method).to be_a Array
        end
    end     

    describe "#related_types" do
        let(:contact_method) { "email" }
        it "returns a string of the related type" do 
            VCR.use_cassette("contact_method") do
                @contact_method = Virtuous::ContactMethod.related_types(contact_method)
            end
            expect(@contact_method).to be_a Array
        end
    end  

    describe "#find_contact_method" do
        let(:contact_id) { 3306 }
        it "returns a hash" do
            VCR.use_cassette("contact_method") do
                @contact_method = Virtuous::ContactMethod.find(contact_id)
            end 
            # expect(@contact_method).to be_instance_of Virtuous::ContactMethod
            expect(@contact_method).to be_a Hash
        end
    end

    describe "#update_contact_method" do
        let(:contact_id) { 4699 } #ContactMethodID for ContactID 2526 (Chris Pymm)
        let(:attributes) {{ type: "Home Email", value: "chris@adozeneggs.co.uk", isOptedIn: true }} 

        it "requires_attributes" do
            expect {
                @contact_method_update = Virtuous::ContactMethod.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        it "returns the contact method" do
            VCR.use_cassette("contact_method_update") do
                @contact_method = Virtuous::ContactMethod.update(contact_id, attributes)
            end
            expect(@contact_method).to be_instance_of Virtuous::ContactMethod          
            expect(@contact_method.id).to eq(contact_id) 
        end

    end

    #Not testing the Creation Method

end
