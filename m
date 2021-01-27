Content-Type: multipart/mixed; boundary="===============2616101825958411453=="
MIME-Version: 1.0
From: Manuel Wagesreither <ManWag@FastMail.FM>
Subject: Re: Running iwd on Linux 4.9: iwd shows adapter but no device
Date: Wed, 27 Jan 2021 18:00:57 +0100
Message-ID: <a547fe96-b206-49d2-a313-0760de42a68e@www.fastmail.com>
In-Reply-To: <fedeb71f-36c5-0190-5a5c-766fada7ec58@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2616101825958411453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

what shall I say, your hint worked like a charm!

I can now connect to my access point just fine. Thank you a lot!

If someone happens to find this through some search engine, here's some mor=
e info I picked up, partly on irc://freenode/#iwd:

* When iwd is invoked with '--interfaces wlan0', then UseDefaultInterface i=
s set automatically
* The driver my system is using ("bcmsdh_sdmmc") has the same issue as the =
"brcmfmac" mainline driver, which, because of its issues, got set onto a bl=
acklist. Then these --interfaces/UseDefaultInterface settings should not be=
 necessary. But because my "bcmsdh_sdmmc" driver seems to be an out-of-tree=
 one and goes by a different, the blacklist didn't apply.

Again, thank you a lot, Alvin!

Have a nice day everyone.
Manuel


Am Mi, 27. Jan 2021, um 15:47, schrieb Alvin =C5=A0ipraga:
> Hi Manuel,
> =

> By default iwd wants to create and destroy interfaces on the phy, but =

> our driver is probably brcmfmac, which doesn't allow this with its =

> "primary" interface wlan0.
> =

> Have you tried running iwd with UseDefaultInterface=3Dtrue in =

> /etc/iwd/main.conf, or adding --interfaces wlan0 to the iwd command?
> =

> Kind regards,
> Alvin
> =

> On 1/27/21 3:34 PM, Manuel Wagesreither wrote:
> > Hello all,
> > =

> > we're working on NVidia Jetson TX2-based product. [1] It run's a Yocto-=
based distribution with meta-tegra as BSP layer. [2] meta-tegra is based on=
 the official nvidia-provided BSP called L4T (Linux for Tegra), which is av=
ailable for Ubuntu only. It uses Linux kernel 4.9.
> > =

> > For improved roaming, we would like to replace wpa_supplicant with iwd.
> > =

> > We know full iwd support is only given at Linux kernel 4.20+, but we ho=
ped we can get it working with a reduced feature set on our existing 4.9. T=
hat is, we don't need infrastructure or enterprise mode, WPA-PSK is enough =
for now.
> > =

> > iwd 1.9 can find an adapter, but it doesn't find (or create?) a device.
> > =

> > ```
> > root(a)jetson-tx2:~# iwctl device list
> >                                      Devices
> > -----------------------------------------------------------------------=
---------
> >    Name                Address             Powered   Adapter   Mode
> > -----------------------------------------------------------------------=
---------
> > =

> > root(a)jetson-tx2:~# iwctl adapter list
> >                                      Adapters
> > -----------------------------------------------------------------------=
---------
> >    Name               Powered   Vendor              Model
> > -----------------------------------------------------------------------=
---------
> >    phy0               on        Broadcom Corp.BCM4354 WLAN card
> > ```
> > =

> > When I have the systemd unit invoke `iwd` with the `-d` option, the fol=
lowing gets printed on my kernel log:
> > ```
> > [76240.009468] couldn't register the net device [wlan0], err -17
> > ```
> > =

> > The systemd journal contains the following:
> > ```
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_wip=
hy_dump_callback() New wiphy phy0 added (0)
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: Wiphy: 0, Name: phy0
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Permanent Address: 00:00=
:00:00:00:00
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Bands: 2.4 GHz 5 GHz
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Ciphers: CCMP TKIP BIP
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]:         Supported iftypes: ad-ho=
c station ap p2p-client p2p-go p2p-device
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: rfkill id 2 can't be matched to =
a wiphy
> > Jan 27 14:19:57 jetson-tx2 systemd[1]: Started Wireless service.
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_int=
erface_dump_callback()
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_get=
_interface_cb()
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/wiphy.c:wiphy_update_=
reg_domain() New reg domain country code for (global) is 00
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_del=
_interface_cb()
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_cre=
ate_interfaces() creating wlan0
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: ../git/src/manager.c:manager_new=
_station_interface_cb()
> > Jan 27 14:19:57 jetson-tx2 iwd[29796]: NEW_INTERFACE failed: No such de=
vice
> > ```
> > =

> > Are we totally out of luck with kernel 4.9? As said, WPA-PSK would curr=
ently be enough for us.
> > =

> > Thank you!
> > Regards,
> > Manuel
> > =

> > [1] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fdeveloper.nvidia.com%2FEMBEDDED%2Fjetson-tx2&amp;data=3D04%7C01%7Calsi%40b=
ang-olufsen.dk%7Cef85740e143b4a25e5de08d8c2d0ae19%7C210d08b883f7470abc96381=
193ca14a1%7C0%7C0%7C637473549419874118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w=
LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D9=
EImyhpl1JFLEtE3fLuFbGtuhnQo%2FENR%2BHMBl2vYiLY%3D&amp;reserved=3D0
> > [2] https://eur02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgithub.com%2FOE4T%2Fmeta-tegra&amp;data=3D04%7C01%7Calsi%40bang-olufsen.dk=
%7Cef85740e143b4a25e5de08d8c2d0ae19%7C210d08b883f7470abc96381193ca14a1%7C0%=
7C0%7C637473549419874118%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIj=
oiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DmKpwuF4dfnNztto=
j%2BNCNbGQfYF3hYpHJSFrN5w55zrs%3D&amp;reserved=3D0
> > _______________________________________________
> > iwd mailing list -- iwd(a)lists.01.org
> > To unsubscribe send an email to iwd-leave(a)lists.01.org
> >
--===============2616101825958411453==--

