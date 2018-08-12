require "rails_helper"

RSpec.describe SearchLog do
  let!(:log) { described_class.create!(query: "Where is Tommy Wiseau from") }

  describe "defaults" do
    subject{ log }
    it{ is_expected.to have_attributes(hits: 1) }
  end

  describe "#increment!" do
    subject{ log.increment! }
    it { expect{ subject }.to change{ log.reload.hits }.from(1).to(2) }
  end

  describe "#exact_match?" do
    it{ expect(log.exact_match?("Who hit Lisa")).to                be(false) }
    it{ expect(log.exact_match?("Where is Tommy Wiseau")).to       be(false) }
    it{ expect(log.exact_match?("Where is Tommy Wiseau from")).to  be(true)  }
  end

  describe ".parent_logs" do
    subject{ described_class.parent_logs("foo") }

    let!(:log_1) { described_class.create(query: "bar") }
    let!(:log_2) { described_class.create(query: "bar foobar") }
    let!(:log_3) { described_class.create(query: "foofoo") }

    it { expect(subject).to eq([log_3]) }
  end

  describe ".child_logs" do
    subject{ described_class.child_logs("tell me how am I supposed to live without you") }

    let!(:log_1) { described_class.create(query: "tell") }
    let!(:log_2) { described_class.create(query: "how am I") }
    let!(:log_3) { described_class.create(query: "wazzup") }

    it { expect(subject).to eq([log_1]) }
  end
end
