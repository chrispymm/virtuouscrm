RSpec.describe Virtuous::Contact do
    
    describe "#find" do
        let(:contact_id) { 3666 }
        let(:nonexistant_id)  { 0000 }

        it "returns a Contact object" do
            VCR.use_cassette("contact_single") do
                @contact = Virtuous::Contact.find(contact_id)
            end
            expect(@contact).to be_a Virtuous::Contact
            
        end

        it "returns contact with matching id" do
            VCR.use_cassette("contact_single") do
                @contact = Virtuous::Contact.find(contact_id)
            end
            expect(@contact.id).to eq(contact_id) 
        end

        it "errors if the contact doesn't exist" do
            expect {
                VCR.use_cassette("contact_not_found") do
                    @contact = Virtuous::Contact.find(nonexistant_id)
                end
            }.to raise_error Virtuous::Error
        end
    end

    describe "#find_by_reference_source" do 
        it "returns a Contact object" do
            reference_source = "123"
            reference_id = "123"
            @contact = "" #Virtuous::Contact.find_by_reference_source(reference_source, reference_id)
            expect(@contact).to be_a Virtuous::Contact
        end
    end

    describe "#find_by_reference_source" do 
        it "returns a Contact object" do
            reference_id = ""
            @contact = "" #Virtuous::Contact.find_by_reference_source(reference_id)
            expect(@contact).to be_a Virtuous::Contact
        end
    end

    describe "#find_by_tag_id" do
        let(:tag_id) {37}
        it "returns an array of Contact objects" do 
            VCR.use_cassette("contacts") do
                @contacts = Virtuous::Contact.find_by_tag_id(tag_id)
            end
            expect(@contacts).to be_a Array
            expect(@contacts.first).to be_a Virtuous::Contact
            expect(@contacts.first.id).to eq(1246)
        end
    end

end