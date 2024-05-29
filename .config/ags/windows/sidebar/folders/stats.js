export default {
  type: 'dir',
  children: {
    bat: {
      type: 'widget',
      icon: ' ',
      spacing: 2,
      widget: Widget.Box({
        homogeneous: false,
        children: [
          Widget.Label('['),
          Widget.ProgressBar({
            className: 'metric',
            setup: (self) => self.poll(10000, () => {
              self.value = parseFloat(Utils.exec('cat /sys/class/power_supply/BAT0/capacity')) / 100
            })
          }),
          Widget.Label(']')
        ]
      }),
    },
    cpu: {
      type: 'widget',
      icon: ' ',
      spacing: 2,
      widget: Widget.Box({
        homogeneous: false,
        children: [
          Widget.Label('['),
          Widget.ProgressBar({
            className: 'metric',
            setup: (self) => self.poll(2500, () => {
              const cpuLine = Utils.exec(`top -b -n 1`)
                .split('\n')
                .find(line => line.includes('Cpu(s)'))

              if (cpuLine) {
                const cpu = cpuLine.split(/\s+/)[1].replace(',', '.')
                self.value = parseFloat(cpu) / 100
              }
            })
          }),
          Widget.Label(']')
        ]
      })
    },
    ram: {
      type: 'widget',
      icon: ' ',
      spacing: 2,
      widget: Widget.Box({
        homogeneous: false,
        children: [
          Widget.Label('['),
          Widget.ProgressBar({
            className: 'metric',
            setup: (self) => self.poll(2500, () => {
              const memLine = Utils.exec(`free`)
                .split('\n')
                .find(line => line.includes('Mem:'))

              if (memLine) {
                const [total, used] = memLine.split(/\s+/).splice(1, 2)
                self.value = parseFloat(used) / parseFloat(total)
              }
            })
          }),
          Widget.Label(']')
        ]
      })
    },
    disk: {
      type: 'widget',
      icon: '󰉉 ',
      widget: Widget.Box({
        homogeneous: false,
        children: [
          Widget.Label('['),
          Widget.ProgressBar({
            className: 'metric',
            setup: (self) => self.poll(10000, () => {
              const diskLine = Utils.exec(`df -h`)
                .split('\n')
                .find(line => line.includes('/'))

              if (diskLine) {
                const [size, used] = diskLine.split(/\s+/).map(v => v.replace(/G/g, '')).splice(1, 2)
                const parsedSize = parseFloat(size)
                const parsedUsed = parseFloat(used)

                if (!isNaN(parsedSize) && !isNaN(parsedUsed) && parsedSize !== 0) {
                  self.value = parsedUsed / parsedSize
                }
              }
            })
          }),
          Widget.Label(']')
        ]
      })
    }
  }
}