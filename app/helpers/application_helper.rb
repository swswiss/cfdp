module ApplicationHelper
    def time_ago(timestamp)
        time_ago_in_words(timestamp) + ' ago'
      end
end
