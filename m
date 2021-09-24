Content-Type: multipart/mixed; boundary="===============6078664254644466065=="
MIME-Version: 1.0
From: 58e33db1-f428-4823-8cc3-d962d0fb8aa8 at slmail.me
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 16:52:25 +0000
Message-ID: <163250234581.8.565414627768410892.14141487@slmail.me>
In-Reply-To: 163249266134.7.13417779072775001445.14130217@simplelogin.co

--===============6078664254644466065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Jason,
> =

> <snip>
> =

> > iwd[4842]: src/station.c:station_connect_cb() 8, result: 0
> > iwd[4842]: src/station.c:station_connect_ok()
> =

> So the interesting thing is that we connect successfully, so the issue is =

> actually in netconfig somewhere.  Can you tell me which version you had b=
efore =

> that worked?  Was it 1.17 or earlier?
> =

> > iwd[4842]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 con=
figuration disabled
> > iwd[4842]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> > iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> > iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX=
 Status(60)
> > iwd[4842]: src/station.c:station_early_neighbor_report_cb() ifindex: 8,=
 error: -110(Connection timed out)
> > =

> > This is the point where connection is stuck and iwctl reports 'connecti=
ng' indefinitely despite being authenticated already.
> =

> Ok, can you get us a log with IWD_DHCP_DEBUG set as well?  See 'man 7 iwd=
.debug'
> =

> Regards,
> -Denis

Here you have. For some reason is not getting an IP:

iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification New Station=
(19)
kernel: wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
kernel: wlan0: send auth to xx:xx:xx:xx:xx:xx (try 2/3)
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Authenticat=
e(37)
iwd[11413]: src/netdev.c:netdev_authenticate_event()
kernel: wlan0: authenticated
kernel: wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
kernel: wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=3D0x1411 status=
=3D0 aid=3D1)
iwd[11413]: src/netdev.c:netdev_unicast_notify() Unicast notification 129
iwd[11413]: src/netdev.c:netdev_control_port_frame_event()
kernel: wlan0: associated
iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Associate(3=
8)
iwd[11413]: src/netdev.c:netdev_associate_event()
iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
iwd[11413]: src/netdev.c:netdev_connect_event()
iwd[11413]: src/eapol.c:eapol_handle_ptk_1_of_4() ifindex=3D6
iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
iwd[11413]: src/netdev.c:netdev_unicast_notify() Unicast notification 129
iwd[11413]: src/netdev.c:netdev_control_port_frame_event()
iwd[11413]: src/eapol.c:eapol_handle_ptk_3_of_4() ifindex=3D6
iwd[11413]: src/netdev.c:netdev_set_gtk() 6
iwd[11413]: src/station.c:station_handshake_event() Setting keys
iwd[11413]: src/netdev.c:netdev_set_tk() 6
iwd[11413]: src/netdev.c:netdev_set_rekey_offload() 6
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Control Por=
t TX Status(139)
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Notify CQM(=
64)
iwd[11413]: src/station.c:station_connect_cb() 6, result: 0
iwd[11413]: src/station.c:station_connect_ok()
iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
iwd[11413]: [DHCPv4] l_dhcp_client_start:1174 Entering state: DHCP_STATE_SE=
LECTING
iwd[11413]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 config=
uration disabled
iwd[11413]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX St=
atus(60)
iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
iwd[11413]: src/station.c:station_early_neighbor_report_cb() ifindex: 6, er=
ror: -110(Connection timed out)
iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
iwd[11413]: [DHCPv4] dhcp_client_send_discover:346

I think is relevant to the bug that I'm using this unit to start iwd.servic=
e:

# /usr/lib/systemd/system/iwd.service
[Unit]
Description=3DWireless service
After=3Dnetwork-pre.target
Before=3Dnetwork.target
Wants=3Dnetwork.target

[Service]
Type=3Ddbus
BusName=3Dnet.connman.iwd
ExecStart=3D/usr/lib/iwd/iwd
NotifyAccess=3Dmain
LimitNPROC=3D1
Restart=3Don-failure
CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
PrivateTmp=3Dtrue
NoNewPrivileges=3Dtrue
DevicePolicy=3Dclosed
DeviceAllow=3D/dev/rfkill rw
ProtectHome=3Dyes
ProtectSystem=3Dstrict
ProtectControlGroups=3Dyes
ProtectKernelModules=3Dyes
ConfigurationDirectory=3Diwd
StateDirectory=3Diwd
StateDirectoryMode=3D0700

[Install]
WantedBy=3Dmulti-user.target

# /etc/systemd/system/iwd.service.d/override.conf
[Service]
RuntimeDirectory=3Dresolvconf
ReadWritePaths=3D/etc/resolv.conf

I remeber adding the override part few months ago due to another bug [1]. F=
or some reason, forcing a disconnect/connect with iwctl doesn't hit the sam=
e problem.

# Generated by resolvconf
nameserver 127.0.0.1
options trust-ad edns0

[1] https://bugs.archlinux.org/task/67069


--===============6078664254644466065==--

