Content-Type: multipart/mixed; boundary="===============0596169236751924167=="
MIME-Version: 1.0
From: Manuel Wagesreither <ManWag@FastMail.FM>
Subject: Running iwd on Linux 4.9: iwd shows adapter but no device
Date: Wed, 27 Jan 2021 15:34:11 +0100
Message-ID: <8e4e7f9b-df39-44ae-a22f-f4eefcda3bd9@www.fastmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0596169236751924167==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

we're working on NVidia Jetson TX2-based product. [1] It run's a Yocto-base=
d distribution with meta-tegra as BSP layer. [2] meta-tegra is based on the=
 official nvidia-provided BSP called L4T (Linux for Tegra), which is availa=
ble for Ubuntu only. It uses Linux kernel 4.9.

For improved roaming, we would like to replace wpa_supplicant with iwd.

We know full iwd support is only given at Linux kernel 4.20+, but we hoped =
we can get it working with a reduced feature set on our existing 4.9. That =
is, we don't need infrastructure or enterprise mode, WPA-PSK is enough for =
now.

iwd 1.9 can find an adapter, but it doesn't find (or create?) a device.

```
root(a)jetson-tx2:~# iwctl device list
                                    Devices                                =
    =

---------------------------------------------------------------------------=
-----
  Name                Address             Powered   Adapter   Mode      =

---------------------------------------------------------------------------=
-----

root(a)jetson-tx2:~# iwctl adapter list
                                    Adapters                               =
    =

---------------------------------------------------------------------------=
-----
  Name               Powered   Vendor              Model               =

---------------------------------------------------------------------------=
-----
  phy0               on        Broadcom Corp.BCM4354 WLAN card
```

When I have the systemd unit invoke `iwd` with the `-d` option, the followi=
ng gets printed on my kernel log:
```
[76240.009468] couldn't register the net device [wlan0], err -17
```

The systemd journal contains the following:
```
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_wiphy_d=
ump_callback() New wiphy phy0 added (0)
Jan 27 14:19:57 jetson-tx2 iwd[29796]: Wiphy: 0, Name: phy0
Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Permanent Address: 00:00:00:=
00:00:00
Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Bands: 2.4 GHz 5 GHz
Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Ciphers: CCMP TKIP BIP
Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Supported iftypes: ad-hoc st=
ation ap p2p-client p2p-go p2p-device
Jan 27 14:19:57 jetson-tx2 iwd[29796]: rfkill id 2 can't be matched to a wi=
phy
Jan 27 14:19:57 jetson-tx2 systemd[1]: Started Wireless service.
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_interfa=
ce_dump_callback()
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_get_int=
erface_cb()
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/wiphy.c:wiphy_update_reg_=
domain() New reg domain country code for (global) is 00
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_del_int=
erface_cb()
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_create_=
interfaces() creating wlan0
Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_new_sta=
tion_interface_cb()
Jan 27 14:19:57 jetson-tx2 iwd[29796]: NEW_INTERFACE failed: No such device
```

Are we totally out of luck with kernel 4.9? As said, WPA-PSK would currentl=
y be enough for us.

Thank you!
Regards,
Manuel

[1] https://developer.nvidia.com/EMBEDDED/jetson-tx2
[2] https://github.com/OE4T/meta-tegra
--===============0596169236751924167==--

