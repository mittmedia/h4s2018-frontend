import Cookie from 'js-cookie';

export default class FollowButton {
  constructor () {
    this.buttons = document.querySelectorAll('.follow_button');
    this.addEventListeners();
  }

  addEventListeners() {
    this.buttons.forEach(followButton => {
      followButton.addEventListener('click', this.triggerFollow.bind(this, followButton));
    });
  }

  getTopicId (followButton) {
    return followButton.getAttribute('data-topic-id');
  }

  triggerFollow(followButton) {
    const topicId = this.getTopicId(followButton);
    const userId = Cookie.get('user_id');
    let path = `/users/${userId}/subscribe_to_topic.json?topic_id=${topicId}`;
    if (followButton.classList.contains('follow_button--active')) {
      path = `/users/${userId}/unsubscribe_from_topic.json?topic_id=${topicId}`;
    }
    fetch(path, {
      method: 'PUT'
    }).then(() => {
      location.reload();
    });
  }
}
