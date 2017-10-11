# frozen_string_literal: true

module Decidim
  module Members
    module Patches

      module UpdateAccountPatch
        def self.apply
          Decidim::UpdateAccount.prepend self unless Decidim::UpdateAccount < self
        end

        def broadcast(what, *_)
          if what == :ok
            Decidim::Members::UpdateUserIndex.(@user)
          end
          super
        end
      end

    end
  end
end
