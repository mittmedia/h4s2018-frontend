self.addEventListener('push', (event) => {
  const eventData = event.data && event.data.json();
  const title = (eventData.message) || 'You have received a notification';
  const body = 'Please check the app to see the content';
  event.waitUntil(self.registration.showNotification(title, { body }));
});
