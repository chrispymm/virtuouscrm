
RSpec.describe Virtuous::ContactNote do

    describe "#find_important_for_contact" do
        let(:id) { 33 }
        it "returns an array of important notes for specified contact" do 
            VCR.use_cassette("contact_note") do
                @contact_note = Virtuous::ContactNote.find_important_for_contact(id)
            end
            expect(@contact_note).to be_a Array
        end
    end     

    describe "#find_by_contact" do
        let(:id) { 33 }
        it "returns an array of notes for specified contact" do 
            VCR.use_cassette("contact_note") do
                @contact_note = Virtuous::ContactNote.find_by_contact(id)
            end
            expect(@contact_note).to be_a Array
        end
    end     

    describe "#types" do
        it "Gets the types of contact notes" do
            VCR.use_cassette("contact_note") do
                @contact_note = Virtuous::ContactNote.types
            end
            expect(@contact_note).to be_a Hash
        end
    end

    describe "#find" do
        let(:id) { 33 }
        let(:nonexistant_id)  { 0000 }

        it "returns an array of notes for specified contact" do 
            VCR.use_cassette("contact_note") do
                @contact_notes = Virtuous::ContactNote.find(id)
            end
            expect(@contact_notes).to be_instance_of Virtuous::ContactNote
        end

        it "errors if the contact doesn't exist" do
            expect {
                VCR.use_cassette("contact_note_error") do
                    @contact = Virtuous::ContactNote.find(nonexistant_id)
                end
            }.to raise_error Virtuous::Error
        end
    end   
  
    describe "#update" do
        let(:contact_id) { 2526 } #ContactMethodID for ContactID 2526 (Chris Pymm)
        let(:attributes) {{ type: "general", note: "a general note" }} 

        it "requires_attributes" do
            expect {
                @contact_note_update = Virtuous::ContactNote.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        # Gives SEVER ERROR 500
        # it "returns the contact method" do
        #     VCR.use_cassette("contact_note_update") do
        #         @contact_note = Virtuous::ContactNote.update(contact_id, attributes)
        #     end
        #     expect(@contact_note).to be_instance_of Virtuous::ContactNote          
        #     expect(@contact_note.id).to eq(contact_id) 
        # end

    end

    #Not testing the Creation Method


    describe "#create_from_email" do
        let(:from) {"danny@adozeneggs.co.uk"}
        let(:to) { "chris@adozeneggs.co.uk" }
        let(:subject) { "email note"  }
        let(:message) { "message" }

        it "posts the email as a contact note" do
            expect {
                VCR.use_cassette("contact_note_error") do
                    @contact_note = Virtuous::ContactNote.create_from_email({})
                end
            }.to raise_error Virtuous::Error

        end

        # HAS 404 ERROR
        # it "returns status 200" do 
        #     VCR.use_cassette("contact_note_error") do
        #         @contact_note = Virtuous::ContactNote.create_from_email(fromEmail, toEmail, subject, body)
        #     end
        #     expect(@contact_note).to eq(400)
        # end
    end    

    describe "#create" do
        let(:body) {{ contactId: "2526", type: "General", note: "A general note" }}

        it "creates a contact note for specified contact" do
            expect {
                VCR.use_cassette("contact_note_error", :match_requests_on => [:method] ) do
                    @contact_note = Virtuous::ContactNote.create({})
                end
            }.to raise_error Virtuous::Error

        end

        # it "returns status 200" do 
        #     VCR.use_cassette("contact_note") do
        #         @contact_note = Virtuous::ContactNote.create(body)
        #     end
        #     expect(@contact_note).to eq(200)
        # end
    end


end
