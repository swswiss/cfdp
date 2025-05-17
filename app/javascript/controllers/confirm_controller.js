// app/javascript/controllers/confirm_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal", "panel", "backdrop"];

  open() {
    this.modalTarget.classList.remove("hidden");

    // Trigger a reflow so the transition starts properly
    void this.modalTarget.offsetWidth;

    this.modalTarget.classList.add("opacity-100");
    this.backdropTarget.classList.add("opacity-100");
    this.backdropTarget.classList.remove("opacity-0");

    this.panelTarget.classList.remove("opacity-0", "scale-95");
    this.panelTarget.classList.add("opacity-100", "scale-100");
  }

  close() {
    // Animate out
    this.modalTarget.classList.remove("opacity-100");
    this.modalTarget.classList.add("opacity-0");

    this.backdropTarget.classList.remove("opacity-100");
    this.backdropTarget.classList.add("opacity-0");

    this.panelTarget.classList.remove("opacity-100", "scale-100");
    this.panelTarget.classList.add("opacity-0", "scale-95");

    // Hide the modal after animation ends
    setTimeout(() => {
      this.modalTarget.classList.add("hidden");
    }, 300); // match duration-300
  }
}
