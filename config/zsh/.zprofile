# If running from tty1 start sway
if [ "$(tty)" = "/dev/tty1" ]; then
	exec /usr/local/bin/sway-service.sh
fi
