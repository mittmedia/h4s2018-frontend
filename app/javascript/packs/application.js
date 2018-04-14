/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

import NotificationHelper from 'modules/notification';
import PersonsonalizationBlock from 'modules/personalization_block';
import FollowButton from 'modules/follow_button';

const publicKey = window._notification_public_key;
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register(window._sw_pack_path)
    .then(swRegistration => {
      return NotificationHelper.new(swRegistration, publicKey);
    })
    .then(notificationHelper => {
      if (window.location.pathname === '/topics') {
        return notificationHelper.subscribeUser();
      }
    })
    .catch(error => {
      throw new Error(error);
    });
}

document.addEventListener('turbolinks:load', () => {
  new PersonsonalizationBlock();
  new FollowButton();
});
