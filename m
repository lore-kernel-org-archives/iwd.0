Content-Type: multipart/mixed; boundary="===============1573327652118502894=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Fri, 14 Jan 2022 12:51:11 -0800
Message-ID: <63f4a6a626d48bce3cc8a7a5076c99c43d729a40.camel@gmail.com>
In-Reply-To: 20220114200809.2807.69459@ml01.vlan13.01.org

--===============1573327652118502894==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Since you have EnableNetworkConfiguration=3Dtrue IWD is performing DHCP
and waiting for that to succeed. I see further you tried again and got
an IP so for some reason your DHCP server was not acting properly in
the 'stuck in connecting case'.

You could try setting IWD_DHCP_DEBUG=3D1 as an environment variable and
try again. That may give more insight into what DHCP is waiting for.

Thanks,
James =


On Fri, 2022-01-14 at 20:08 +0000,
54d22547-afc0-4701-b1fc-5a2a2e411646(a)simplelogin.co wrote:
> Hi James,
> =

> I've gone through debugging and this is what I have:
> https://termbin.com/y9vq
> =

> iwd.service
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

> /etc/iwd/main.conf
> =

> [General]
> EnableNetworkConfiguration=3Dtrue
> AddressRandomization=3Donce
> =

> [Network]
> NameResolvingService=3Dresolvconf
> =

> I've also tried to collect iwmon logs but they are huge, like almost
> 2 MB. Should I filter some of the info as the wiki shows (--nortnl --
> nowiphy --noscan).
> =

> Thanks!
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============1573327652118502894==--

