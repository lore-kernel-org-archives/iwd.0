Content-Type: multipart/mixed; boundary="===============5969849794087238799=="
MIME-Version: 1.0
From: 54d22547-afc0-4701-b1fc-5a2a2e411646 at simplelogin.co
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 27 Jan 2022 17:51:30 +0000
Message-ID: <20220127175130.2828.48049@ml01.vlan13.01.org>
In-Reply-To: a37fbc925b5695daedd33be9f110d13d2776eaf3.camel@gmail.com

--===============5969849794087238799==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi again,

I managed to trigger the problem while dumping tcp packets. Here is the res=
ult:

# ~ tcpdump -i wlan0 port 67 or port 68 -s 0 -w dhcp.pcap
tcpdump: listening on wlan0, link-type EN10MB (Ethernet), snapshot length 2=
62144 bytes
^C
12 packets captured
12 packets received by filter
0 packets dropped by kernel

# ~ tcpdump -r dhcp.pcap =

reading from file dhcp.pcap, link-type EN10MB (Ethernet), snapshot length 2=
62144
18:33:36.492009 IP _gateway.bootps > 192.168.1.35.bootpc: BOOTP/DHCP, Reply=
, length 284
18:33:36.492212 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:33:38.606330 IP _gateway.bootps > 192.168.1.36.bootpc: BOOTP/DHCP, Reply=
, length 284
18:33:40.021633 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:33:48.860117 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:34:05.360324 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:34:14.092945 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:34:14.705123 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:34:16.217430 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply, length=
 284
18:34:16.217613 IP 0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Req=
uest from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
18:34:16.313729 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply, length=
 284
18:34:16.320877 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply, length=
 284

So I stopped / started iwd.service and checked that connection was lost (no=
 ping). Then started dumping packets while iwctl was constantly reporting '=
connecting' state. From there I just disconnected and connected again succe=
ssfully and aborted tcpdump.
--===============5969849794087238799==--

