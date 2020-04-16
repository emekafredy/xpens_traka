import merge from 'lodash/merge';

class HomePageComponent {
  constructor() {}

  static get defaults() {
    return Object.freeze({
      selector: '.app--main-body',
      classes: {
        navBar: 'navbar',
        navbarBackgroundColor: 'navbar--background-color'
      }
    });
  }

  _toggleNavBarBackground() {
    const { navBar, classes } = this.options;

    if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
      navBar.classList.add(classes.navbarBackgroundColor);
    } else {
      navBar.classList.remove(classes.navbarBackgroundColor);
    }
  }

  _attach() {
    window.addEventListener('scroll', this._toggleNavBarBackground.bind(this));
  }

  _setDomDependentOptions() {
    this.options.navBar = document.querySelector(`.${this.options.classes.navBar}`);
  }

  init(options = {}) {
    this.options = merge({}, this.constructor.defaults, options);

    this._setDomDependentOptions();
    this._attach();
  }
}

export default HomePageComponent;
