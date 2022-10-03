class Article < ApplicationRecord
    after_commit :send_last_updated, on: [:update]
    default_scope { order(created_at: :desc) }

    def send_last_updated
        broadcast_replace_to "article_updated_alert", target: "article_updated_alert", 
        partial: "articles/alert_message", 
        locals: { :count => self.class.count, :last_updated => self.class.maximum(:updated_at) }
    end
end
