# This awk file calculates the number of packets dropped at node2 at each 0.5 time interval
# for each of the flows, and export the results to a merged excel file for all flows


BEGIN {
   time1 = 0.0;
   time2 = 0.0;
   timeInterval = 0.0;

   droppedatsource_packets_flow0 = 0;
   droppedatsource_packets_flow1 = 0;
   droppedatsource_packets_flow2 = 0;
   droppedatsource_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


      # Export number of received packets to xls file
      printf("%f \t %f \t %f \t %f \t %f\n", time2, droppedatsource_packets_flow0, droppedatsource_packets_flow1, droppedatsource_packets_flow2,
          droppedatsource_packets_flow3) > "droppedpktsatnode.xls";
      droppedatsource_packets_flow0 = 0;
      droppedatsource_packets_flow1 = 0;
      droppedatsource_packets_flow2 = 0;
      droppedatsource_packets_flow3 = 0;


      time1 = $2;

   }




   # if a packet belongs to flow id 0 was dropped at node n2
   if ($1 == "d" && $3 == 2 && $8 == 0) {
      droppedatsource_packets_flow0++;
   }

   # if a packet belongs to flow id 1 was dropped at node n2
   if ($1 == "d" && $3 == 2 && $8 == 1) {
      droppedatsource_packets_flow1++;
   }

   # if a packet belongs to flow id 2 was dropped at node n2
    if ($1 == "d" && $3 == 2 && $8 == 2) {
       droppedatsource_packets_flow2++;
    }

    # if a packet belongs to flow id 3 was dropped at node n2
     if ($1 == "d" && $3 == 2 && $8 == 3) {
        droppedatsource_packets_flow3++;
     }

}

END {
   print("****End of awk file****");
}