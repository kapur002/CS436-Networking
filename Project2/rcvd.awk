BEGIN {
	time1 = 0.0;
	time2 = 0.0;
	timeInterval = 0.0;

	rcvd_packets_flow0 = 0;
	rcvd_packets_flow1 = 0;
	rcvd_packets_flow2 = 0;
	rcvd_packets_flow3 = 0;
}

{

	time2 = $2;

    timeInterval = time2 - time1;

	if (timeInterval > 0.5) {
		#EXPORT NUMBER OF RECEIVED PACKETS TO XLS FILE
		printf("%f \t %f \t %f \t %f\n", time2, rcvd_packets_flow0, rcvd_packets_flow1, rcvd_packets_flow2, rcvd_packets_flow3) > "receivedpkts.xls";

      	rcvd_packets_flow0 = 0;
      	rcvd_packets_flow1 = 0;
      	rcvd_packets_flow2 = 0;
      	rcvd_packets_flow3 = 0;

      	time1 = $2;

	}
	
	# if the packet arrived at destination node
	if ($1 == "r" && $4 == 10 && $8 == 0){
		rcvd_packets_flow0++;
	}

	# if the packet arrived at destination node
	if ($1 == "r" && $4 == 12 && $8 == 1){
		rcvd_packets_flow1++;
	}

	# if the packet arrived at destination node
	if ($1 == "r" && $4 == 14 && $8 == 2){
		rcvd_packets_flow2++;
	}

	# if the packet arrived at destination node
	if ($1 == "r" && $4 == 15 && $8 == 3){
		rcvd_packets_flow3++;
	}
}

END {
	print("****End of awk file****");
}