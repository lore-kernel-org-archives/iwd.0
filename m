Content-Type: multipart/mixed; boundary="===============8149992903002971559=="
MIME-Version: 1.0
From: 58e33db1-f428-4823-8cc3-d962d0fb8aa8 at slmail.me
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 18:23:43 +0000
Message-ID: <163250782336.7.397747114831416417.14147430@slmail.me>
In-Reply-To: 163250363750.7.16957800817581392078.14143021@simplelogin.co

--===============8149992903002971559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi Jason,
> =

> > Here you have. For some reason is not getting an IP:
> > =

> =

> <snip>
> =

> > iwd[11413]: src/station.c:station_connect_cb() 6, result: 0
> > iwd[11413]: src/station.c:station_connect_ok()
> =

> Yep, so we connect OK, start DHCP
> =

> > iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> > iwd[11413]: [DHCPv4] l_dhcp_client_start:1174 Entering state: DHCP_STAT=
E_SELECTING
> > iwd[11413]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 co=
nfiguration disabled
> > iwd[11413]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> > iwd[11413]: src/netdev.c:netdev_link_notify() event 16 on ifindex 6
> > iwd[11413]: src/netdev.c:netdev_mlme_notify() MLME notification Frame T=
X Status(60)
> > iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> > iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> > iwd[11413]: src/station.c:station_early_neighbor_report_cb() ifindex: 6=
, error: -110(Connection timed out)
> > iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> > iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> > iwd[11413]: [DHCPv4] dhcp_client_timeout_resend:526
> > iwd[11413]: [DHCPv4] dhcp_client_send_discover:346
> > =

> =

> But nothing gets received from the DHCP server.  I'm a bit stumped since =
we =

> haven't touched anything related to dhcp between 1.17 and 1.18.  We start=
ed =

> sending the DHCP rapid commit option in iwd 1.17, so maybe that is why yo=
ur =

> server is ignoring us?
> =

> Does starting dhcpcd or something while iwd is in this 'connecting' state=
 obtain =

> an IP?
> =

> > I think is relevant to the bug that I'm using this unit to start iwd.se=
rvice:
> > =

> > # /usr/lib/systemd/system/iwd.service
> > [Unit]
> > Description=3DWireless service
> > After=3Dnetwork-pre.target
> > Before=3Dnetwork.target
> > Wants=3Dnetwork.target
> > =

> > [Service]
> > Type=3Ddbus
> > BusName=3Dnet.connman.iwd
> > ExecStart=3D/usr/lib/iwd/iwd
> > NotifyAccess=3Dmain
> > LimitNPROC=3D1
> > Restart=3Don-failure
> > CapabilityBoundingSet=3DCAP_NET_ADMIN CAP_NET_RAW CAP_NET_BIND_SERVICE
> > PrivateTmp=3Dtrue
> > NoNewPrivileges=3Dtrue
> > DevicePolicy=3Dclosed
> > DeviceAllow=3D/dev/rfkill rw
> > ProtectHome=3Dyes
> > ProtectSystem=3Dstrict
> > ProtectControlGroups=3Dyes
> > ProtectKernelModules=3Dyes
> > ConfigurationDirectory=3Diwd
> > StateDirectory=3Diwd
> > StateDirectoryMode=3D0700
> > =

> > [Install]
> > WantedBy=3Dmulti-user.target
> > =

> > # /etc/systemd/system/iwd.service.d/override.conf
> > [Service]
> > RuntimeDirectory=3Dresolvconf
> > ReadWritePaths=3D/etc/resolv.conf
> > =

> > I remeber adding the override part few months ago due to another bug [1=
]. For some reason, forcing a disconnect/connect with iwctl doesn't hit the=
 same problem.
> =

> But we're not even getting this far to even invoke resolvconf...
> =

> Any chance you can run a git bisect or otherwise narrow down what earlier =

> version of iwd was working properly at boot?
> =

> Regards,
> -Denis

Well, I've discovered how to trigger the problem in my scenario. It's all r=
elated with setting AddressRandomization to 'network'. The other two possib=
le values 'disabled' (default) and 'once' both work fine.

Previous version 1.17 didn't show this behaviour. Anyway, I'm happy with 'o=
nce' since I no longer have specific settings by MAC in the router.

For the record, this configuration was working until version 1.17 included:

[General]
EnableNetworkConfiguration=3Dtrue
AddressRandomization=3Dnetwork

[Network]
NameResolvingService=3Dresolvconf


--===============8149992903002971559==--

