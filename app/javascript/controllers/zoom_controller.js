import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image"]
  
  toggle() {
    console.log("Image clicked!")  // Check if the toggle method is being called
    const image = this.imageTarget;  // Get the target image element

    // Check if the image is zoomed in already
    if (image.style.transform === "scale(3)") {  // Adjust scale here
        console.log("Sadas")
      image.style.transform = "scale(1)";
      image.style.zIndex = "999";  // Reset z-index to 999 when zoomed out
      image.style.position = "";  // Reset position when zoomed out
    } else {
      image.style.transform = "scale(3)";  // Set scale to 2 for zooming in more
      image.style.zIndex = "9999";  // Set z-index to 9999 when zoomed in
      image.style.position = "relative";  // Set position to relative when zoomed in
    }
  }
}
