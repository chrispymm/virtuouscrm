RSpec.describe Virtuous::ContactIndividual do


    describe "#find" do
        let(:contact_id) { 33 }
        let(:nonexistant_id)  { 0000 }

        it "return a contact individual object" do
            VCR.use_cassette("contact_individual") do
                @contact_individual = Virtuous::ContactIndividual.find(contact_id)
            end
            expect(@contact_individual).to be_instance_of Virtuous::ContactIndividual
        end

        it "returns a contact individual matching id" do
            VCR.use_cassette("contact_individual") do
                @contact_individual = Virtuous::ContactIndividual.find(contact_id)
            end
            expect(@contact_individual.id).to eq(contact_id)
        end

        it "errors if the contact doesn't exist" do
            expect {
                VCR.use_cassette("contact_not_found") do
                    @contact_individual = Virtuous::ContactIndividual.find(nonexistant_id)
                end
            }.to raise_error Virtuous::Error
        end

    end

    # RETURNS JUST an ERROR? 400 check contact_individual.rb
    describe "#update" do
        let(:contact_id) {2526}
        let(:attributes) { { prefix: "Mr", suffix: "CP" } }

        it "requires attributes" do 
            expect {
                @contact_individual = Virtuous::ContactIndividual.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        # it "returns the contact individual record" do 
        #     VCR.use_cassette("contact_individual_update") do
        #         @contact_individual = Virtuous::ContactIndividual.update(contact_id, attributes)
        #     end
        #     expect(@contact_individual).to be_instance_of Virtuous::ContactIndividual          
        #     # expect(@contact_individual.id).to eq(contact_id) 
        # end

        # it "updates the attributes" do 
        #     VCR.use_cassette("contact_individual_update") do
        #         @contact_individual = Virtuous::ContactIndividual.update(contact_id, attributes)
        #     end
        #     expect(@contact_individual.suffix).to eq(attributes[:suffix])          
        # end

    end


    describe "#find_by_contact" do
        let(:contactId) {2526}
        it "returns an array of contact individual object" do
            VCR.use_cassette("contact_individual") do
                @contact_individual = Virtuous::ContactIndividual.find_by_contact(contactId)
            end
            expect(@contact_individual).to be_a Array
            # expect(@contact_individual.first).to be_instance_of Virtuous::ContactIndividual
        end
        
    end

    describe "#find_avatar" do
        let(:contact_avatar_id) {3892}
        # it "returns an object of contact individual avatar?" do
        #     VCR.use_cassette("contact_avatar") do
        #         @contact_avatar = Virtuous::ContactIndividual.find_avatar(contact_avatar_id)
        #     end
        #     expect(@contact_avatar).to raise_error Virtuous::Error
        # end

        it "requires attributes" do 
            expect {
                @contact_avatar = Virtuous::ContactIndividual.find_avatar(contact_avatar_id)
            }.to raise_error Virtuous::Error
        end
        

    end
    
    describe "#update_avatar" do
        let(:contact_avatar_id) {3892}
        let(:url) { https://s3.amazonaws.com/acts29-process/files/users/avatar/3920/x100/Chris_-_face_colour.png }

        it "requres attributes" do 
            expect {
                @contact_avatar = Virtuous::ContactIndividual.update(contact_avatar_id)
            }.to raise_error Virtuous::Error
        end

        # it "returns the contact address record" do 
        #     VCR.use_cassette("contact_avatar_update") do
        #         @contact_avatar = Virtuous::ContactIndividual.update(contact_avatar_id)
        #     end
        #     expect(@contact_avatar).to be_instance_of Virtuous::ContactIndividual          
        #     expect(@contact_avatar.id).to eq(contact_avatar_id) 
        # end

        # it "updates the attributes" do 
        #     VCR.use_cassette("contac_avatar_update") do
        #         @contac_avatar = Virtuous::ContactIndividual.update(contact_avatar_id)
        #     end
        #     expect(@contac_avatar.url).to eq(attributes[:url])          
        # end

    end

    describe "#custom_fields" do
        it "returns an array" do 
            VCR.use_cassette("contact_individual") do
                @contact_individual_custom_fields = Virtuous::ContactIndividual.custom_fields
            end
            expect(@contact_individual_custom_fields).to be_a Array
        end
    end
    

end