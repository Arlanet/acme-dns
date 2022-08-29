//go:build windows
// +build windows

package main

import "flag"

func setupPlatform() *string {
	configPtr := flag.String("c", "./config.cfg", "config file location")
	flag.Parse()

	return configPtr
}
