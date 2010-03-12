#!/usr/bin/ruby

ser = File.new(ARGV[0], "r+")

stdread = Thread.new do
	while 1
		if buf = $stdin.getc
			ser.print buf
			ser.flush
		end
		Thread.pass
	end
end

serwrite = Thread.new do
	while 1
		if line = ser.readpartial(50)
			print line
			ser.flush
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
