BEGIN {
	init=0;
	i=0;
}
{
	action = $1;
   	time = $2;
   	node_1 = $3;
   	node_2 = $4;
   	src = $5;
   	pktsize = $6;
   	flow_id = $8;
   	node_1_address = $9;
   	node_2_address = $10;
   	seq_no = $11;
   	packet_id = $12;
   
 	#if(action=="r" && node_1==0 && node_2==5 && flow_id==1) {
 		if(action=="r" && node_1==1 && node_2==0 ) {	
 		pkt_byte_sum[i+1]=pkt_byte_sum[i]+ pktsize;
		
		if(init==0) {
			start_time = time;
			init = 1;
		}
		
		end_time[i] = time;
		i = i+1;
	}
}
END {
#Ϊ�˻�ͼ�ÿ����ѵ�һ�ʼ�¼��throughput��Ϊ�㣬�Ա�ʾ���俪ʼ
	printf("%.2f\t%.2f\n", end_time[0], 0);
	
	for(j=1 ; j<i ; j++){
		th = pkt_byte_sum[j] / (end_time[j] - start_time)*8/1000;
		printf("%.2f\t%.2f\n", end_time[j], th);
	}
#Ϊ�˻�ͼ�ÿ����ѵں�һ�ʼ�¼��throughput����Ϊ�㣬�Ա�ʾ�������
	#printf("%.2f\t%.2f\n", end_time[i-1], 0);
}