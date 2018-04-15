self.addEventListener('push', (event) => {
  const eventData = event.data && event.data.json();
  const title = 'Nytt remissvar';
  const body = 'Polisfacket har nu svarat i frågan ‘Nästa steg på vägen mot  en mer jämlik hälsa - Förslag för ett långsiktigt arbete  för en god och jämlik hälsa';
  event.waitUntil(self.registration.showNotification(title, { body, icon: '/android-chrome-192x192.png', data: eventData }));
});

self.addEventListener('notificationclick', function(event) {
  // This looks to see if the current is already open and
  // focuses if it is
  return event.waitUntil(clients.openWindow(`http://localhost:3000/topics/${event.notification.data.topic_id}`));
});
