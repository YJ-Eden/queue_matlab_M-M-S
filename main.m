Ls=[];
Wq=[];
P=[];
E_count=[];
for i=1:1:15
    fprintf(2,'�����˴�������Ϊ%dʱ��\n',i);
    [ls,wq,p,e_count]=MMSkteam(i,50,16,2,120);
    Ls(i)=ls;
    Wq(i)=wq;
    P(i)=p;
    E_count(i)=e_count;
    fprintf('\n');
end

subplot(2,2,1)
plot(Ls);
title('ƽ���ӳ�');
xlabel('���˴�������');
ylabel('ƽ���ӳ�');
set(gca,'xtick',1:1:15);
grid on

box off

subplot(2,2,2)
plot(Wq);
title('ƽ���ȴ�ʱ��');
xlabel('���˴�������');
ylabel('ƽ���ȴ�ʱ��');
set(gca,'xtick',1:1:15);
grid on
box off

subplot(2,2,3)
plot(P);
title('�˿Ͳ������Ͻ��˵ĸ���');
xlabel('���˴�������');
ylabel('�˿Ͳ������Ͻ��˵ĸ���');
set(gca,'xtick',1:1:15);
grid on
box off

subplot(2,2,4)
plot(E_count);
title('��ʧ�˿���');
xlabel('���˴�������');
ylabel('��ʧ�˿���');
set(gca,'xtick',1:1:15);
grid on
box off
