const Mpris = await Service.import('mpris')

export const PLAYERS = ['spotify']

export const player = Variable()
export const musicStatus = Variable('Stopped')
export const musicTitle = Variable('No Music')
export const musicArtist = Variable('Artist')
export const musicAlbum = Variable('Album')
export const musicVolume = Variable(0)

Mpris.connect('changed', () => {
  const spotifyPlayer = Mpris.players.find(player => PLAYERS.includes(player.name))

  if (!spotifyPlayer) {
    musicStatus.value = 'Stopped'
    musicTitle.value = 'No Music'
    musicArtist.value = 'Artist'
    musicAlbum.value = 'Album'
    musicVolume.value = 0
  }

  spotifyPlayer?.connect('changed', () => {
    player.value = spotifyPlayer

    musicStatus.value = spotifyPlayer.play_back_status
    musicTitle.value = spotifyPlayer.track_title
    musicArtist.value = spotifyPlayer.track_artists.join(', ') || 'Album'
    musicAlbum.value = spotifyPlayer.track_album
    musicVolume.value = spotifyPlayer.volume
  })
})

export function toggle() {
  if (musicStatus.value === 'Stopped') return

  player.value.playPause()
}

export function play() {
  if (musicStatus.value === 'Stopped') return

  player.value.play()
}

export function pause() {
  if (musicStatus.value === 'Stopped') return

  player.value.stop()
}

export function next() {
  if (musicStatus.value === 'Stopped') return

  player.value.next()
}

export function prev() {
  if (musicStatus.value === 'Stopped') return

  player.value.previous()
}

export function setVolume(volume) {
  Utils.exec(`playerctl volume ${volume}`)
}

export default {
  player,
  musicStatus,
  musicTitle,
  musicArtist,
  musicAlbum
}
