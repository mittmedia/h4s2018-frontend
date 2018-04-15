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
    interestButton.classList.toggle('interest_button--selected')
  }
}
