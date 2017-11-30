RSpec.describe Virtuous::Contact do
    
    describe "#find" do
        let(:contact_id) { 3666 }
        let(:nonexistant_id)  { 0000 }

        it "returns a Contact object" do
            VCR.use_cassette("contact_single") do
                @contact = Virtuous::Contact.find(contact_id)
            end
            expect(@contact).to be_instance_of Virtuous::Contact
            
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
            #expect(@contact).to be_a Virtuous::Contact
        end
    end

    describe "#find_by_reference_source" do 
        it "returns a Contact object" do
            reference_id = ""
            @contact = "" #Virtuous::Contact.find_by_reference_source(reference_id)
            #expect(@contact).to be_a Virtuous::Contact
        end
    end

    describe "#find_by_tag_id" do
        let(:tag_id) {37}
        it "returns an array of Contact objects" do 
            VCR.use_cassette("contact_list") do
                @contacts = Virtuous::Contact.find_by_tag_id(tag_id)
            end
            expect(@contacts).to be_a Array
            expect(@contacts.first).to be_instance_of Virtuous::Contact
        end
    end

    describe "#update" do
        let(:contact_id) {2526}
        let(:attributes) { { contactType: "Household", informalName: "Test Name" } }

        it "requres_attributes" do 
            expect {
                @contact = Virtuous::Contact.update(contact_id)
            }.to raise_error Virtuous::Error
        end

        it "returns the contact record" do 
            VCR.use_cassette("contact_update") do
                @contact = Virtuous::Contact.update(contact_id, attributes)
            end
            expect(@contact).to be_instance_of Virtuous::Contact          
            expect(@contact.id).to eq(contact_id) 
        end

        it "updates the attributes" do 
            VCR.use_cassette("contact_update") do
                @contact = Virtuous::Contact.update(contact_id, attributes)
            end
            expect(@contact.informalName).to eq(attributes[:informalName])          
        end

    end

    describe "#custom_fields" do
        it "returns an array of custom fields" do 
            VCR.use_cassette("contact_extra") do
                @contact_custom_fields = Virtuous::Contact.custom_fields
            end
            expect(@contact_custom_fields).to be_a Array
        end
    end

    describe "#prefixes" do
        it "returns an array of prefixes" do 
            VCR.use_cassette("contact_extra") do
                @contact_prefixes = Virtuous::Contact.prefixes
            end
            expect(@contact_prefixes).to be_a Array
        end
    end

    describe "#types" do
        it "returns an array of types" do 
            VCR.use_cassette("contact_extra") do
                @contact_types = Virtuous::Contact.types
            end
            expect(@contact_types).to be_a Array
        end
    end   

    describe "#query_options" do
        it "returns an hash of query options" do 
            VCR.use_cassette("contact_extra") do
                @query_options = Virtuous::Contact.query_options
            end
            expect(@query_options).to be_a Hash
        end
    end    

    describe "#activity" do
        it "returns an array of contacts with limited data" do 
            VCR.use_cassette("contact_activity") do
                @activity = Virtuous::Contact.activity
            end
            expect(@activity).to be_a Array
        end
    end         

    describe "#following" do
        it "returns an array of contacts" do 
            VCR.use_cassette("contact_list", :match_requests_on => [:method] ) do
                @following = Virtuous::Contact.following
            end
            expect(@following).to be_a Array            
            expect(@following.first).to be_instance_of Virtuous::Contact if @following.size > 0
        end
    end              

    describe "#batch" do
        let(:contact_batch) { [] }

        it "requires a contacts array to be posted" do
            expect {
                VCR.use_cassette("contact_batch_error") do
                    @contact_batch = Virtuous::Contact.batch({})
                end
            }.to raise_error Virtuous::Error

        end

        it "returns status 200" do 
            VCR.use_cassette("contact_batch") do
                @contact_batch = Virtuous::Contact.batch(contact_batch)
            end
            expect(@contact_batch).to eq(200)
        end
    end    

    # Get Chris TO CHECK BELOW #search_nearby and #search

    describe "#search_nearby" do
        let(:body) {{ lat: "0", lng: "0", distance: "10" }}

        it " returns an array of randomly structured contact information" do
            expect {
                VCR.use_cassette("contact_proximity") do 
                    @search_nearby = Virtuous::Contact.search_nearby(body)
                end
            }.to raise_error Virtuous::Error
        end
        
    end


    describe "#search" do
        let(:search_query) { "Chris" }

        it "Find all contacts that match, fully or partially, the given search parameter" do
            VCR.use_cassette("contact_list", :match_requests_on => [:method] ) do 
                @search = Virtuous::Contact.search(search_query)
            end
            expect(@search).to be_a Array
        end
        
    end

end


