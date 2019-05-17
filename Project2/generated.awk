BEGIN {
    time1 = 0.0;
    time2 = 0.0;
    timeInterval = 0.0;


    gen_packets_flow0 = 0;
    gen_packets_flow1 = 0;
    gen_packets_flow2 = 0;
    gen_packets_flow3 = 0;

}

{
   time2 = $2;

   timeInterval = time2 - time1;

   if ( timeInterval > 0.5) {


   # Export cumulative number of generated packets at source to xls file
     printf("%f \t %f \t %f \t %f \t %f\n", time2, gen_packets_flow0, gen_packets_flow1,
gen_packets_flow2, gen_packets_flow3) > "generated.xls";
  gen_packets_flow0 = 0;
  gen_packets_flow1 = 0;
  gen_packets_flow2 = 0;
  gen_packets_flow3 = 0;

      time1 = $2;

   }




   # if a packet belongs to flow id 0 was generated at source node n0
  if ($1 == "+"  && $3 == 8 && $8 == 0) {
     gen_packets_flow0++;
  }

  # if a packet belongs to flow id 1 was generated at source node n0
  if ($1 == "+"  && $3 == 9 && $8 == 1) {
     gen_packets_flow1++;
  }

  # if a packet belongs to flow id 2 was generated at source node n0
  if ($1 == "+"  && $3 == 8 && $8 == 2) {
     gen_packets_flow2++;
  }

  # if a packet belongs to flow id 3 was generated at source node n0
  if ($1 == "+"  && $3 == 9 && $8 == 3) {
     gen_packets_flow3++;
  }


}

END {
   print("****End of awk file****");
}
