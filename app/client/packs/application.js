/* eslint-disable no-undef */
// require('@rails/ujs').start();
// require('turbolinks').start();
// require('@rails/activestorage').start();

//= require flatpickr.default

import 'bootstrap';
import 'jquery-ujs';
import '@fortawesome/fontawesome-free/js/all';
import '../vendor/picker';
import '../vendor/picker.date';

import HomePageComponent from '../components/homepage';

const homePageComponent = new HomePageComponent;
homePageComponent.init();


$(document).ready(function() {
  $('.datepicker').pickadate();
});
