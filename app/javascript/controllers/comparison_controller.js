import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dropdown1", "dropdown2", "introText"];

  fetchBridgeData(event) {
    const dropdown = event.target;
    const selectedBridgeId = dropdown.value;
    const frameId = dropdown === this.dropdown1Target ? "bridge1-data" : "bridge2-data"; 

    const frameElement = document.getElementById(frameId); // Get the frame element first

    if (this.hasIntroTextTarget) {
        this.introTextTarget.classList.add("hidden");
      }
    if (selectedBridgeId) {
      const url = `/bridges/${selectedBridgeId}/compare_data`;

      fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('[name="csrf-token"]').content,
        },
        body: JSON.stringify({ frame_id: frameId }) // Include the frame ID in the request body
      })
      .then(response => {
        if (!response.ok) {
          throw new Error(`HTTP error! Status: ${response.status}`);
        }
        return response.text(); // Get response text to replace frame content
      })
      .then(html => {
        if (frameElement) {
          frameElement.innerHTML = html; // Update the frame's inner HTML with bridge data
        }
      })
      .catch(error => {
        console.error('There has been a problem with your fetch operation:', error);
      });
    } else {
      // Render a message in the Turbo frame when no bridge is selected
      if (frameElement) {
        frameElement.innerHTML = `
      `;
      }
    }
  }
}
