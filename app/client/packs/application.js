/* eslint-disable no-undef */
// require('@rails/ujs').start();
// require('turbolinks').start();
// require('@rails/activestorage').start();
require('chartkick');
require('chart.js');

// Dependencies
import 'bootstrap';
import 'jquery-ujs';
import '@fortawesome/fontawesome-free/js/all';

// Vendore
import '../vendor/picker';
import '../vendor/picker.date';

// Controllers
// import '../controllers/hompage';

import ModalComponent from '../components/modal';
import FormComponent from '../components/form';
import HomePageComponent from '../components/homepage';

$(document).ready(function() {
  $('.datepicker').pickadate({
    onStart: function () {
      var date = new Date();
      this.set('select', [date.getFullYear(), date.getMonth(), date.getDate()]);
    }
  });

  var inputs = document.querySelectorAll('.file-input');

  for (var i = 0, len = inputs.length; i < len; i++) {
    customInput(inputs[i]);
  }

  function customInput (el) {
    const fileInput = el.querySelector('[type="file"]');
    const label = el.querySelector('[data-js-label]');
    
    fileInput.onchange =
    fileInput.onmouseout = function () {
      if (!fileInput.value) return;
      
      // eslint-disable-next-line no-useless-escape
      var value = fileInput.value.replace(/^.*[\\\/]/, '');
      el.className += ' -chosen';
      label.innerText = value;
    };
  }

  const modalComponent = new ModalComponent;
  modalComponent.init();

  const formComponent = new FormComponent;
  formComponent.init();

  const homePageComponent = new HomePageComponent;
  homePageComponent.init();
});
