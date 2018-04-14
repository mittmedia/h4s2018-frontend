export default class PersonalizationBlock {
  constructor() {
    this.blocks = document.querySelectorAll('.personalization_block');
    this.addEventListeners();
  }

  addEventListeners() {
    this.blocks.forEach(personalizationBlock => {
      personalizationBlock.addEventListener('click', this.toggleContent.bind(this, personalizationBlock));
    });
  }

  toggleContent(personalizationBlock) {
    personalizationBlock.classList.toggle('personalization_block--expanded');
  }
}
