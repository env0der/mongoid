# encoding: utf-8
module Mongoid #:nodoc:
  module Persistence #:nodoc:
    module Atomic #:nodoc:

      # This class provides the ability to perform an explicit $pullAll
      # modification on a specific field.
      class PullAll
        include Operation

        # Sends the atomic $pullAll operation to the database.
        #
        # @example Persist the new values.
        #   pull_all.persist
        #
        # @return [ Object ] The new array value.
        #
        # @since 2.0.0
        def persist
          prepare do
            if document[field]
              values = document.send(field)
              values.delete_if { |val| value.include?(val) }
              values.tap { execute("$pullAll") }
            end
          end
        end
      end
    end
  end
end
