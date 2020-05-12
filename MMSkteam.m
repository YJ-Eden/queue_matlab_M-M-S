function [Ls,Wq,P,e_count] = MMSkteam(s,k,lamda,mu,T)
	%�����̨
	%s??����̨����
	%k??���˿͵ȴ���
	%T??ʱ����ֹ��
	%lamda??����ʱ�������Ӳ��ɷֲ�
	%mu??����ʱ����Ӹ�ָ���ֲ�
	%�¼���
	%arrive_time??�˿͵����¼�
	%leave_time??�˿��뿪�¼�
	%mintime??�¼����е�����¼�
	%current_time??��ǰʱ��
	%L??�ӳ�
    %LMax??���ӳ�
	%tt??ʱ������
	%LL??�ӳ�����
	%c??�˿͵���ʱ������
	%b??����ʼʱ������
	%e??�˿��뿪ʱ������
	%a_count??����˿���
	%b_count??����˿���
	%e_count??��ʧ�˿���
    %P??�˿Ͳ������ϵõ�����ĸ���

	%��ʼ��
	%exprnd���ɷ���ָ��lamda�ֲ��������
	arrive_time=exprnd(lamda);
	leave_time=[];
	current_time=0;
	L=0;
    LMax=0;
	LL=[L];
	tt=[current_time];
	c=[];
	b=[];
	e=[];
	a_count=0;
	b_count=0;
	e_count=0;
    lamda=1/lamda;
    mu=1/mu;

	%ѭ��
	while min([arrive_time,leave_time])<T
		current_time=min([arrive_time,leave_time]);
		tt=[tt,current_time];	%��¼ʱ������
		if current_time==arrive_time 	%�˿͵����ӹ���
			arrive_time=arrive_time+exprnd(lamda);	%ˢ�¹˿͵����¼�
			a_count=a_count+1;	%�ۼӵ���˿���
			if L<s 	%�п��з���̨
				L=L+1;	%���¶ӳ�
                if L>LMax
                    LMax=L;
                end
				b_count=b_count+1;	%�ۼӷ���˿���
				c=[c,current_time];	%��¼�˿͵���ʱ������
				b=[b,current_time];	%��¼����ʼʱ������
				leave_time=[leave_time,current_time+exprnd(mu)];	%�����µĹ˿��뿪�¼�
				leave_time=sort(leave_time);	%�뿪�¼�������
			elseif L<s+k 	%�п��еȴ�λ
				L=L+1;	%���¶ӳ�
                if L>LMax
                    LMax=L;
                end
				b_count=b_count+1;	%�ۼӷ���˿���
				c=[c,current_time];	%��¼�˿͵���ʱ������
			else
				e_count=e_count+1;	%�ۼ���ʧ�˿���
			end
		else 	%�˿��뿪�ӹ���
			leave_time(1)=[];	%���¼�����Ĩȥ�˿��뿪�¼�
			e=[e,current_time];	%��¼�˿��뿪�¼�����
			if L>s 	%�й˿͵ȴ�
				L=L-1;	%���¶ӳ�
                if L>LMax
                    LMax=L;
                end
				b=[b,current_time];	%��¼����ʼʱ������
				leave_time=[leave_time,current_time+exprnd(mu)];
				leave_time=sort(leave_time);	%�뿪�¼�������
			else 	%�޹˿͵ȴ�
				L=L-1;	%���¶ӳ�
			end
		end
		LL=[LL,L];	%��¼�ӳ�����
	end
	Ws=sum(e-c(1:length(e)))/length(e);
	Wq=sum(b-c(1:length(b)))/length(b);
	Wb=sum(e-b(1:length(e)))/length(e);
	Ls=sum(diff([tt,T]).*LL)/T;
	Lq=sum(diff([tt,T]).*max(LL-s,0))/T;
	fprintf('����˿�����%d\n',a_count);	%����˿���
	fprintf('����˿�����%d\n',b_count);	%����˿���
	fprintf('��ʧ�˿�����%d\n',e_count);	%��ʧ�˿���
    fprintf('ƽ������ʱ�䣺%f\n',Wb);	%ƽ������ʱ��
% 	fprintf('ƽ������ʱ�䣺%f\n',Ws);	%ƽ������ʱ��
    fprintf('ƽ���ӳ���%f\n',Ls);	%ƽ���ӳ�
    fprintf('ƽ���ȴ�ʱ����%f\n',Wq);	%ƽ���ȴ�ʱ��
% 	fprintf('ƽ���ȴ��ӳ���%f\n',Lq);	%ƽ���ȴ��ӳ�
	if k~=inf
		for i=0:LMax
			p(i+1)=sum((LL==i).*diff([tt,T]))/T;	%�ӳ�Ϊi�ĸ���
% 			fprintf('�ӳ�Ϊ%d�ĸ��ʣ�%f\n',i,p(i+1));
        end
    end
    P=1-sum(p(1:LMax));
    fprintf('�˿Ͳ������ϵõ�����ĸ���:%f\n',P);	%�˿Ͳ������ϵõ�����ĸ���
	out=[Ls,Wq,P,e_count];