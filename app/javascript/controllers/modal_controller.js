// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="modal"
export default class extends Controller {
    static targets = ["modal"];

    connect() {
        console.log("Modal controller connected");

        // Setup click event for the open modal action
        document.querySelector('[data-action="focus->modal#openModal"]').addEventListener('focus', () => {
            this.openModal();
        });
    }

    openModal() {
        console.log("Opening modal");
        this.modalTarget.classList.remove("hidden");
        document.body.style.overflow = "hidden"; // Prevent background scrolling

        // Adding click listener to the overlay to close the modal
        this.modalTarget.addEventListener('click', (event) => {
            if (event.target === this.modalTarget) {
                this.closeModal();
            }
        });
    }

    closeModal() {
        console.log("Closing modal");
        this.modalTarget.classList.add("hidden");
        document.body.style.overflow = ""; // Restore background scrolling
    }

    submitSearch(event) {
        event.preventDefault(); // Prevent default form submission
        const formData = new FormData(event.target);
        const searchQuery = formData.get('search');

        console.log(`Searching for: ${searchQuery}`);
        // Optional: You can redirect or handle the search as needed here
        this.closeModal(); // Close modal after submission
    }
}
