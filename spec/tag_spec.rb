RSpec.describe Virtuouscrm::Tag do

    describe "#all" do
        it "returns an Array of Virtuouscrm::Tags" do
            VCR.use_cassette("tags") do
                @tags = Virtuouscrm::Tag.all
            end

            expect(@tags).to be_a Array
            expect(@tags.first).to be_a Virtuouscrm::Tag
        end
    end

    describe "#search" do
        let(:query) { "Applicant" }

        it "returns an Array of Virtuouscrm::Tags" do
            VCR.use_cassette("search_tags") do
                @tags = Virtuouscrm::Tag.search(query)
            end
            expect(@tags).to be_a Array
            expect(@tags.first).to be_a Virtuouscrm::Tag
        end

        it "returns correct number of tags" do
            VCR.use_cassette("search_tags") do
                @tags = Virtuouscrm::Tag.search(query)
            end
            expect(@tags.size).to eq(3)
            
        end

        it "first result is correct" do
            VCR.use_cassette("search_tags") do
                @tags = Virtuouscrm::Tag.search(query)
            end
            expect(@tags.first.tagName).to eq("InitialApplicant")
        end


        


    end



end