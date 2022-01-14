Content-Type: multipart/mixed; boundary="===============1839054446239780793=="
MIME-Version: 1.0
From: 54d22547-afc0-4701-b1fc-5a2a2e411646 at simplelogin.co
To: iwd at lists.01.org
Subject: Re: iwd 1.21 stuck on connecting state
Date: Fri, 14 Jan 2022 20:08:09 +0000
Message-ID: <20220114200809.2807.69459@ml01.vlan13.01.org>
In-Reply-To: 2aaa505ef89f9ec1635c30e3a65674fe489f6580.camel@gmail.com

--===============1839054446239780793==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

I've gone through debugging and this is what I have: https://termbin.com/y9=
vq

iwd.service

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

/etc/iwd/main.conf

[General]
EnableNetworkConfiguration=3Dtrue
AddressRandomization=3Donce

[Network]
NameResolvingService=3Dresolvconf

I've also tried to collect iwmon logs but they are huge, like almost 2 MB. =
Should I filter some of the info as the wiki shows (--nortnl --nowiphy --no=
scan).

Thanks!
--===============1839054446239780793==--

