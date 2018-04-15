import Notification from 'modules/notification';

export default class InterestButton {
  constructor () {
    this.buttons = document.querySelectorAll('.interest_button');
    this.addEventListeners();
  }

  addEventListeners() {
    this.buttons.forEach(interestButton => {
      interestButton.addEventListener('click', this.toggleActive.bind(this, interestButton));
    });
  }

  toggleActive (interestButton) {
    Notification.new()
      .then((notificationHelper) => {
        return notificationHelper.subscribeUser();
      })
      .then(() => {
        interestButton.classList.toggle('interest_button--selected')
      })
      // TODO: Better error handling
      .catch(console.error);
  }
}
