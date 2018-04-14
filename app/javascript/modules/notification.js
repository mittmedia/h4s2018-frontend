import Cookie from 'js-cookie';

function urlB64ToUint8Array(base64String) {
  const padding = '='.repeat((4 - base64String.length % 4) % 4);
  const base64 = (base64String + padding)
    .replace(/\-/g, '+')
    .replace(/_/g, '/');

  const rawData = window.atob(base64);
  const outputArray = new window.Uint8Array(rawData.length);

  for (let i = 0; i < rawData.length; ++i) {
    outputArray[i] = rawData.charCodeAt(i);
  }
  return outputArray;
}

// Could be used as follows:
//
// const publicKey = [somePublicServerKey];
// navigator.serviceWorker.register('sw.js')
//   .then(swRegistration => {
//     return NotificationHelper.new(swRegistration, publicKey);
//   })
//   .then(notificationHelper => {
//     // Use it however you want it.
//   })
//   .catch(error => {
//     // Do something with that error please!!
//   });

export default class NotificationHelper {
  constructor(swRegistration, serverPublicKey, subscription) {
    this.swRegistration = swRegistration;
    this.serverPublicKey = serverPublicKey;
    this.subscription = subscription;
    this.applicationServerKey = urlB64ToUint8Array(serverPublicKey);
  }

  static new(swRegistration, serverPublicKey) {
    return swRegistration.pushManager.getSubscription()
      .then((subscription) => {
        return new NotificationHelper(
          swRegistration,
          serverPublicKey,
          subscription
        );
      });
  }

  get isSubscribed() {
    return window.Notification.permission === 'granted';
  }

  get hasRejected() {
    return window.Notification.permission === 'denied';
  }

  get subscriptionConfig() {
    return {
      userVisibleOnly: true,
      applicationServerKey: this.applicationServerKey
    };
  }

  subscribeUser() {
    if (this.hasRejected) return Promise.resolve();
    if (this.isSubscribed) return Promise.resolve(this.subscription);

    return this.swRegistration.pushManager.subscribe(this.subscriptionConfig)
      .then((subscription) => {
        this.subscription = subscription;
        this.updateSubscriptionOnServer();
        return subscription;
      });
  }

  updateSubscriptionOnServer() {
    const userId = Cookie.get('user_id');
    fetch(`/users/${userId}/subscribe`, {
      body: JSON.stringify({
        user: {
          subscription: this.subscription.toJSON(),
        }
      }),
      headers: {
        'content-type': 'application/json'
      },
      method: 'PUT'
    });
  }
}
