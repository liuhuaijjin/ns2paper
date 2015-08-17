BEGIN {
#�����ʼ��
   old_time=0;
   old_seq_no=0;
   i=0;
}
{
   action = $1;
   time = $2;
   node_1 = $3;
   node_2 = $4;
   type = $5;
   flow_id = $8;
   node_1_address = $9;
   node_2_address = $10;
   seq_no = $11;
   packet_id = $12;
  
#�ж��Ƿ�Ϊn2���͵�n3���ҷ����̬Ϊcbr������Ϊ���ܷ��
   if(node_1==2 && node_2==3 && type=="cbr" && action=="r") {
#���Ŀǰ�������ź��ϴγɹ����յ���Ų�ֵ
	dif=seq_no-old_seq_no;

#�����һ�����շ��
        if(dif==0)  
          dif=1;

#���jitter
      	jitter[i]=(time-old_time)/dif;
      	seq[i]=seq_no;
		i=i+1;
      	old_seq_no=seq_no;
      	old_time=time;
   }     
}
END {
   for (j=1; j <i ;j++)
    printf("%d\t%f\n",seq[j],jitter[j]);
}