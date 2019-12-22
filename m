Content-Type: multipart/mixed; boundary="===============1992991403624464597=="
MIME-Version: 1.0
From: Wiktor Kwapisiewicz <wiktor@metacode.biz>
Subject: Restart of iwd.service necessary after boot
Date: Sun, 22 Dec 2019 22:09:59 +0100
Message-ID: <5922fd21-d5d1-12ff-faec-ba5627b809aa@metacode.biz>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1992991403624464597==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

I'm using iwd on ArchLinux as a systemd service with conjunction with =

systemd-networkd and generally it works very well (iwctl live updates =

are impressive) with a minor annoyance that the service requires restart =

after each boot to function.

This issue have been reported by others on ArchLinux site:
https://bugs.archlinux.org/task/63912

In the service logs the only significant line seems to be "NEW_INTERFACE =

failed: Device or resource busy":

$ journalctl -u iwd
   Starting Wireless service...
   Wireless daemon version 1.4
   Started Wireless service.
   netconfig: Network configuration is disabled.
   Wiphy: 0, Name: phy0
          Permanent Address: 30:52:cb:84:72:ff
          Bands: 2.4 GHz 5 GHz
          Ciphers: CCMP TKIP BIP
          Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
   NEW_INTERFACE failed: Device or resource busy

networkctl reports "configuring" but nothing ever happens:

$ networkctl
IDX LINK        TYPE     OPERATIONAL SETUP
   1 lo          loopback carrier     unmanaged
   2 wlan0       wlan     no-carrier  configuring
   3 enp10s0u2u4 ether    no-carrier  configuring
   4 enp9s0u1u2  ether    no-carrier  configuring

After service restart it does complain about "unknown error" but =

everything works as normal:

   Wireless daemon version 1.4
   Started Wireless service.
   netconfig: Network configuration is disabled.
   Wiphy: 0, Name: phy0
         Permanent Address: 30:52:cb:84:72:ff
         Bands: 2.4 GHz 5 GHz
         Ciphers: CCMP TKIP BIP
         Supported iftypes: ad-hoc station ap p2p-client p2p-go p2p-device
   DEL_INTERFACE failed: Unknown error 524
   hardware_rekey not supported

And it is routable in networkctl:

$ networkctl
IDX LINK        TYPE     OPERATIONAL SETUP
   1 lo          loopback carrier     unmanaged
   2 wlan0       wlan     routable    configured
   3 enp10s0u2u4 ether    no-carrier  configuring
   4 enp9s0u1u2  ether    no-carrier  configuring

Interestingly one of ArchLinux users [0] reported that adding sleep in =

"ExecStartPre" of the systemd service makes the problem disappear and =

yes, this workaround also works on my end.

I did not have this problem when using old wpa_supplicant. I'm using XPS =

13 (9350, Broadcom BCM4350). I had the problem since I installed iwd and =

it's still here in version 1.4

Is there a way to debug this issue further?

Thank you for your help!

Kind regards,
Wiktor

[0]: https://bugs.archlinux.org/task/63912#comment183316

-- =

https://metacode.biz/@wiktor
--===============1992991403624464597==--

