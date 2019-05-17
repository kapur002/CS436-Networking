#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a Trace File
set tracefd [open proj1.tr w]
$ns trace-all $tracefd

#Network Topology Shows 17 Nodes. So, we create 17 Nodes.
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]

$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns queue-limit $n8 $n0 20

$ns duplex-link $n9 $n1 1Mb 20ms DropTail
$ns queue-limit $n9 $n1 20

$ns duplex-link $n5 $n10 1Mb 20ms DropTail
$ns queue-limit $n5 $n10 20

$ns duplex-link $n5 $n11 1Mb 20ms DropTail
$ns queue-limit $n5 $n11 20

$ns duplex-link $n5 $n12 1Mb 20ms DropTail
$ns queue-limit $n5 $n12 20

$ns duplex-link $n5 $n13 1Mb 20ms DropTail
$ns queue-limit $n5 $n13 20

$ns duplex-link $n6 $n14 1Mb 20ms DropTail
$ns queue-limit $n6 $n14 20

$ns duplex-link $n6 $n15 1Mb 20ms DropTail
$ns queue-limit $n6 $n15 20

$ns duplex-link $n7 $n16 1Mb 20ms DropTail
$ns queue-limit $n7 $n16 20

$ns duplex-link $n7 $n17 1Mb 20ms DropTail
$ns queue-limit $n7 $n17 20

$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns queue-limit $n0 $n2 25

$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns queue-limit $n1 $n2 25

$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns queue-limit $n3 $n5 25

$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns queue-limit $n4 $n6 25

$ns duplex-link $n4 $n7 2Mb 40ms DropTail
$ns queue-limit $n4 $n7 25

$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns queue-limit $n2 $n3 30

$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns queue-limit $n2 $n4 30

$ns duplex-link $n3 $n4 8Mb 100ms DropTail
$ns queue-limit $n3 $n4 30

#Create a UDP agent for each BLUE traffic source and each to node 9 ($n9).
set udp0 [new Agent/UDP]
$ns attach-agent $n9 $udp0
set udp1 [new Agent/UDP]
$ns attach-agent $n9 $udp1
set udp2 [new Agent/UDP]
$ns attach-agent $n9 $udp2
set udp3 [new Agent/UDP]
$ns attach-agent $n9 $udp3


# Create a CBR generator for each BLUE traffic source and attach to corresponding UDP agent.
set cbr12 [new Application/Traffic/CBR]
$cbr12 set packetSize_ 1000
$cbr12 set interval_ 0.005
$cbr12 set random_ 1
$cbr12 attach-agent $udp0

set cbr13 [new Application/Traffic/CBR]
$cbr13 set packetSize_ 3000
$cbr13 set interval_ 0.005
$cbr13 set random_ 1
$cbr13 attach-agent $udp1

set cbr15 [new Application/Traffic/CBR]
$cbr15 set packetSize_ 2000
$cbr15 set interval_ 0.005
$cbr15 set random_ 1
$cbr15 attach-agent $udp2

set cbr17 [new Application/Traffic/CBR]
$cbr17 set packetSize_ 2000
$cbr17 set interval_ 0.005
$cbr17 set random_ 1
$cbr17 attach-agent $udp3

#Create LossMonitor agent for each BLUE traffic source & attach to nodes.
set sink12 [new Agent/LossMonitor]
$ns attach-agent $n12 $sink12
set sink13 [new Agent/LossMonitor]
$ns attach-agent $n13 $sink13
set sink15 [new Agent/LossMonitor]
$ns attach-agent $n15 $sink15
set sink17 [new Agent/LossMonitor]
$ns attach-agent $n17 $sink17


#Connect the traffic sinks & traffic source together.
$ns connect $udp0 $sink12
$ns connect $udp1 $sink13
$ns connect $udp2 $sink15
$ns connect $udp3 $sink17

#Create a TCP agent for each RED traffic source. Attach each to node9 ($n9).
set tcp0 [new Agent/TCP/Linux]
$ns attach-agent $n8 $tcp0
set tcp1 [new Agent/TCP/Linux]
$ns attach-agent $n8 $tcp1
set tcp2 [new Agent/TCP/Linux]
$ns attach-agent $n8 $tcp2
set tcp3 [new Agent/TCP/Linux]
$ns attach-agent $n8 $tcp3


# Create a CBR generator for each traffic source & attach to corresponding UDP agent.
set cbr10 [new Application/Traffic/CBR]
$cbr10 set packetSize_ 1000
$cbr10 set interval_ 0.005
$cbr10 set random_ 1
$cbr10 attach-agent $tcp0

set cbr11 [new Application/Traffic/CBR]
$cbr11 set packetSize_ 3000
$cbr11 set interval_ 0.005
$cbr11 set random_ 1
$cbr11 attach-agent $tcp1

set cbr14 [new Application/Traffic/CBR]
$cbr14 set packetSize_ 2000
$cbr14 set interval_ 0.005
$cbr14 set random_ 1
$cbr14 attach-agent $tcp2

set cbr16 [new Application/Traffic/CBR]
$cbr16 set packetSize_ 2000
$cbr16 set interval_ 0.005
$cbr16 set random_ 1
$cbr16 attach-agent $tcp3

#Create a LossMonitor agent for each BLUE traffic source and attach to corresponding nodes.
set sink10 [new Agent/TCPSink]
$ns attach-agent $n10 $sink10
set sink11 [new Agent/TCPSink]
$ns attach-agent $n11 $sink11
set sink14 [new Agent/TCPSink]
$ns attach-agent $n14 $sink14
set sink16 [new Agent/TCPSink]
$ns attach-agent $n16 $sink16

#Connect traffic sink & traffic source together.
$ns connect $tcp0 $sink10
$ns connect $tcp1 $sink11
$ns connect $tcp2 $sink14
$ns connect $tcp3 $sink16

#Set Flow ID for traffic.
$tcp0 set fid_ 0
$udp0 set fid_ 1
$tcp2 set fid_ 2
$udp2 set fid_ 3

#Schedule events for the CBR agent and the network dynamics
$ns at 1.0 "$cbr10 start"
$ns at 1.0 "$cbr11 start"
$ns at 1.0 "$cbr14 start"
$ns at 1.0 "$cbr16 start"
$ns at 2.0 "$cbr12 start"
$ns at 2.0 "$cbr13 start"
$ns at 2.0 "$cbr15 start"
$ns at 2.0 "$cbr17 start"
$ns rtmodel-at 6.0 down $n2 $n3
$ns rtmodel-at 7.0 up $n2 $n3
$ns at 10.0 "$cbr10 stop"
$ns at 10.0 "$cbr11 stop"
$ns at 10.0 "$cbr12 stop"
$ns at 10.0 "$cbr13 stop"
$ns at 10.0 "$cbr14 stop"
$ns at 10.0 "$cbr15 stop"
$ns at 10.0 "$cbr16 stop"
$ns at 10.0 "$cbr17 stop"
#Call the finish procedure after 5 seconds of simulation time
$ns at 12.0 "exit 0"


#Run the simulation
$ns run
