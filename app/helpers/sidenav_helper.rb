module SidenavHelper
  def desktop_link_active?(link_name)
		if controller_name == link_name
  		"bg-gray-50"
    else
    	"text-gray-700 hover:bg-gray-50"
    end
	end

	def mobile_link_active?(link_name)
		if controller_name == link_name
  		"bg-gray-200 text-gray-900"
    else
    	"text-gray-700 hover:bg-gray-200 hover:text-gray-900"
    end
	end
end