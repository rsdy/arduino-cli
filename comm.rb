#!/usr/bin/ruby

require 'rubygems'
require 'serialport'

ser = SerialPort.new ARGV[0], ARGV[1].to_i, 8, 1, SerialPort::NONE

stdread = Thread.new do
	while 1
		if buf = $stdin.getc
			ser.putc buf
			ser.flush
		end
		Thread.pass
	end
end

serwrite = Thread.new do
	while 1
		if buf = ser.readpartial(50)
			print buf
			$stdout.flush
		end
		Thread.pass
	end
end

trap("INT") { stdread.exit }

`stty cbreak`
stdread.join
ser.close
`stty -cbreak`
