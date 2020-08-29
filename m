Content-Type: multipart/mixed; boundary="===============4740864115326607968=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Sat, 29 Aug 2020 14:11:56 -0500
Message-ID: <7c63237c-ebea-7df2-f792-c589266046e9@gmail.com>
In-Reply-To: <3765450.Iyh0gPlrZJ@mmm>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4740864115326607968==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 8/29/20 7:59 AM, Patrick H=C3=A4cker wrote:
> Hello,
> =

> I try to get iwd running on a Raspberry Pi using a Raspbian kernel (5.4.5=
9).
> The needed kernel options should be added (https://github.com/raspberrypi/
> linux/issues/3547), wpa_supplicant works, I compiled a kernel adding
> CONFIG_KEY_DH_OPERATIONS (which was the only remaining complaint by iwd),
> upgraded to iwd 1.8 but had no success.

CONFIG_KEY_DH_OPERATIONS is needed for WPS.  If you're not using that, then=
 this =

can be dropped, but probably a good idea to keep it.

> =

> Now I am running out of ideas what else to try. The (hopefully) relevant =
part
> of iwd running in debug mode for 2.4 GHz:
>> src/station.c:station_autoconnect_next() Considering autoconnecting to B=
SS
>>      '98:9b:cb:4b:b1:cc' with SSID: auenstein, freq: 2472, rank: 7090,
>>      strength: -5600
>> src/station.c:station_enter_state() Old State: autoconnect_quick, new
>>      state: connecting
>> src/station.c:station_netdev_event() Associating
>> src/netdev.c:netdev_unicast_notify() Unicast notification 59
>> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
>> src/netdev.c:netdev_connect_event()
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
>> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
>>      (global) is DE
>> 4-Way handshake failed for ifindex: 3, reason: 15
>> src/station.c:station_connect_cb() 3, result: 3
>> src/station.c:station_disassociated() 3
>> src/station.c:station_enter_state() Old State: connecting, new state:
>>      disconnected

This is a brcmfmac card right?  We have seen some weirdness with brcmfmac w=
here =

it simply refuses to perform the handshake (which is what is happening in y=
our =

case).  The handshake times out (reason: 15 =3D =

MMPDU_REASON_CODE_4WAY_HANDSHAKE_TIMEOUT).

The strange part is that it does work in other setups and it seems to be a =

combination of AP or some other weird factor that screws this up.  Have you =

tried different brcmfmac firmware versions?

> =

> And the same for 5.6 GHz with a different error:
>> src/station.c:station_autoconnect_next() Considering autoconnecting to B=
SS
>>      '98:9b:cb:4b:b1:cd' with SSID: auenstein5G, freq: 5600, rank: 4592,
>>      strength: -6500
>> src/station.c:station_enter_state() Old State:
>>      autoconnect_quick, new state: connecting
>> src/station.c:station_netdev_event() Associating
>> src/netdev.c:netdev_unicast_notify() Unicast notification 59
>> src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
>> src/netdev.c:netdev_connect_event()
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
>> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
>>      (global) is DE

Seems like the kernel is switching the regulatory domain here, right after =
we =

try to connect.  I wonder if you can use iw to set this prior to triggering=
 the =

connection with iwd.  Does anything change?

>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
>> src/netdev.c:netdev_disconnect_event()
>> Received Deauthentication event, reason: 2, from_ap: false

And here we see the firmware using an incorrect password somehow and trigge=
ring =

a disconnect by itself, without iwd's input.  I think James had the exact s=
ame =

issue on RPI4, and we determined that the firmware/driver was just borked...

>> src/station.c:station_disconnect_event() 3
>> src/station.c:station_disassociated() 3
>> src/station.c:station_enter_state() Old State: connecting, new state:
>> disconnected >
> I could imagine, that there is still a kernel module missing, but this is=
 just
> guessing. Any hints how to continue debugging?

This is a driver / firmware problem.  You say that wpa_s works correctly.  =
Can =

you capture iwmon traces of both wpa_s and iwd trying to connect to the sam=
e AP =

and share that with us?

Refer to: https://iwd.wiki.kernel.org/debugging for details.  You can also =
hop =

onto #iwd on freenode.  Usually we're around during US working hours.

> =

> I still think that iwd would be a good match for the Raspberry Pi and ide=
ally
> after this issue is fixed most Raspberry Pi user can switch to iwd if they
> like.
> =


Yes, definitely.

Regards,
-Denis
--===============4740864115326607968==--

