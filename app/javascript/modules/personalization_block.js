import Cookie from 'js-cookie';

export default class PersonalizationBlock {
  constructor() {
    this.blocks = document.querySelectorAll('.personalization_block');
    this.inputs = document.querySelectorAll('.personalization_block button, .personalization_block input, .personalization_block select, .personalization_block textarea');
    this.regionFields = document.querySelectorAll('.personalization_block__select');
    this.addEventListeners();
  }

  addEventListeners() {
    this.blocks.forEach(personalizationBlock => {
      personalizationBlock.addEventListener('click', this.toggleContent.bind(this, personalizationBlock));
    });

    this.inputs.forEach(input => {
      input.addEventListener('click', (event) => event.stopPropagation())
    });

    this.regionFields.forEach(regionField => {
      regionField.addEventListener('change', this.onRegionChange.bind(this, regionField))
    });
  }

  toggleContent(personalizationBlock) {
    personalizationBlock.classList.toggle('personalization_block--expanded');
  }

  onRegionChange(regionField) {
    if (regionField.classList.contains('personalization_block__select--counties')) {
      const municipalityOptions = document.querySelectorAll('.personalization_block__select--municipalities option');
      municipalityOptions.forEach(municipalityOption => {
        const parentId = municipalityOption.getAttribute('data-parent');
        if (parentId && parentId !== regionField.value) {
          municipalityOption.classList.add('personalization_block__option--disabled')
        } else {
          municipalityOption.classList.remove('personalization_block__option--disabled')
        }
      })
    }

    const userId = Cookie.get('user_id');
    fetch(`/users/${userId}/subscribe_to_region.json?region_id=${regionField.value}`, {
      method: 'PUT'
    });
  }
}
