module Contexts
  module Documents

    def create_documents
      @jsmith_doc = FactoryGirl.create(:document, student: @jsmith)
      @lucy_doc = FactoryGirl.create(:document, student: @lucy)
    end

    def remove_documents
      @jsmith_doc.destroy
      @lucy_doc.destroy
    end

  end
end
