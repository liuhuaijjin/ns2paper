BEGIN {
#�����ʼ��,�趨һ������¼packet��drop����Ŀ
	fsDrops = 0;
	numFs = 0;
}
{
   action = $1;
   time = $2;
   node_1 = $3;
   node_2 = $4;
   src = $5;
   flow_id = $8;
   node_1_address = $9;
   node_2_address = $10;
   seq_no = $11;
   packet_id = $12;

#ͳ�ƴ�n1�ͳ�����packets
	if (node_1==6 && node_2==0 && action == "+") 
		numFs++;
	
#ͳ��flow_idΪ2,�ұ�drop�ķ��
	if ((flow_id==13 ||flow_id==14||flow_id==15)&& action == "d") 
		fsDrops++;
}
END {
	printf("number of packets sent:%d lost:%d,loss ratio:%f\n", numFs, fsDrops,fsDrops/numFs);
}