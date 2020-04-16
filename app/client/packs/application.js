
// require("@rails/ujs").start()
// require("turbolinks").start()
// require("@rails/activestorage").start()
// require("channels")

import 'bootstrap';
import '@fortawesome/fontawesome-free/js/all';
import 'jquery-ujs';

import HomePageComponent from '../components/homepage';

const homePageComponent = new HomePageComponent;
homePageComponent.init();
