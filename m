Content-Type: multipart/mixed; boundary="===============1349412578240625358=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd configure location and files
Date: Wed, 01 Dec 2021 09:51:21 +1100
Message-ID: <CAA=hcWT+56Ehxy3QH2bOcoiGDBLfQKwdEMCpz6W77Ch=X3CK9g@mail.gmail.com>
In-Reply-To: CAG17S_Pc-j0=CW1yrkbjWibooNYM4ycqKrXfJGAUVxE98QgMQg@mail.gmail.com

--===============1349412578240625358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Keith,

> My suggestion is along these lines. Shut down connman and run iwd
> stand alone. Use iwctl to see if it will connect to the SSID. If this
> works, delete the associated SSID files created in /var/lib/iwd. Then
> start connman and try to connect using connmanctl. I went through this
> a while back, so it does work as long as the kernel is configured for
> it and you are using recent iwd and connman. I am using connman 1.40
> and iwd 1.20 on Arch Linux Arm (RPi) and am pleased with the
> performance.

I am using connman 1.40 and iwd 1.19, connman was stopped:

# systemctl status connman -l
* connman.service - Connection service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/connman.service/lib/systemd/system/conn=
man.service8;;;
enabled; vendor preset: enabled)
     Active: inactive (dead) since Wed 2021-08-04 17:23:59 UTC; 2min 5s ago
    Process: 21507 ExecStart=3D/usr/sbin/connmand -n (code=3Dexited,
status=3D0/SUCCESS)
   Main PID: 21507 (code=3Dexited, status=3D0/SUCCESS)

Aug 04 17:23:59 solar systemd[1]: Stopping Connection service...
Aug 04 17:23:59 solar connmand[21507]: Remove interface wlan0 [ wifi ]
Aug 04 17:23:59 solar connmand[21507]: Remove interface wwan0 [ cellular ]
Aug 04 17:23:59 solar connmand[21507]: Removing configuration wifi
Aug 04 17:23:59 solar connmand[21507]: Removing configuration cellular
Aug 04 17:23:59 solar connmand[21507]: wlan0 {remove} index 13
Aug 04 17:23:59 solar connmand[21507]: wwan0 {remove} index 5
Aug 04 17:23:59 solar connmand[21507]: Exit
Aug 04 17:23:59 solar systemd[1]: connman.service: Deactivated successfully.
Aug 04 17:23:59 solar systemd[1]: Stopped Connection service.

# systemctl status iwd -l
* iwd.service - Wireless service
     Loaded: loaded
(8;;file://solar/lib/systemd/system/iwd.service/lib/systemd/system/iwd.serv=
ice8;;;
enabled; vendor preset: enabled)
     Active: active (running) since Wed 2021-08-04 17:09:46 UTC; 14min ago
   Main PID: 19620 (iwd)
     CGroup: /system.slice/iwd.service
             `-19620 /usr/libexec/iwd

Aug 04 17:09:46 solar iwd[19620]:                         32
Aug 04 17:09:46 solar iwd[19620]:         Ciphers: CCMP TKIP BIP
Aug 04 17:09:46 solar iwd[19620]:         Supported iftypes: station
ap p2p-client p2p-go
Aug 04 17:09:47 solar iwd[19620]: hardware_rekey not supported
Aug 04 17:12:03 solar iwd[19620]: Received Deauthentication event,
reason: 2, from_ap: true
Aug 04 17:12:05 solar iwd[19620]: netconfig: Failed to start DHCPv4
client for interface 13
Aug 04 17:12:05 solar iwd[19620]: WARNING:
../iwd-1.19/src/station.c:station_connect_ok() condition
!netconfig_configure(station->netconfig,
station_netconfig_event_handler, station) failed
Aug 04 17:22:03 solar iwd[19620]: Received Deauthentication event,
reason: 2, from_ap: true
Aug 04 17:22:05 solar iwd[19620]: netconfig: Failed to start DHCPv4
client for interface 13
Aug 04 17:22:05 solar iwd[19620]: WARNING:
../iwd-1.19/src/station.c:station_connect_ok() condition
!netconfig_configure(station->netconfig,
station_netconfig_event_handler, station) failed

The home network is connected, but iwd failed DHCP, what could be
missing for DHCP?

> IWD can manage DHCP, and this works nicely but it is not required (you
> could use conventional daemons for this, systemd, dhclient etc). If you
> want IWD to do DHCP you can enable this in /etc/iwd/main.conf:

Sorry James, I should mention I do have the /etc/iwd/main.conf I
copied from source:

# cat /etc/iwd/main.conf
[Scan]
DisableMacAddressRandomization=3Dtrue

[General]
EnableNetworkConfiguration=3Dtrue

Thank you very much.

Kind regards,

- jupiter
--===============1349412578240625358==--

