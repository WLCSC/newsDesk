class Post < ActiveRecord::Base
    include ActionView::Helpers
    belongs_to :user
    belongs_to :organization

    def status
        if !self.approved
            "Not Approved"
        else
            if self.start > Date.today
                "Starting in #{distance_of_time_in_words_to_now(self.start)}"
            elsif self.end < Date.today
                "Ended #{distance_of_time_in_words_to_now(self.end)} ago"
            else
                "Running"
            end
        end
    end
end
