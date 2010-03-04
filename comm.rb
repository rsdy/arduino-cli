#!/usr/bin/ruby

File.open(ARGV[0], "r+") do |ser|
	Thread.new do
		while 1
			if line = ser.readpartial(50)
				print line
				$stdout.flush
			end
		end
	end
	
	while 1
		if line = $stdin.readline rescue break
			ser.print line
		end
	end
end
