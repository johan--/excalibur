module DirtyAccessor
	extend ActiveSupport::Concern
	included do
        stored_attributes.each do |store, keys|
            keys.each do |key|
              define_method :"#{key}_changed?" do
                changes[store] && changes[store].map { |v| v.try(:[], key) }.uniq.length > 1
              end
            end
        end
    end
end