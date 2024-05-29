function getPkgs() {
  return Utils.exec(
    `script -qc "pacman -Q | wc -l" /dev/null`
  )
}

function getUptime() {
  return Utils.exec(
    `script -qc "uptime -p | awk '{print $2, $3}' | cut -d ',' -f1" /dev/null`
  )
}

function getOs() {
  return Utils.exec(
    `script -qc "hostnamectl | grep 'Operating System' | awk '{print $3, $4}'" /dev/null`
  )
}

function getShell() {
  return Utils.exec(
    `script -qc "cat /etc/passwd | grep axo | awk -F: '{print $7}' | awk -F/ '{print $NF}'" /dev/null` /* replace "axo" with your username */
  )
}

export default {
  type: 'dir',
  children: {
    user: {
      type: 'file',
      icon: '',
      value: Utils.exec(`whoami`)
    },
    // host: {
    //   type: 'file',
    //   icon: '',
    //   value: Utils.exec(`hostnamectl hostname`)
    // },
    os: {
      type: 'widget',
      icon: '',
      spacing: 3,
      widget: Widget.Label({
        label: getOs(),
        setup: (self) => self.poll(100, () => {
          self.label = getOs()
        })
      })
    },
    sh: {
      type: 'widget',
      icon: '',
      spacing: 3,
      widget: Widget.Label({
        label: getShell(),
        setup: (self) => self.poll(100, () => {
          self.label = getShell()
        })
      })
    },
    pkgs: {
      type: 'widget',
      icon: '󰏓',
      widget: Widget.Label({
        label: getPkgs(),
        setup: (self) => self.poll(5000, () => {
          self.label = getPkgs()
        })
      })
    },
    up: {
      type: 'widget',
      icon: '',
      spacing: 3,
      widget: Widget.Label({
        label: getUptime(),
        setup: (self) => self.poll(1000, () => {
          self.label = getUptime()
        })
      })
    }
  }
}
