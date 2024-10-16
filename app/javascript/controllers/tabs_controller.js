import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tab", "content"];

  connect() {
    // Optionally, show the first tab on connect
    this.showTab(this.tabTargets[0]);
  }

  switch(event) {
    event.preventDefault();
    const selectedTab = event.currentTarget; // Get the clicked tab
    this.showTab(selectedTab);
  }

  showTab(selectedTab) {
    // Hide all content
    this.contentTargets.forEach(content => content.classList.add("hidden"));

    // Remove active class from all tabs
    this.tabTargets.forEach(tab => tab.classList.remove("text-blue-600", "border-blue-600", "dark:text-blue-500", "dark:border-blue-500"));

    // Find index of the selected tab
    const index = this.tabTargets.indexOf(selectedTab);

    // Show corresponding content and activate tab
    this.contentTargets[index].classList.remove("hidden");
    selectedTab.classList.add("text-blue-600", "border-blue-600", "dark:text-blue-500", "dark:border-blue-500");

    const buttonsContainer = document.getElementById('buttons-container');
    if (selectedTab.textContent.trim() === 'Profile') {
      buttonsContainer.classList.remove('hidden'); // Show buttons
    } else {
      buttonsContainer.classList.add('hidden'); // Hide buttons
    }

    // If the map tab is selected, trigger map resizing
    if (selectedTab.getAttribute('data-tab') === 'map') {
      this.invalidateMapSize();
    }
  }

  // Add this function to invalidate the map size when its tab is shown
  invalidateMapSize() {
    if (typeof map !== "undefined") {
      setTimeout(() => {
        map.invalidateSize(); // Trigger map size recalculation
      }, 300); // Delay to ensure tab is fully visible
    }
  }
}
