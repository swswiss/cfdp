import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { originalContent: String }

  showSpinner(event) {
    const imageId = event.target.closest("[data-image-id]").dataset.imageId
    if (!imageId) return

    const imageElement = document.getElementById(`spinner-image-${imageId}`)
    if (!imageElement) {
      console.warn("Spinner image element not found for ID", imageId)
      return
    }

    // Save original content if not saved yet
    if (!this.hasOriginalContentValue) {
      this.originalContentValue = imageElement.innerHTML
    }

    // Replace with spinner
    imageElement.innerHTML = `
      <div class="flex items-center justify-center h-full w-full">
        <div class="animate-spin inline-block w-10 h-10 border-[3px] border-current border-t-transparent text-indigo-600 rounded-full" role="status" aria-label="loading"></div>
      </div>
    `

    // Remove spinner after 1 second (or whatever)
    setTimeout(() => {
      imageElement.innerHTML = this.originalContentValue
    }, 5000)
  }
}
