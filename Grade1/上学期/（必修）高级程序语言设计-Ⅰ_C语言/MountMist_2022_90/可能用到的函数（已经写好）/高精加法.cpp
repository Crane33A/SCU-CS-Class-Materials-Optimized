#include<bits/stdc++.h>
using namespace std;
int a[505]={0},b[505]={0},c[510]={0};
string sa,sb;
int la,lb,lc;
int main()
{
	 cin>>sa>>sb;
	 la=sa.size();lb=sb.size();lc=max(la,lb)+1;
	 for(int i=0;i<la;i++)a[la-i]=sa[i]-'0';
	 for(int i=0;i<lb;i++)b[lb-i]=sb[i]-'0';
	 for(int i=1;i<=lc;i++)
	 {
	 	c[i]+=a[i]+b[i];//�ȰѼ�������λ��ӵúͱ�λӦ����ֵ��������+=�����Ѿ�������ǰ�õĽ�λ��
	 	c[i+1]=c[i]/10;//����10���ǽ�λ����12/10=1����Ϊ��һ����λ�ĳ�ʼֵ
	 	c[i]%=10;		//��λȥ����λֵ֮��ʣ�µ�ֵ������λӦ����ʾ��ֵ����12%10=2
	 }
	 if(c[lc]==0&&lc>0)lc--;
	 for(int i=lc;i>0;i--)cout<<c[i];
	
return 0;
}

