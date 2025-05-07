import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="image-preview"
export default class extends Controller {
  static targets = ["input", "preview"]

  previewImages() {
    const files = Array.from(this.inputTarget.files)
    this.previewTarget.innerHTML = "" // Clear previous previews

    files.forEach(file => {
      if (file.type.startsWith("image/")) {
        const reader = new FileReader()

        reader.onload = e => {
          const img = document.createElement("img")
          img.src = e.target.result
          img.className = "h-16 w-16 object-cover rounded-md border"
          this.previewTarget.appendChild(img)
        }

        reader.readAsDataURL(file)
      } else if (file.type === "application/pdf") {
        const icon = document.createElement("div")
        icon.textContent = "📄 PDF"
        icon.className = "h-16 w-16 flex items-center justify-center bg-gray-100 text-sm border rounded"
        this.previewTarget.appendChild(icon)
      }
    })
  }
  clearPreviews(event) {
    // Optional: Disable the button to prevent double-submit
    console.log("234567")
    event.target.querySelector('input[type="submit"]')?.setAttribute('disabled', 'disabled')
    this.previewTarget.innerHTML = ""
  }
}
