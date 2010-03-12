#!/usr/bin/ruby

ser = File.new(ARGV[0], "r+")

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
