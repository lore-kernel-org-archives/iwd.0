Content-Type: multipart/mixed; boundary="===============6726205017080068566=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Thu, 27 Jan 2022 11:00:51 -0800
Message-ID: <c30d0db9e529dcdebfad5e55de3c476597075635.camel@gmail.com>
In-Reply-To: 20220127175130.2828.48049@ml01.vlan13.01.org

--===============6726205017080068566==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-01-27 at 17:51 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Hi again,
> =

> I managed to trigger the problem while dumping tcp packets. Here is
> the result:
> =

> # ~ tcpdump -i wlan0 port 67 or port 68 -s 0 -w dhcp.pcap
> tcpdump: listening on wlan0, link-type EN10MB (Ethernet), snapshot
> length 262144 bytes
> ^C
> 12 packets captured
> 12 packets received by filter
> 0 packets dropped by kernel
> =

> # ~ tcpdump -r dhcp.pcap =

> reading from file dhcp.pcap, link-type EN10MB (Ethernet), snapshot
> length 262144
> 18:33:36.492009 IP _gateway.bootps > 192.168.1.35.bootpc: BOOTP/DHCP,
> Reply, length 284
> 18:33:36.492212 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:33:38.606330 IP _gateway.bootps > 192.168.1.36.bootpc: BOOTP/DHCP,
> Reply, length 284
> 18:33:40.021633 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:33:48.860117 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:34:05.360324 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:34:14.092945 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:34:14.705123 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:34:16.217430 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply,
> length 284
> 18:34:16.217613 IP 0.0.0.0.bootpc > 255.255.255.255.bootps:
> BOOTP/DHCP, Request from xx:xx:xx:xx:xx:xx (oui Unknown), length 300
> 18:34:16.313729 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply,
> length 284
> 18:34:16.320877 IP _gateway.bootps > host.bootpc: BOOTP/DHCP, Reply,
> length 284
> =

> So I stopped / started iwd.service and checked that connection was
> lost (no ping). Then started dumping packets while iwctl was
> constantly reporting 'connecting' state. From there I just
> disconnected and connected again successfully and aborted tcpdump.

Could you also attach the actual pcap file for inspection? Something in
the packet is not validating but we have no way of knowing without
seeing the actual packet contents.

Thanks,
James

> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============6726205017080068566==--

