module GamesHelper
    def current_time_for_form_tag
        Time.zone.now.strftime("%Y-%m-%dT%H:%M")
    end

    def display_date_and_time(time)
        time.strftime("%A, %B %d at %l:%m%P")
    end

    def display_time(time)
        time.strftime(" at %l:%m%P")
    end
end
