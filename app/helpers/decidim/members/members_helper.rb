module Decidim
  module Members
    # Helpers related to the Assemblies filter by type.
    #
    # `filter` returns a Filter object from Decidim::FilterResource
    module MembersHelper
      def options_for_state_filter
        [["all", "All"], ["grantmaking", "Grantmaking"], ["community_building", "Community Building"], ["fundraising", "Fundraising"], ["communications", "Communications"], ["none", "None"]]
      end

      def options_for_areas_of_interest_filter
        [["all", "All"], ["alt_economies", "Alt economies"], ["democratic_innovation", "Democratic Innovation"], ["digital_activism", "Digital Activism"], ["public_space", "Public Space"], ["feminism", "Feminism"], ["civil_rights", "Civil Rights"], ["alt_media", "Alt Media"], ["anti_discrimination", "Anti Discrimination"], ["migration", "Migration"], ["climate_justice", "Climate Justice"], ["public_health", "Public Health"]]
      end

    end
  end
end
