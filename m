Content-Type: multipart/mixed; boundary="===============7737236961105959764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Tue, 30 Nov 2021 17:53:40 -0600
Message-ID: <070b7088-2ab6-67bf-63a1-7a1be95a58f7@gmail.com>
In-Reply-To: CAA=hcWRD26NoeS5bgZ3kdBFz2c7n=kpan2etQkXhRKv1UavYJw@mail.gmail.com

--===============7737236961105959764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jupiter,

> My bad, here is DHCP debugging, looks like failed to get DHCP server resp=
onse:
> =

> ../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
> '34:08:04:12:b1:a2' freq: 2437, rank: 2722, strength: -6500
> ../iwd-1.19/src/station.c:station_enter_state() Old State:
> autoconnect_full, new state: connecting (auto)
> ../iwd-1.19/src/station.c:station_netdev_event() Associating
> ../iwd-1.19/src/station.c:station_handshake_event() Setting keys
> ../iwd-1.19/src/station.c:station_connect_cb() 14, result: 0
> ../iwd-1.19/src/station.c:station_connect_ok()
> netconfig: Failed to start DHCPv4 client for interface 14
> WARNING: ../iwd-1.19/src/station.c:station_connect_ok() condition
> !netconfig_configure(station->netconfig,

Ugh, not sure what happens here.  First, can you update to iwd 1.20?  I don=
't =

think anything was touched around this for several releases, but I'd hate t=
o try =

and debug an old version.  Also, share the full log of iwd when this happen=
s...

Can you strace iwd and see what syscall might be failing around this time? =
 You =

may also need to step through l_dhcp_client_start to see why it is failing.=
  It =

really shouldn't under normal circumstances, hence we have no debugs in thi=
s area.

> station_netconfig_event_handler, station) failed
> [DHCPv4] dhcp_client_timeout_resend:526
> [DHCPv4] dhcp_client_send_discover:346
> [DHCPv4] dhcp_client_timeout_resend:526
> [DHCPv4] dhcp_client_send_discover:346
> [DHCPv4] dhcp_client_timeout_resend:526
> [DHCPv4] dhcp_client_send_discover:346
> [DHCPv4] dhcp_client_timeout_resend:526
> [DHCPv4] dhcp_client_send_discover:346

And this is even more strange.  If l_dhcp_client_start() fails, then the re=
send =

timer shouldn't even be set and you shouldn't even see this sequence.

Can you try compiling with optimizations off (./configure --enable-debug =

--disable-optimization) and see if the behavior changes?

> =

> Is netconfig from iwd?

yes

> =

> I think the DHCP server is running from the home WiFi modem, right? My
> laptop is also connected to the same WiFi modem SSID JupiterIoT which
> should rule out home WiFi network DHCP server issues.

Given the fact that we fail to start dhcp client, I'm not sure we even send=
 any =

discover packets.  So your server might be just fine.

Regards,
-Denis
--===============7737236961105959764==--

