Content-Type: multipart/mixed; boundary="===============8409641299708899446=="
MIME-Version: 1.0
From: 1148d778-20a8-4ab0-96b7-24572ddab965 at simplelogin.co
To: iwd at lists.01.org
Subject: iwd fails to create device
Date: Sat, 28 May 2022 19:24:23 +0000
Message-ID: <20220528192423.2134.31838@ml01.vlan13.01.org>

--===============8409641299708899446==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

A few times I've already seen a strange behaviour right after rebooting. Al=
l of the sudden the wifi card is no longer available. To me it looks like i=
wd fails to detect and rename the device. Hopefully it happens very seldom.

$ journalctl -b -1 | grep -i wifi
may 27 12:02:52 kernel: Intel(R) Wireless WiFi driver for Linux
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: enabling device (0000 -> 0002)
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: Direct firmware load for iwlw=
ifi-cc-a0-69.ucode failed with error -2
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: api flags index 2 larger than=
 supported by driver
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: TLV_FW_FSEQ_VERSION: FSEQ Ver=
sion: 89.3.35.37
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: loaded firmware version 68.01=
d30b0c.0 cc-a0-68.ucode op_mode iwlmvm
may 27 12:02:52 kernel: iwlwifi 0000:03:00.0: Detected Intel(R) Wi-Fi 6 AX2=
00 160MHz, REV=3D0x340
may 27 12:02:53 kernel: iwlwifi 0000:03:00.0: Detected RF HR B3, rfid=3D0x1=
0a100
may 27 12:02:53 kernel: iwlwifi 0000:03:00.0: base HW address: xx:xx:xx:xx:=
xx:xx


$ journalctl -b -1 | grep -i iwd
may 27 12:02:53 iwd[863]: Wireless daemon version 1.27
may 27 12:02:53 iwd[863]: Loaded configuration from /etc/iwd/main.conf
may 27 12:02:53 audit[1]: SERVICE_START pid=3D1 uid=3D0 auid=3D4294967295 s=
es=3D4294967295 msg=3D'unit=3Diwd comm=3D"systemd" exe=3D"/usr/lib/systemd/=
systemd" hostname=3D? addr=3D? terminal=3D? res=3Dsuccess'
may 27 12:02:53 iwd[863]: Wiphy: 0, Name: phy0
may 27 12:02:53 iwd[863]:         Permanent Address: xx:xx:xx:xx:xx:xx
may 27 12:02:53 iwd[863]:         2.4Ghz Band:
may 27 12:02:53 iwd[863]:                 Bitrates (non-HT):
may 27 12:02:53 iwd[863]:                          1.0 Mbps
may 27 12:02:53 iwd[863]:                          2.0 Mbps
may 27 12:02:53 iwd[863]:                          5.5 Mbps
may 27 12:02:53 iwd[863]:                         11.0 Mbps
may 27 12:02:53 iwd[863]:                          6.0 Mbps
may 27 12:02:53 iwd[863]:                          9.0 Mbps
may 27 12:02:53 iwd[863]:                         12.0 Mbps
may 27 12:02:53 iwd[863]:                         18.0 Mbps
may 27 12:02:53 iwd[863]:                         24.0 Mbps
may 27 12:02:53 iwd[863]:                         36.0 Mbps
may 27 12:02:53 iwd[863]:                         48.0 Mbps
may 27 12:02:53 iwd[863]:                         54.0 Mbps
may 27 12:02:53 iwd[863]:                 HT Capabilities:
may 27 12:02:53 iwd[863]:                         HT40
may 27 12:02:53 iwd[863]:                         Short GI for 20Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 40Mhz
may 27 12:02:53 iwd[863]:                 HT RX MCS indexes:
may 27 12:02:53 iwd[863]:                         0-15
may 27 12:02:53 iwd[863]:         5Ghz Band:
may 27 12:02:53 iwd[863]:                 Bitrates (non-HT):
may 27 12:02:53 iwd[863]:                          6.0 Mbps
may 27 12:02:53 iwd[863]:                          9.0 Mbps
may 27 12:02:53 iwd[863]:                         12.0 Mbps
may 27 12:02:53 iwd[863]:                         18.0 Mbps
may 27 12:02:53 iwd[863]:                         24.0 Mbps
may 27 12:02:53 iwd[863]:                         36.0 Mbps
may 27 12:02:53 iwd[863]:                         48.0 Mbps
may 27 12:02:53 iwd[863]:                         54.0 Mbps
may 27 12:02:53 iwd[863]:                 HT Capabilities:
may 27 12:02:53 iwd[863]:                         HT40
may 27 12:02:53 iwd[863]:                         Short GI for 20Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 40Mhz
may 27 12:02:53 iwd[863]:                 HT RX MCS indexes:
may 27 12:02:53 iwd[863]:                         0-15
may 27 12:02:53 iwd[863]:                 VHT Capabilities:
may 27 12:02:53 iwd[863]:                         160 Mhz operation
may 27 12:02:53 iwd[863]:                         Short GI for 80Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 160 and 80 +=
 80 Mhz
may 27 12:02:53 iwd[863]:                         Max RX MCS: 0-9 for NSS: 2
may 27 12:02:53 iwd[863]:                         Max TX MCS: 0-9 for NSS: 2
may 27 12:02:53 iwd[863]:         Ciphers: CCMP TKIP BIP
may 27 12:02:53 iwd[863]:         Supported iftypes: ad-hoc station ap p2p-=
client p2p-go p2p-device
may 27 12:02:53 iwd[863]: Unable to add the net.connman.iwd.Adapter interfa=
ce to /net/connman/iwd/0
may 27 12:02:53 iwd[863]: Unable to add the org.freedesktop.DBus.Properties=
 interface to /net/connman/iwd/0
may 27 12:02:53 iwd[863]: Wiphy: 0, Name: phy0
may 27 12:02:53 iwd[863]:         Permanent Address: xx:xx:xx:xx:xx:xx
may 27 12:02:53 iwd[863]:         2.4Ghz Band:
may 27 12:02:53 iwd[863]:                 Bitrates (non-HT):
may 27 12:02:53 iwd[863]:                          1.0 Mbps
may 27 12:02:53 iwd[863]:                          2.0 Mbps
may 27 12:02:53 iwd[863]:                          5.5 Mbps
may 27 12:02:53 iwd[863]:                         11.0 Mbps
may 27 12:02:53 iwd[863]:                          6.0 Mbps
may 27 12:02:53 iwd[863]:                          9.0 Mbps
may 27 12:02:53 iwd[863]:                         12.0 Mbps
may 27 12:02:53 iwd[863]:                         18.0 Mbps
may 27 12:02:53 iwd[863]:                         24.0 Mbps
may 27 12:02:53 iwd[863]:                         36.0 Mbps
may 27 12:02:53 iwd[863]:                         48.0 Mbps
may 27 12:02:53 iwd[863]:                         54.0 Mbps
may 27 12:02:53 iwd[863]:                 HT Capabilities:
may 27 12:02:53 iwd[863]:                         HT40
may 27 12:02:53 iwd[863]:                         Short GI for 20Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 40Mhz
may 27 12:02:53 iwd[863]:                 HT RX MCS indexes:
may 27 12:02:53 iwd[863]:                         0-15
may 27 12:02:53 iwd[863]:         5Ghz Band:
may 27 12:02:53 iwd[863]:                 Bitrates (non-HT):
may 27 12:02:53 iwd[863]:                          6.0 Mbps
may 27 12:02:53 iwd[863]:                          9.0 Mbps
may 27 12:02:53 iwd[863]:                         12.0 Mbps
may 27 12:02:53 iwd[863]:                         18.0 Mbps
may 27 12:02:53 iwd[863]:                         24.0 Mbps
may 27 12:02:53 iwd[863]:                         36.0 Mbps
may 27 12:02:53 iwd[863]:                         48.0 Mbps
may 27 12:02:53 iwd[863]:                         54.0 Mbps
may 27 12:02:53 iwd[863]:                 HT Capabilities:
may 27 12:02:53 iwd[863]:                         HT40
may 27 12:02:53 iwd[863]:                         Short GI for 20Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 40Mhz
may 27 12:02:53 iwd[863]:                 HT RX MCS indexes:
may 27 12:02:53 iwd[863]:                         0-15
may 27 12:02:53 iwd[863]:                 VHT Capabilities:
may 27 12:02:53 iwd[863]:                         160 Mhz operation
may 27 12:02:53 iwd[863]:                         Short GI for 80Mhz
may 27 12:02:53 iwd[863]:                         Short GI for 160 and 80 +=
 80 Mhz
may 27 12:02:53 iwd[863]:                         Max RX MCS: 0-9 for NSS: 2
may 27 12:02:53 iwd[863]:                         Max TX MCS: 0-9 for NSS: 2
may 27 12:02:53 iwd[863]:         Ciphers: CCMP TKIP BIP
may 27 12:02:53 iwd[863]:         Supported iftypes: ad-hoc station ap p2p-=
client p2p-go p2p-device
may 27 12:02:53 iwd[863]: DEL_INTERFACE failed: No such device
may 27 12:02:53 iwd[863]: Could not register frame watch type 00d0: -19
may 27 12:02:53 iwd[863]: RTM_GETLINK error -19: No such device
may 27 12:02:53 iwd[863]: Could not register frame watch type 00d0: -19
may 27 12:02:53 iwd[863]: Could not register frame watch type 00d0: -19
may 27 12:02:53 iwd[863]: Could not register frame watch type 00d0: -19
may 27 12:02:53 iwd[863]: Could not register frame watch type 00d0: -19
may 27 12:03:31 iwd[863]: D-Bus disconnected, quitting...
may 27 12:03:32 iwd[863]: Terminate
may 27 12:03:32 iwd[863]: Removing scan context for wdev 2
may 27 12:03:33 systemd[1]: iwd.service: Deactivated successfully.

Arch Linux wiki on iwd troubleshooting mentions two issues that look possib=
le causes to me:
- Low entropy pool
- Wireless device not renamed by udev

You can check it here: https://wiki.archlinux.org/title/Iwd#Troubleshooting

Any help to fix this issue would be appreciated.

Thanks!
--===============8409641299708899446==--

