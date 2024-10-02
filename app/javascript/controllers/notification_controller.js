import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="notification"
export default class extends Controller {
  connect() {
    console.log("heesfsddsadfsfsfsfs")
    if(!this.isPreview) {
      setTimeout (() => {
        this.element.classList.remove('hidden');
        this.element.classList.add('transform', 'ease-out', 'duration-300', 'transition', 'translation-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2');

        setTimeout (() => {
          this.element.classList.add('translate-y-0', 'opacity-100', 'sm:translate-x-0');
        }, 100);
      }, 500);
    }

    setTimeout(() => {
      this.close();
    }, 5000);
  }

  close() {
    this.element. classList.remove('transform', 'ease-out', 'duration-300', 'translate-y-2', 'opacity-0', 'sm:translate-y-0', 'sm:translate-x-2', 'translate-y-0', 'sm:translate-x-2');
    this.element.classList.add('transition', 'ease-in', 'duration-100');

    setTimeout(() => {
      this.element.classList.add('oapcity-0');
    }, 100);

    setTimeout(() => {
      this.element.remove();
    }, 300);
  }

  get isPreview() {
    return document.documentElement.hasAttribute ('data-turbolinks-preview');
  }
}

