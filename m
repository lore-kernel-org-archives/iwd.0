Content-Type: multipart/mixed; boundary="===============4924621610472018623=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 11:57:09 -0500
Message-ID: <3a9f6e85-0be0-287e-58ef-8869b1043bd1@gmail.com>
In-Reply-To: 163250234575.8.9880076218905141817.14141486@slmail.me

--===============4924621610472018623==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

> Here you have. For some reason is not getting an IP:
> =


<snip>

> iwd[11413]: src/station.c:station_connect_cb() 6, result: 0
> iwd[11413]: src/station.c:station_connect_ok()

Yep, so we connect OK, start DHCP

> iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> iwd[11413]: [DHCPv4] l_dhcp_client_start:1174 Entering state: DHCP_STATE_=
SELECTING
> iwd[11413]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 conf=
iguration disabled
> iwd[11413]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX =
Status(60)
> iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> iwd[11413]: src/station.c:station_early_neighbor_report_cb() ifindex: 6, =
error: -110(Connection timed out)
> iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> =


But nothing gets received from the DHCP server.  I'm a bit stumped since we =

haven't touched anything related to dhcp between 1.17 and 1.18.  We started =

sending the DHCP rapid commit option in iwd 1.17, so maybe that is why your =

server is ignoring us?

Does starting dhcpcd or something while iwd is in this 'connecting' state o=
btain =

an IP?

> I think is relevant to the bug that I'm using this unit to start iwd.serv=
ice:
> =

> # /usr/lib/systemd/system/iwd.service
> [Unit]
> Description=3DWireless service
> After=3Dnetwork-pre.target
> Before=3Dnetwork.target
> Wants=3Dnetwork.target
> =

> [Service]
> Type=3Ddbus
> BusName=3Dnet.connman.iwd
> ExecStart=3D/usr/lib/iwd/iwd
> NotifyAccess=3Dmain
> LimitNPROC=3D1
> Restart=3Don-failure
> CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
> PrivateTmp=3Dtrue
> NoNewPrivileges=3Dtrue
> DevicePolicy=3Dclosed
> DeviceAllow=3D/dev/rfkill rw
> ProtectHome=3Dyes
> ProtectSystem=3Dstrict
> ProtectControlGroups=3Dyes
> ProtectKernelModules=3Dyes
> ConfigurationDirectory=3Diwd
> StateDirectory=3Diwd
> StateDirectoryMode=3D0700
> =

> [Install]
> WantedBy=3Dmulti-user.target
> =

> # /etc/systemd/system/iwd.service.d/override.conf
> [Service]
> RuntimeDirectory=3Dresolvconf
> ReadWritePaths=3D/etc/resolv.conf
> =

> I remeber adding the override part few months ago due to another bug [1].=
 For some reason, forcing a disconnect/connect with iwctl doesn't hit the s=
ame problem.

But we're not even getting this far to even invoke resolvconf...

Any chance you can run a git bisect or otherwise narrow down what earlier =

version of iwd was working properly at boot?

Regards,
-Denis
--===============4924621610472018623==--

