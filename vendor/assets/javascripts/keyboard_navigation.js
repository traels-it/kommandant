import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["focusable"]
  static values = { activeOptionIndex: { type: Number, default: 0 } }

  connect() {
    if (this.activeOption) {
      this.activateOption()
    }
  }

  down(event) {
    event.preventDefault()

    if (this.activeOptionIndexValue < (this.focusableTargets.length - 1)) {
      this.deactivateOption()
      this.activeOptionIndexValue++
      this.activateOption()
    }
  }

  up(event) {
    event.preventDefault()

    if (this.activeOptionIndexValue > 0) {
      this.deactivateOption()
      this.activeOptionIndexValue--
      this.activateOption()
    }
  }

  focus(event) {
    this.deactivateOption()
    this.activeOptionIndexValue = this.focusableTargets.indexOf(event.currentTarget)
    this.activateOption()
  }

  select(event) {
    if (this.hasFocusableTarget) {
      event.preventDefault()

      this.activeOption.click()
    }
  }

  // Private

  deactivateOption() {
    this.activeOption.dataset.active = false
  }

  activateOption() {
    this.activeOption.dataset.active = true
  }

  focusableTargetDisconnected() {
    this.activeOptionIndexValue = 0
  }

  focusableTargetConnected() {
    this.activateOption()
  }

  get activeOption() {
    return this.focusableTargets[this.activeOptionIndexValue]
  }
}
