Content-Type: multipart/mixed; boundary="===============1121970638858898091=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Mon, 31 Aug 2020 08:42:41 -0500
Message-ID: <46198816-d3fa-6fe5-c211-4ab6b1b33670@gmail.com>
In-Reply-To: <6679878.YKXMNv7jBj@mmm>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1121970638858898091==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On 8/30/20 8:38 AM, Patrick H=C3=A4cker wrote:
> Hi Denis,
> =

> thanks for the answer!
> =

>> This is a brcmfmac card right?  We have seen some weirdness with brcmfmac
>> where it simply refuses to perform the handshake (which is what is
>> happening in your case).  The handshake times out (reason: 15 =3D
>> MMPDU_REASON_CODE_4WAY_HANDSHAKE_TIMEOUT).
>>
>> The strange part is that it does work in other setups and it seems to be=
 a
>> combination of AP or some other weird factor that screws this up.  Have =
you
>> tried different brcmfmac firmware versions?
> Yes, it's a brcmfmac card. I speculate, that it had some state, which iwd=
 did
> not expect due to booting up with wpa_supplicant and only switching to iwd
> afterwards (it worked after I removed wpa_supplicant and rebooted).

There isn't really any state for iwd to be confused by.   Once a CMD_DISCON=
NECT =

is issued, or the device brought into IF_OPER_DOWN state, the kernel / driv=
er =

should clean up any state associated with the previous connection.

iwd tries to reset as much of the driver as possible at startup, by =

deleting/re-creating the default interface and power-cycling the card. =

Unfortunately brcmfmac doesn't support the first part either.

The issue is likely that wpa_s uses handshake offload (with handshake handl=
ed by =

the firmware) and iwd does not.  This maybe leads to the firmware or driver =

being confused possibly due to some missing cleanups.  But that's a kernel =

driver / firmware issue, not a problem in iwd.

> =

> Therefore I did not try different brcmfmac firmware versions. I am probab=
ly
> using this firmware:
>> brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip
>>      BCM4345/6
>> brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Mar 23 2020
>>      02:19:54 version 7.45.206 (r725000 CY) FWID 01-88ee44ea
> =

>>>> src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
>>>> src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
>>>>
>>>>       (global) is DE
>>
>> Seems like the kernel is switching the regulatory domain here, right aft=
er
>> we try to connect.  I wonder if you can use iw to set this prior to
>> triggering the connection with iwd.  Does anything change?
> Actually, the reg domain is set before to the correct value (DE in my cas=
e, I
> have double-checked that, when I saw the message in the logs). I am not s=
ure
> why it's switching.  I am on channel 13, so with an US/default reg domain=
 I
> couldn't access the 2-GHz-Wi-Fi.

Okay, we can seemingly rule that out then...

> =

>>>> src/netdev.c:netdev_link_notify() event 16 on ifindex 3
>>>> src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
>>>> src/netdev.c:netdev_disconnect_event()
>>>> Received Deauthentication event, reason: 2, from_ap: false
>>
>> And here we see the firmware using an incorrect password somehow and
>> triggering a disconnect by itself, without iwd's input.  I think James h=
ad
>> the exact same issue on RPI4, and we determined that the firmware/driver
>> was just borked...
> The provided password was definitely correct, as it's provided by a file =
and
> working now without being changed in between. But it might be, that the
> firmware/driver ended up with a wrong authentication somehow, although the
> correct password was provided.
> =

>>>> src/station.c:station_disconnect_event() 3
>>>> src/station.c:station_disassociated() 3
>>>> src/station.c:station_enter_state() Old State: connecting, new state:
>>>> disconnected >
>>>
>>> I could imagine, that there is still a kernel module missing, but this =
is
>>> just guessing. Any hints how to continue debugging?
>>
>> This is a driver / firmware problem.  You say that wpa_s works correctly.
>> Can you capture iwmon traces of both wpa_s and iwd trying to connect to =
the
>> same AP and share that with us?
> I wanted to use iwmon already before. Unfortunately, it does not work on =
this
> system:
>> Wireless monitor ver 1.8
>> Failed to create monitor interface nlmon: Unknown error -95
> There is (to me) no obvious error in its strace, but I am omitting it her=
e, as
> it is probably a separate issue and I=E2=80=82am not sure if anyone is in=
terested in
> solving that problem.

You do not have nlmon (CONFIG_NLMON) compiled into the kernel or perhaps th=
e =

nlmon module is not loaded.

> =

> So where to go from here on? The principle issue (iwd in Raspbian) is sol=
ved.
> But if someone is interested to find and fix the root cause to avoid the
> removing/rebooting procedure on the Raspberry Pi in the future, I can ass=
ist
> with this (although my time is limited mostly to weekends).
> My gut feeling is, that we need to fix that issue before suggesting to ha=
ve iwd
> as default on a Raspberry.
> =


Not sure, but so far it really sounds like you need to start a thread on =

linux-wireless and get brcmfmac maintainer's attention.

Regards,
-Denis
--===============1121970638858898091==--

