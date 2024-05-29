const Hyprland = await Service.import('hyprland')

const STATES_PATH = `${App.configDir}/.states.json`

/**
 * Manage state on ~/.config/ags/.states.json
 *
 * @param {string} key - the key in the json file
 * @param {any} value - default value
 * @returns {Object}
 */
export function state(key, value) {
  const state = Variable(value)

  Utils.monitorFile(STATES_PATH, (file, event) => {
    if (event === 0) {
      const fileData = Utils.readFile(file)
      if (fileData) {
        try {
          const states = JSON.parse(fileData)
          state.value = states[key]
        } catch (error) {
          console.error('Error parsing JSON:', error)
        }
      }
    }
  })

  state.connect('changed', ({ value }) => {
    const fileData = Utils.readFile(STATES_PATH)
    if (fileData) {
      try {
        const states = JSON.parse(fileData)
        states[key] = value
        Utils.writeFile(JSON.stringify(states), STATES_PATH)
      } catch (error) {
        console.error('Error parsing JSON:', error)
      }
    }
  })

  return state
}

export function debounce({ called, fn }, delay = 30) {
  let id

  return function() {
    const context = this
    const args = arguments

    called.apply(context, args)

    clearTimeout(id)

    id = setTimeout(() => {
      fn.apply(context, args)
    }, delay)
  }
}

export function hyprSendMessage(cmd) {
  return JSON.parse(Hyprland.message(`j/${cmd}`))
}

export function getDate(prop) {
  const date = JSON.parse(Utils.exec(`date +'{"date": "%d", "month": "%b", "year": "%Y", "time": "%H:%M", "day": "%A"}'`))

  return !prop ? date : date[prop]
}

export default {
  state,
  debounce,
  hyprSendMessage,
  getDate
}
