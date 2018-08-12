require "rails_helper"

RSpec.describe CreateSearchLog do
  subject { described_class.call("what is love") }

  it "tracks the search query" do
    expect{ subject }.to change{ SearchLog.count }.by(1)
    log = SearchLog.last
    expect(log).to have_attributes(query: "what is love", hits: 1)
  end

  context "when the query is a substring of existing log query" do
    subject { described_class.call("what is") }

    let!(:parent_log) { SearchLog.create(query: "what is love") }

    it "doesn't create a new record" do
      expect{ subject }.not_to change{ SearchLog.count }
    end

    it "does not increment parent query hits" do
      expect{ subject }.not_to change{ parent_log.reload.hits }
    end

    context "for multiple parents" do
      let!(:parent_log_2) { SearchLog.create(query: "what is my ip") }

      it "doesn't create a new record" do
        expect{ subject }.not_to change{ SearchLog.count }
      end

      it "does not increment parent queries hits" do
        subject
        expect(parent_log.reload.hits).to be(1)
        expect(parent_log_2.reload.hits).to be(1)
      end
    end
  end

  context "when the query is exactly like an existing log query" do
    subject { described_class.call("what is love") }

    let!(:parent_log) { SearchLog.create(query: "what is love") }

    it "doesn't create a new record" do
      expect{ subject }.not_to change{ SearchLog.count }
    end

    it "increments parent log hits" do
      expect{ subject }.to change{ parent_log.reload.hits }.from(1).to(2)
    end
  end

  context "when the query is a parent of an already logged query" do
    subject { described_class.call("what is love") }

    let!(:child_log) { SearchLog.create(query: "what is", hits: 3) }

    it "creates a new record in place of child log and resets the hits" do
      expect{ subject }.not_to change{ SearchLog.count }
      expect(SearchLog.last).to have_attributes(query: "what is love", hits: 1)
    end
  end
end
