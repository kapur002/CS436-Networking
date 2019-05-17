BEGIN {
    time1 = 0.0;
    time2 = 0.0;
    timeInterval = 0.0;
}

{
    time2 = $2;

    timeInterval = time2-time1;

    if (timeInterval > 0.5)
    {

        throughput_flow10 = bytes_counter_flow0 / timeInterval;
        printf("%f \t %f\n", time2, throughput_flow10) > "CS436Proj1TPAF0.xls";
        bytes_counter_flow0 = 0;


        throughput_flow12 = bytes_counter_flow1 / timeInterval;
        printf("%f \t %f\n", time2, throughput_flow12) > "CS436Proj1TPAF1.xls";
        bytes_counter_flow1 = 0;


       throughput_flow14 = bytes_counter_flow2 / timeInterval;
       printf("%f \t %f\n", time2, throughput_flow14) > "CS436Proj1TPAF2.xls";
       bytes_counter_flow2 = 0;

       throughput_flow15 = bytes_counter_flow3 / timeInterval;
       printf("%f \t %f\n", time2, throughput_flow15) > "CS436Proj1TPAF3.xls";
       bytes_counter_flow3 = 0;

       time1 = $2;
    }

    if ($1 == "r" && $4==10 && $8 == 0)
    {
       bytes_counter_flow0 += $6;
    }

    if ($1 == "r" && $4 == 12 && $8 == 1)
    {
        bytes_counter_flow1 += $6;
    }

    if ($1 == "r" && $4 == 14 && $8 == 2)
    {
        bytes_counter_flow2 += $6;
    }

    if ($1 == "r" && $4 == 15 && $8 == 3)
    {
        bytes_counter_flow3 += $6;
    }

}

END {
    print("<<<<End of awk file>>>>");
}

