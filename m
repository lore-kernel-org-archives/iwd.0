Content-Type: multipart/mixed; boundary="===============8269005077347707274=="
MIME-Version: 1.0
From: Alvin =?unknown-8bit?q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Thu, 11 Mar 2021 00:16:31 +0000
Message-ID: <3f944297-a534-7aaf-0f94-9a27c3d27647@bang-olufsen.dk>
In-Reply-To: <03cb5e401c98ac6387b0a81b8b5f49cd98be9dc2.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8269005077347707274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi both,

On 3/10/21 10:48 PM, James Prestwood wrote:
> On Wed, 2021-03-10 at 15:27 -0600, Denis Kenzior wrote:
>> Hi James,
>>
>>>> Hmm, isn't this completely opposite to the intent of adding this
>>>> capability to
>>>> brcmfmac?
>>>
>>> Unless there is a way to disable FW roaming we cannot allow station
>>> to roam
>>
>> Hm, why not?  Isn't the worst case that we run our roam logic as
>> well?  In
>> theory we could set the CQM threshold to be more aggressive and
>> attempt roams
>> before the firmware does...
> =

> Yes worst case is we get the CQM event, do a roam scan, and try to
> roam. Then the FW decides its going to roam and CMD_ROAM comes in
> during our own roam. I have no idea what that would even mean, I
> suspect ultimately we would just get disconnected.
> =

> I could try grabbing Alvins patches and trying this. If we could roam
> prior to the FW that should work. The problem is we have literally no
> idea when or how the FW is going to roam. On these cards it really
> seems like the intent is to let the hardware do it on its own. Maybe
> Alvin's patches actually change the threshold in the FW?

Roam offload is enabled by default in brcmfmac, but it can be disabled =

by setting the module parameter roamoff=3D1. Note this stands for "roam =

(offload) off" - not "roam off(load)" - so 1 means that the firmware =

will not roam autonomously. Anyway, in that case the driver will not set =

the WIPHY_FLAG_SUPPORTS_FW_ROAM flag:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:
7180	if (!ifp->drvr->settings->roamoff)
7181		wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_FW_ROAM;

So from that perspective, I think James' patch looks perfectly fine. I =

have not tested it though.

>>> based on CQM events. We don't have any control when the FW roams so
>>> for cards
>>> like this I figured it was needed to disable this roaming logic.
>>>
>>> I've only tested this on my single brcmfmac card, which definitely
>>> will not work
>>
>> What fails?
> =

> So as things stand now we get CMD_ROAM and then we just sit there and
> don't do anything. This results in the 4-way timing out and a
> disconnect.

Yes, this was what I experienced when the firmware roamed by itself. =

Since we rely on iwd to handle the 4-Way Handshake, I instead worked on =

getting roaming to work with roam offload disabled. But I didn't think =

to go back and submit some iwd patches to handle the original failure =

case - my bad.

> =

>>
>>> right if station reacts to CQM events. Plus station cannot even do
>>> FT on these
>>> cards anyways.
>>
>> Sure, and FT is a bit tricky.  But FT is not the only way to roam...

Right, and I naively hoped that I might be able to get FT roaming to =

work too. The latest news I have from our hardware vendor is that - in =

theory - the chip firmware supports sending reassoc/auth frames, but I =

have not received any documentation yet. As it stands, brcmfmac does not =

implement the relevant cfg80211 ops, so one must settle for non-FT =

roaming if one wishes to use iwd. That would change with the incoming =

support for 4-Way Handshake offload in iwd, in which case both things =

can be offloaded to the firmware.

Personally I am a bit distrustful of the firmware, so it seemed like a =

better use of my time to rest control of the entire roaming process away =

from the firmware and into the supplicant. The lack of FT support is =

disappointing though, so perhaps I should have just worked on 4-Way =

Handshake offload support for iwd instead. I'm not working on the FT =

stuff these days but I'll follow up when I have some time.

>>> Maybe Alvin has some insight to this?
>>>
>>
>> Yeah, I'm actually curious why we haven't heard of any
>> NL80211_CMD_ROAM related
>> issues ?  I believe I remember Alvin reporting that iwd was working
>> fine on his
>> brcmfmac hardware + cqm reporting enabled kernel...
> =

> Yeah not sure on this one. I guess we just need to make a policy
> decision here. If we always want to roam ourselves then we need a way
> to prevent the FW from roaming. If we want to allow both we need to
> disable our roaming logic for cards that do it on their own. Allowing
> FW roaming plus our own roaming logic just seems like a logic
> nightmare.

The simple answer is that it never worked for me until I disabled =

roaming in the firmware (roamoff=3D1).

I agree with James when he says that enabling roaming in both supplicant =

and firmware is going to be a nightmare. I also don't think that the =

vendors have tested this use-case to begin with. The firmware actually =

has a number of variables that can be configured via the proprietary =

`wl` command line tool to set roaming thresholds and things like that. =

But the kernel patch I sent doesn't have anything to do with that - it =

is purely for RSSI monitoring.

Sadly I think there are some philosophical compromises that one has to =

make when dealing with fullmac chips/drivers on Linux, at least with the =

way things are right now...

> =

>>
>> Regards,
>> -Denis
>=20

--===============8269005077347707274==--

