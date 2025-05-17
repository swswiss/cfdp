import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["image"]

  toggle() {
    const image = this.imageTarget;

    if (image.classList.contains("zoomed")) {
      image.style.cssText = "";
      image.classList.remove("zoomed");
    } else {
      // Clone to get natural size
      const clone = image.cloneNode();
      clone.style.position = "absolute";
      clone.style.visibility = "hidden";
      document.body.appendChild(clone);

      const naturalWidth = clone.naturalWidth || clone.offsetWidth;
      const naturalHeight = clone.naturalHeight || clone.offsetHeight;
      document.body.removeChild(clone);

      const vw = window.innerWidth * 0.9;
      const vh = window.innerHeight * 0.9;

      const widthScale = vw / naturalWidth;
      const heightScale = vh / naturalHeight;
      const scale = Math.min(widthScale, heightScale, 0.4); // Optional cap at 2x zoom

      image.style.position = "fixed";
      image.style.top = "50%";
      image.style.left = "50%";
      image.style.transform = `translate(-50%, -50%) scale(${scale})`;
      image.style.zIndex = "9999";
      image.style.transition = "transform 0.3s ease";
      image.style.pointerEvents = "auto"; // in case it’s inside a container

      image.classList.add("zoomed");
    }
  }
}
