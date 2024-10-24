// app/javascript/controllers/donate_modal_controller.js
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="donate-modal"
export default class extends Controller {
  static targets = ["modal"]

  connect() {
    console.log("Donate Modal Stimulus Controller connected!"); // Debugging check
  }

  open(event) {
    console.log("open");
    event.preventDefault(); // Prevent default link behavior
    if (this.modalTarget) {
      this.modalTarget.classList.remove('hidden');
    } else {
      console.error("Modal target not found!");
    }
  }

  close() {
    if (this.modalTarget) {
      this.modalTarget.classList.add('hidden');
    } else {
      console.error("Modal target not found!");
    }
  }
}
