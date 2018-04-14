class Notification
  def self.send(user_id, message)
    subscription = self.get_subscription_by_user_id(user_id)
    Webpush.payload_send(
      message: message.to_json,
      endpoint: subscription["endpoint"],
      p256dh: subscription["keys"]["p256dh"],
      auth: subscription["keys"]["auth"],
      vapid: {
        subject: "mailto:sender@example.com",
        public_key: ENV['NOTIFICATION_PUBLIC_KEY'],
        private_key: ENV['NOTIFICATION_PRIVATE_KEY']
      }
    )
  end

  def self.get_subscription_by_user_id(user_id)
    JSON.parse(User.find(user_id).subscription)
  end
end
