//go:build unix
// +build unix

package main

import (
	"flag"
	"syscall"
)

func setupPlatform() *string {
	// Created files are not world writable
	syscall.Umask(0077)

	configPtr := flag.String("c", "/etc/acme-dns/config.cfg", "config file location")
	flag.Parse()

	return configPtr
}
