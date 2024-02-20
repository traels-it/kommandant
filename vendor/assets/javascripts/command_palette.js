import { Controller } from "@hotwired/stimulus"
import { enter, leave, toggle } from "./transition"
import debounce from "debounce"

export default class extends Controller {
  static targets = ["background", "panel", "input", "content", "loadingMessage", "previousPageLink", "nextPageLink"]
  static values = {
    open: { type: Boolean, default: false },
    loadingMessageDelay: { type: Number, default: 100 },
    animationDuration: { type: Number, default: 200 },
    modifierKeyDown: { type: Boolean, default: false }
  }

  initialize() {
    this.submit = debounce(this.submit.bind(this), 500)
  }

  toggle(event) {
    event.preventDefault()

    toggle(this.backgroundTarget)
    toggle(this.panelTarget)
    this.openValue = !this.openValue
  }

  show(event) {
    event.preventDefault()

    enter(this.backgroundTarget)
    enter(this.panelTarget)
    this.openValue = true
  }

  hide(event) {
    event.preventDefault()

    leave(this.backgroundTarget)
    leave(this.panelTarget)
    this.openValue = false
  }

  hideWithBackgroundOverlay(event) {
    if (event.target === this.panelTarget) {
      this.hide(event)
    }
  }

  submit(event) {
    const ignoreKeys = ["Enter", "Tab", "Escape", "ArrowUp", "ArrowDown", "ArrowLeft", "ArrowRight", "Home", "End", "Alt", "Control", "Meta", "Shift"]
    const modifierKeyPressed = event.ctrlKey || event.metaKey

    if (!modifierKeyPressed && !ignoreKeys.includes(event.key) && this.inputTarget.value !== "") {
      this.inputTarget.form.requestSubmit()
    }
  }

  reset() {
    setTimeout(() => {
      Turbo.visit("/kommandant/searches/new", { frame: "command_palette" })
    }, this.animationDurationValue)
  }

  showLoadingMessage() {
    this.loadingTimeout = setTimeout(() => {
      this.contentTarget.classList.add("hidden")
      this.loadingMessageTarget.classList.remove("hidden")
    }, this.loadingMessageDelayValue)
  }

  nextPage(event) {
    event.preventDefault()

    if (this.hasNextPageLinkTarget) {
      this.nextPageLinkTarget.click()
    }
  }

  previousPage(event) {
    event.preventDefault()

    if (this.hasPreviousPageLinkTarget) {
      this.previousPageLinkTarget.click()
    }
  }

  // Private

  openValueChanged(value, previousValue) {
    this.focusInputTarget()

    if (value === false && previousValue !== undefined) {
      this.reset()
    }
  }

  inputTargetConnected() {
    this.focusInputTarget()
    clearTimeout(this.loadingTimeout)
  }

  focusInputTarget() {
    if (this.openValue) {
      this.inputTarget.focus()

      // Set cursor at end of inputted text
      let temp = this.inputTarget.value
      this.inputTarget.value = ""
      this.inputTarget.value = temp
    }
  }
}
