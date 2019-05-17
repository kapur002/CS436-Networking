# This awk file calculates the number of packets sent at source at each 0.5 time interval
# for each of the flows, and export the results to a merged excel file for all flows

BEGIN{
  time1 = 0.0;
  time2 = 0.0;
  timeInterval = 0.0;

  sent_packets_flow0 = 0;
  sent_packets_flow1 = 0;
  sent_packets_flow2 = 0;
  sent_packets_flow3 = 0;
}
{
  time2 = $2;

    timeInterval = time2 - time1;

    if(timeInterval > 0.5){
      #EXPORT THE NUMBER OF SENT PACKETS AT SOURCE DURING THE LAST INTERVAL TO XLS FILE
      printf("%f \t %f \t %f \t %f \t %f\n", time2, sent_packets_flow0, sent_packets_flow1, sent_packets_flow2, sent_packets_flow3) > "sent.xls";

      sent_packets_flow0 = 0;
      sent_packets_flow1 = 0;
      sent_packets_flow2 = 0;
      sent_packets_flow3 = 0;

      time1 = $2;
    }

    # if a packet belongs to flow id 0 was sent from node n0
   if ($1 == "-" && $3 == 8 && $8 == 0) {
      sent_packets_flow0++;
   }

   # if a packet belongs to flow id 0 was sent from node n0
   if ($1 == "-" && $3 == 9 && $8 == 1) {
      sent_packets_flow1++;
   }

   # if a packet belongs to flow id 0 was sent from node n0
   if ($1 == "-" && $3 == 8 && $8 == 2) {
      sent_packets_flow2++;
   }

   # if a packet belongs to flow id 0 was sent from node n0
   if ($1 == "-" && $3 == 9 && $8 == 3) {
      sent_packets_flow3++;
   }




}
END{
  print("****End of awk file****");
}
