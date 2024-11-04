import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["mobileMenu", "toggleButton"];

  connect() {
    // Ensure the menu is hidden by default
    this.mobileMenuTarget.classList.add("hidden");
  }

  toggleMenu() {
    const isMenuOpen = !this.mobileMenuTarget.classList.contains("hidden");
    
    // Toggle the hidden class to show or hide the menu
    this.mobileMenuTarget.classList.toggle("hidden");
    
    // Update aria-expanded attribute on the button to reflect current state
    this.toggleButtonTarget.setAttribute("aria-expanded", !isMenuOpen);
  }
}
