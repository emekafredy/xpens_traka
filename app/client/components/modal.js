import merge from 'lodash/merge';

class ModalComponent {
  constructor() {}

  static get defaults() {
    let defaults = merge({}, {
      triggerButton: '.modal-pop--trigger',
      selector: '.main-app-body',
      classes: {
        modal: 'modal-display',
        visible: 'modal-display--visible',
        modalDisplayActionButton: 'modal-display--action-button',
        modalCloseTrigger: 'modal-display--close-icon'
      }
    });

    return Object.freeze(defaults);
  }

  _open(modal) {
    this.options.openModal = modal;
    modal.classList.add(this.options.classes.visible);
  }

  _close() {
    this.options.openModal.classList.remove(this.options.classes.visible);
  }

  _handleModalClick(event) {
    const { classes } = this.options;
    const clickedCloseTarget = event.target.classList.contains(classes.modalCloseTrigger);
    if (clickedCloseTarget) this._close();
  }

  _handleTriggerClick(event) {
    const buttonClicked = event.currentTarget;
    const index = this.options.triggerButtons.indexOf(buttonClicked);
    this._open(this.options.modals[index]);
  }

  _setDomDependentOptions() {
    const { classes, triggerButton, selector } = this.options;

    this.options.body           = document.querySelector('html,body');
    this.options.scope          = document.querySelector(selector);
    this.options.modals         = Array.from(this.options.scope.querySelectorAll(`.${classes.modal}`));
    this.options.triggerButtons = Array.from(this.options.scope.querySelectorAll(triggerButton));
  }

  _attach() {
    const { triggerButtons, modals } = this.options;

    triggerButtons.forEach(buttonNode => buttonNode.addEventListener('click', this._handleTriggerClick.bind(this)));
    modals.forEach(modalNode => modalNode.addEventListener('click', this._handleModalClick.bind(this)));
  }

  init(options = {}) {
    this.options = merge({}, this.constructor.defaults, options);

    this._setDomDependentOptions();
    this._attach();
  }
}

export default ModalComponent;
