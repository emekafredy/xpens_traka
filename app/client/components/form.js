import merge from 'lodash/merge';

class FormComponent {
  constructor() {}

  static get defaults() {
    return Object.freeze({
      selector: '.documents--upload',
      classes: {
        documentFileInput: 'documents--upload--file-input',
        documentNameInput: 'documents--upload--name-input',
        documentsubmitBtn: 'documents--upload--submit-btn'
      }
    });
  }

  _toggleDocumentUploadButton() {
    const { documentFileInput, documentNameInput, documentsubmitBtn } = this.options;

    const hasNameInputValue = !!documentNameInput.value.trim();
    const hasFileInputValue = !!documentFileInput.value;

    if (hasNameInputValue && hasFileInputValue) {
      return documentsubmitBtn.disabled = false;
    }

    return documentsubmitBtn.disabled = true;
  }

  _attach() {
    let { documentNameInput, documentFileInput } = this.options;
    if (documentNameInput) {
      documentNameInput.addEventListener('input', this._toggleDocumentUploadButton.bind(this));
      documentFileInput.addEventListener('change', this._toggleDocumentUploadButton.bind(this));
    }
  }

  _setDomDependentOptions() {
    const { classes, selector } = this.options;

    this.options.scope = document.querySelector(selector);

    if (this.options.scope) {
      this.options.documentFileInput = this.options.scope.querySelector(`.${classes.documentFileInput}`);
      this.options.documentNameInput = this.options.scope.querySelector(`.${classes.documentNameInput}`);
      this.options.documentsubmitBtn = this.options.scope.querySelector(`.${classes.documentsubmitBtn}`);
    }
  }

  init(options = {}) {
    this.options = merge({}, this.constructor.defaults, options);

    this._setDomDependentOptions();
    this._attach();  
  }
}

export default FormComponent;
