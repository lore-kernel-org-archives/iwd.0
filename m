Content-Type: multipart/mixed; boundary="===============0418908169049536979=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Wed, 01 Dec 2021 10:25:51 +1100
Message-ID: <CAA=hcWRD26NoeS5bgZ3kdBFz2c7n=kpan2etQkXhRKv1UavYJw@mail.gmail.com>
In-Reply-To: 31be7914-5c78-f1c9-1225-a271204ba153@gmail.com

--===============0418908169049536979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> For DHCP debugging, refer to 'man iwd.debug'.  You will need to set the
> appropriate environment variable (IWD_DHCP_DEBUG or so).  The iwd wiki [1]
> has
> examples.

My bad, here is DHCP debugging, looks like failed to get DHCP server respon=
se:

../iwd-1.19/src/station.c:station_autoconnect_next() autoconnect:
'34:08:04:12:b1:a2' freq: 2437, rank: 2722, strength: -6500
../iwd-1.19/src/station.c:station_enter_state() Old State:
autoconnect_full, new state: connecting (auto)
../iwd-1.19/src/station.c:station_netdev_event() Associating
../iwd-1.19/src/station.c:station_handshake_event() Setting keys
../iwd-1.19/src/station.c:station_connect_cb() 14, result: 0
../iwd-1.19/src/station.c:station_connect_ok()
netconfig: Failed to start DHCPv4 client for interface 14
WARNING: ../iwd-1.19/src/station.c:station_connect_ok() condition
!netconfig_configure(station->netconfig,
station_netconfig_event_handler, station) failed
[DHCPv4] dhcp_client_timeout_resend:526
[DHCPv4] dhcp_client_send_discover:346
[DHCPv4] dhcp_client_timeout_resend:526
[DHCPv4] dhcp_client_send_discover:346
[DHCPv4] dhcp_client_timeout_resend:526
[DHCPv4] dhcp_client_send_discover:346
[DHCPv4] dhcp_client_timeout_resend:526
[DHCPv4] dhcp_client_send_discover:346

Is netconfig from iwd?

I think the DHCP server is running from the home WiFi modem, right? My
laptop is also connected to the same WiFi modem SSID JupiterIoT which
should rule out home WiFi network DHCP server issues.

Thank you very much.

Kind regards,

- jupiter
--===============0418908169049536979==--

