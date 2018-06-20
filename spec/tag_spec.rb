RSpec.describe Virtuous::Tag do

    describe "#all" do
        it "returns an Array of Virtuous::Tags" do
            VCR.use_cassette("tags") do
                @tags = Virtuous::Tag.all
            end

            expect(@tags).to be_a Array
            expect(@tags.first).to be_a Virtuous::Tag
        end
    end

    describe "#search" do
        let(:query) { "Applicant" }

        it "returns an Array of Virtuous::Tags" do
            VCR.use_cassette("tags") do
                @tags = Virtuous::Tag.search(query)
            end
            expect(@tags).to be_a Array
            expect(@tags.first).to be_a Virtuous::Tag
        end

        it "returns correct number of tags" do
            VCR.use_cassette("tags") do
                @tags = Virtuous::Tag.search(query)
            end
            expect(@tags.size).to eq(9)

        end

        it "first result is correct" do
            VCR.use_cassette("tags") do
                @tags = Virtuous::Tag.search(query)
            end
            expect(@tags.first.tagName).to eq("Initial Applicant Church Archived")
        end
    end



end
