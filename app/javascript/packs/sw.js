self.addEventListener('push', (event) => {
  let title = (event.data && event.data.text()) || 'You have received a notification';
  let body = 'Please check the app to see the content';
  event.waitUntil(self.registration.showNotification(title, { body }));
});
