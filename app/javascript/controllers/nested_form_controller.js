import NestedForm from '@stimulus-components/rails-nested-form'

export default class extends NestedForm {
  static targets = ["removeButton"]

  connect() {
    super.connect()
    this.removeButtonTargets.forEach(button => {
      button.addEventListener('click', (event) => {
        if (this.element.querySelectorAll('.nested-form-wrapper').length <= 1) {
          event.preventDefault();
          alert('Cannot remove the last set of passenger details.');
        }
      });
    });
  }

  remove(event) {
    if (this.element.querySelectorAll('.nested-form-wrapper').length > 1) {
      super.remove(event);
    }
  }
}