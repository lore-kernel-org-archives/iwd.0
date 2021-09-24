Content-Type: multipart/mixed; boundary="===============1954239194137216695=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd 1.18 doesn't connect to network on boot
Date: Fri, 24 Sep 2021 08:55:11 -0500
Message-ID: <98658ac1-d812-130c-4a09-b08517917160@gmail.com>
In-Reply-To: 163248189187.7.458454357387386987.14116837@slmail.me

--===============1954239194137216695==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jason,

<snip>

> iwd[4842]: src/station.c:station_connect_cb() 8, result: 0
> iwd[4842]: src/station.c:station_connect_ok()

So the interesting thing is that we connect successfully, so the issue is =

actually in netconfig somewhere.  Can you tell me which version you had bef=
ore =

that worked?  Was it 1.17 or earlier?

> iwd[4842]: src/netconfig.c:netconfig_ipv6_select_and_install() IPV6 confi=
guration disabled
> iwd[4842]: src/wiphy.c:wiphy_radio_work_done() Work item 2 done
> iwd[4842]: src/netdev.c:netdev_link_notify() event 16 on ifindex 8
> iwd[4842]: src/netdev.c:netdev_mlme_notify() MLME notification Frame TX S=
tatus(60)
> iwd[4842]: src/station.c:station_early_neighbor_report_cb() ifindex: 8, e=
rror: -110(Connection timed out)
> =

> This is the point where connection is stuck and iwctl reports 'connecting=
' indefinitely despite being authenticated already.

Ok, can you get us a log with IWD_DHCP_DEBUG set as well?  See 'man 7 iwd.d=
ebug'

Regards,
-Denis
--===============1954239194137216695==--

