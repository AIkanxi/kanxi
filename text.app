#include<iostream>
#include<cmath>
#include<algorithm>
#include<iomanip>
using namespace std;
struct Sta {
	double dis, price;
}S[10];
bool cmp(Sta a, Sta b) {
	return a.dis < b.dis;
}
int main() {
	float s, c, l, p;
	int n;
	cin>>s>>c>>l>>p>>n;
	S[0] = { 0,p };
	for (int i = 1; i <= n; i++) {
		cin >> S[i].dis >> S[i].price;
	}
	S[n + 1].dis = s;
	S[n + 1].price = 0;
	double max1 = c * l;
	sort(S, S + n + 2, cmp);
	int now = 0;
	double oil = 0, prise = 0;
	while (now <= n+1) {
		if (S[now + 1].dis - S[now].dis > max1) {
			cout << "No Solution";
			return 0;
		}
		int last = -1;
		for (int i = now + 1; S[i].dis - S[now].dis < max1; i++) {
			if (S[i].price < S[now].price) {
				double needoil = (S[i].dis - S[now].dis) / l;
				prise += ((needoil - oil) * S[now].price);
				now = i;
				last = i;
				break;
			}
		 }
		if (last == -1) {
			prise += (c - oil) * S[now].price;
			oil = c;
			double mix2 = S[now + 1].price;
			int mix1 = now+1;
			for (int i = now + 2; S[i].dis - S[now].dis < max1; i++) {
				if (mix2 > S[i].price) {
					mix2 = S[i].price;
					mix1 = i;
				}
			}
			oil = c - (S[now].dis - S[mix1].dis) / l;
			now = mix1;
		}
	}
	cout <<fixed<<setprecision(2)<< prise<<endl;
	return 0;
}
