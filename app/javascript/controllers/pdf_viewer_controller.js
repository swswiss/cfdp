import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal", "iframe", "modalContent"]

  open(event) {
    // Prevent default link behavior
    event.preventDefault()

    const pdfUrl = event.currentTarget.dataset.pdfUrl

    // Set iframe source
    this.iframeTarget.src = pdfUrl

    // Show the modal
    this.modalTarget.classList.remove("hidden")

    // Dynamically adjust width and height
    this.setDimensions(1, 0.8) // 80% width and height
  }

  close() {
    // Close the modal and clear the iframe src
    this.modalTarget.classList.add("hidden")
    this.iframeTarget.src = ""
  }

  setDimensions(widthFactor, heightFactor) {
    const modalWidth = window.innerWidth * widthFactor
    const modalHeight = window.innerHeight * heightFactor

    // Apply dynamic width and height
    this.modalContentTarget.style.width = `${modalWidth}px`
    this.modalContentTarget.style.height = `${modalHeight}px`
  }
}
