# This program calculates the average end-to-end packet delays

BEGIN {
	highest_packet_id = 0;
	time1 = 0;
	delay = 0;
	count = 0;
}

{
	action = $1;

	time2 = $2;

	from = $3;

	to = $4;

	type = $5;

	pktsize = $6;

	flow_id = $8;

	src = $9;

	dst = $10;

	seq_no = $11;

	packet_id = $12;


	if (flow_id == 0) {


		if (action == "+" ){

		
				if ( packet_id > highest_packet_id )

				highest_packet_id = packet_id;


				if ( start_time[packet_id] == 0 ){
					start_time[packet_id] = time2;
				
				}

	} else if ( action == "d" ) {
		end_time[packet_id] = -1; 

	} else if ( action == "r" && to == 2 ) {
					
		end_time[packet_id] = time2;
					
		delay = (delay*count+ (time2 - start_time[packet_id]))/(count+1);
		count++;
	}	

	
	
	timeInterval = time2 - time1;

	if (timeInterval >= 0.5) {

		printf("%f \t %f\n", time2, delay) > "avgdelay_flow0.xls";

		delay = 0;
		count = 0;
		time1 = time2;
	}
}
}

END{
	
}