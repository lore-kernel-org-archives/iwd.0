Content-Type: multipart/mixed; boundary="===============5420637717473537303=="
MIME-Version: 1.0
From: WU RUXU <wrxzzj@gmail.com>
Subject: virtual interface isn't available in iwd
Date: Tue, 13 Apr 2021 09:59:04 +0800
Message-ID: <CABuKQihA8_VMsG4Rm02QyWSD9MQnag_K9kSWC=cGzDXYu0zFkg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5420637717473537303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hi all

    I have create a virtual interface by following command

 /sbin/iw phy phy0 interface add wlan0_ap type managed
/sbin/ip addr add 192.168.18.1/24 dev wlan0_ap

but it's not available in  device list in iwctl

wlan0_ap is available in hostapd

-- =

Thanks
PGP Fingerprint: F7BA D6CE 6592 77C7 0D2E  3BD5 5479 A15E B305 B8FE

--===============5420637717473537303==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OmdhcmFtb25kLHNlcmlmO2ZvbnQtc2l6ZTpsYXJnZTtjb2xvcjojMDczNzYzIj5oaSBhbGw8
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1v
bmQsc2VyaWY7Zm9udC1zaXplOmxhcmdlO2NvbG9yOiMwNzM3NjMiPjxicj48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWY7Zm9u
dC1zaXplOmxhcmdlO2NvbG9yOiMwNzM3NjMiPsKgwqDCoCBJIGhhdmUgY3JlYXRlIGEgdmlydHVh
bCBpbnRlcmZhY2UgYnkgZm9sbG93aW5nIGNvbW1hbmQ8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWY7Zm9udC1zaXplOmxhcmdl
O2NvbG9yOiMwNzM3NjMiPjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHls
ZT0iZm9udC1mYW1pbHk6Z2FyYW1vbmQsc2VyaWY7Zm9udC1zaXplOmxhcmdlO2NvbG9yOiMwNzM3
NjMiPsKgL3NiaW4vaXcgcGh5IHBoeTAgaW50ZXJmYWNlIGFkZCB3bGFuMF9hcCB0eXBlIG1hbmFn
ZWQ8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6Z2Fy
YW1vbmQsc2VyaWY7Zm9udC1zaXplOmxhcmdlO2NvbG9yOiMwNzM3NjMiPi9zYmluL2lwIGFkZHIg
YWRkIDxhIGhyZWY9Imh0dHA6Ly8xOTIuMTY4LjE4LjEvMjQiPjE5Mi4xNjguMTguMS8yNDwvYT4g
ZGV2IHdsYW4wX2FwPC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQt
ZmFtaWx5OmdhcmFtb25kLHNlcmlmO2ZvbnQtc2l6ZTpsYXJnZTtjb2xvcjojMDczNzYzIj48YnI+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OmdhcmFt
b25kLHNlcmlmO2ZvbnQtc2l6ZTpsYXJnZTtjb2xvcjojMDczNzYzIj5idXQgaXQmIzM5O3Mgbm90
IGF2YWlsYWJsZSBpbsKgIGRldmljZSBsaXN0IGluIGl3Y3RsPC9kaXY+PGRpdiBjbGFzcz0iZ21h
aWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5OmdhcmFtb25kLHNlcmlmO2ZvbnQtc2l6ZTps
YXJnZTtjb2xvcjojMDczNzYzIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIg
c3R5bGU9ImZvbnQtZmFtaWx5OmdhcmFtb25kLHNlcmlmO2ZvbnQtc2l6ZTpsYXJnZTtjb2xvcjoj
MDczNzYzIj53bGFuMF9hcCBpcyBhdmFpbGFibGUgaW4gaG9zdGFwZDxicj48L2Rpdj48YnI+LS0g
PGJyPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWls
PSJnbWFpbF9zaWduYXR1cmUiPlRoYW5rczxicj5QR1AgRmluZ2VycHJpbnQ6IEY3QkEgRDZDRSA2
NTkyIDc3QzcgMEQyRSDCoDNCRDUgNTQ3OSBBMTVFIEIzMDUgQjhGRTwvZGl2PjwvZGl2Pgo=

--===============5420637717473537303==--

