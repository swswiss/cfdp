import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("Modal controller connected");
  }

  open() {
    console.log("Open modal triggered");
    this.modalTarget.classList.remove("hidden"); // Show modal
  }

  close() {
    console.log("Close modal triggered");
    this.modalTarget.classList.add("hidden"); // Hide modal
  }
}
