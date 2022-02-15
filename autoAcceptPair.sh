#!/usr/bin/expect -f
set prompt "#"
spawn bluetoothctl
sleep 0.1
expect -re $prompt
send "agent NoInputNoOutput\r"
expect -re $prompt
send "default-agent\r"
expect "Confirm passkey"
send "yes\r"
expect "Confirm passkey"
send "yes\r"
expect "Confirm passkey"
send "yes\r"
expect "Confirm passkey
send "yes\r"
sleep 5
send "exit"
