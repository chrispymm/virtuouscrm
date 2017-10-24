RSpec.describe Virtuous::Relationship do

    describe "#find_by_contact" do
        let(:contact_id) { 33 }
        let(:nonexistant_id)  { 0000 }

        it "return a relationship object" do
            VCR.use_cassette("relationship") do
                @relationship = Virtuous::Relationship.find_by_contact(contact_id)
            end
            # expect(@relationship).to be_instance_of Virtuous::Relationship
            expect(@relationship).to be_a Array
        end

        # it "returns a relationship matching id" do
        #     VCR.use_cassette("relationship") do
        #         @relationship = Virtuous::Relationship.find_by_contact(contact_id)
        #     end
        #     expect(@relationship.id).to eq(contact_id)
        # end

        it "returns status 200" do 
            VCR.use_cassette("relationship_not_found", :match_requests_on => [:method] ) do
                @relationship = Virtuous::Relationship.find_by_contact(nonexistant_id)
            end
            expect(@relationship).to be_a Array
        end        

    end

    describe "#types" do
        it "returns an array of contact relationship types" do 
            VCR.use_cassette("relationship") do
                @relationship_types = Virtuous::Relationship.types
            end
            expect(@relationship_types).to be_a Array
        end
    end   

    describe "#update" do
        let(:contact_id) {2526}
        let(:attributes) { { relationshipType: "General", notes: "A note for relationshiptypes" } }

        it "requres attributes" do 
            expect {
                @relationship = Virtuous::Relationship.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        # it "returns the relationship record" do 
        #     VCR.use_cassette("relationship_update") do
        #         @relationship = Virtuous::Relationship.update(contact_id, attributes)
        #     end
        #     expect(@relationship).to be_instance_of Virtuous::Relationship          
        #     expect(@relationship.id).to eq(contact_id) 
        # end

        # it "updates the attributes" do 
        #     VCR.use_cassette("relationship_update") do
        #         @relationship = Virtuous::Relationship.update(contact_id, attributes)
        #     end
        #     expect(@relationship.city).to eq(attributes[:city])          
        # end

    end



end