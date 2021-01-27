Content-Type: multipart/mixed; boundary="===============7840837015748621471=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: Running iwd on Linux 4.9: iwd shows adapter but no device
Date: Wed, 27 Jan 2021 14:47:06 +0000
Message-ID: <fedeb71f-36c5-0190-5a5c-766fada7ec58@bang-olufsen.dk>
In-Reply-To: <8e4e7f9b-df39-44ae-a22f-f4eefcda3bd9@www.fastmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7840837015748621471==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

By default iwd wants to create and destroy interfaces on the phy, but =

our driver is probably brcmfmac, which doesn't allow this with its =

"primary" interface wlan0.

Have you tried running iwd with UseDefaultInterface=3Dtrue in =

/etc/iwd/main.conf, or adding --interfaces wlan0 to the iwd command?

Kind regards,
Alvin

On 1/27/21 3:34 PM, Manuel Wagesreither wrote:
> Hello all,
> =

> we're working on NVidia Jetson TX2-based product. [1] It run's a Yocto-ba=
sed distribution with meta-tegra as BSP layer. [2] meta-tegra is based on t=
he official nvidia-provided BSP called L4T (Linux for Tegra), which is avai=
lable for Ubuntu only. It uses Linux kernel 4.9.
> =

> For improved roaming, we would like to replace wpa_supplicant with iwd.
> =

> We know full iwd support is only given at Linux kernel 4.20+, but we hope=
d we can get it working with a reduced feature set on our existing 4.9. Tha=
t is, we don't need infrastructure or enterprise mode, WPA-PSK is enough fo=
r now.
> =

> iwd 1.9 can find an adapter, but it doesn't find (or create?) a device.
> =

> ```
> root(a)jetson-tx2:~# iwctl device list
>                                      Devices
> -------------------------------------------------------------------------=
-------
>    Name                Address             Powered   Adapter   Mode
> -------------------------------------------------------------------------=
-------
> =

> root(a)jetson-tx2:~# iwctl adapter list
>                                      Adapters
> -------------------------------------------------------------------------=
-------
>    Name               Powered   Vendor              Model
> -------------------------------------------------------------------------=
-------
>    phy0               on        Broadcom Corp.BCM4354 WLAN card
> ```
> =

> When I have the systemd unit invoke `iwd` with the `-d` option, the follo=
wing gets printed on my kernel log:
> ```
> [76240.009468] couldn't register the net device [wlan0], err -17
> ```
> =

> The systemd journal contains the following:
> ```
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_wiphy=
_dump_callback() New wiphy phy0 added (0)
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: Wiphy: 0, Name: phy0
> Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Permanent Address: 00:00:0=
0:00:00:00
> Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Bands: 2.4 GHz 5 GHz
> Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Ciphers: CCMP TKIP BIP
> Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Supported iftypes: ad-hoc =
station ap p2p-client p2p-go p2p-device
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: rfkill id 2 can't be matched to a =
wiphy
> Jan 27 14:19:57 jetson-tx2 systemd[1]: Started Wireless service.
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_inter=
face_dump_callback()
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_get_i=
nterface_cb()
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/wiphy.c:wiphy_update_re=
g_domain() New reg domain country code for (global) is 00
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_del_i=
nterface_cb()
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_creat=
e_interfaces() creating wlan0
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_new_s=
tation_interface_cb()
> Jan 27 14:19:57 jetson-tx2 iwd[29796]: NEW_INTERFACE failed: No such devi=
ce
> ```
> =

> Are we totally out of luck with kernel 4.9? As said, WPA-PSK would curren=
tly be enough for us.
> =

> Thank you!
> Regards,
> Manuel
> =

> [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fd=
eveloper.nvidia.com%2FEMBEDDED%2Fjetson-tx2&amp;data=3D04%7C01%7Calsi%40ban=
g-olufsen.dk%7Cef85740e143b4a25e5de08d8c2d0ae19%7C210d08b883f7470abc9638119=
3ca14a1%7C0%7C0%7C637473549419874118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj=
AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D9EI=
myhpl1JFLEtE3fLuFbGtuhnQo%2FENR%2BHMBl2vYiLY%3D&amp;reserved=3D0
> [2] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2FOE4T%2Fmeta-tegra&amp;data=3D04%7C01%7Calsi%40bang-olufsen.dk%7=
Cef85740e143b4a25e5de08d8c2d0ae19%7C210d08b883f7470abc96381193ca14a1%7C0%7C=
0%7C637473549419874118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi=
V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DmKpwuF4dfnNzttoj%=
2BNCNbGQfYF3hYpHJSFrN5w55zrs%3D&amp;reserved=3D0
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>=20
--===============7840837015748621471==--

