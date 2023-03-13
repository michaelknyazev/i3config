package main

import (
	"fmt"
	"os"

	"github.com/godbus/dbus/v5"
)

type Metadata struct {
	Artist      []string `spotify:"xesam:artist"`
	Title       string   `spotify:"xesam:title"`
	Album       string   `spotify:"xesam:album"`
	AlbumArtist []string `spotify:"xesam:albumArtist"`
	AutoRating  float64  `spotify:"xesam:autoRating"`
	DiskNumber  int32    `spotify:"xesam:discNumber"`
	TrackNumber int32    `spotify:"xesam:trackNumber"`
	URL         string   `spotify:"xesam:url"`
	TrackID     string   `spotify:"mpris:trackid"`
	Length      uint64   `spotify:"mpris:length"`
}

func main() {

	conn, err := dbus.ConnectSessionBus()
	if err != nil {
		fmt.Println("failed to connect to dbus")
		os.Exit(1)
	}

	defer conn.Close()

	obj := conn.Object("org.mpris.MediaPlayer2.spotify", "/org/mpris/MediaPlayer2")
	call := obj.Call("org.freedesktop.DBus.Properties.Get", 0, "string:'org.mpris.MediaPlayer2.Player'",
		"string:'Metadata'")
	if call.Err != nil {
		panic(call.Err)
	}
}

//dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata'
