class Notification
  def self.send(subscription, message)
    Webpush.payload_send(
      message: message,
      endpoint: subscription[:endpoint],
      p256dh: subscription[:keys][:p256dh],
      auth: subscription[:keys][:auth],
      vapid: {
        subject: "mailto:sender@example.com",
        public_key: ENV['NOTIFICATION_PUBLIC_KEY'],
        private_key: ENV['NOTIFICATION_PRIVATE_KEY']
      }
    )
  end
end
