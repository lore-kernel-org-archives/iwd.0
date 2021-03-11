Content-Type: multipart/mixed; boundary="===============5906363637602929483=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Wed, 10 Mar 2021 20:36:51 -0600
Message-ID: <90841d57-63ec-5603-e4b2-876e0f741db2@gmail.com>
In-Reply-To: <3f944297-a534-7aaf-0f94-9a27c3d27647@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5906363637602929483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

> Roam offload is enabled by default in brcmfmac, but it can be disabled
> by setting the module parameter roamoff=3D1. Note this stands for "roam
> (offload) off" - not "roam off(load)" - so 1 means that the firmware
> will not roam autonomously. Anyway, in that case the driver will not set
> the WIPHY_FLAG_SUPPORTS_FW_ROAM flag:
> =

> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:
> 7180	if (!ifp->drvr->settings->roamoff)
> 7181		wiphy->flags |=3D WIPHY_FLAG_SUPPORTS_FW_ROAM;
> =

> So from that perspective, I think James' patch looks perfectly fine. I
> have not tested it though.

Aha!  Thanks for the explanation.  In light of this I concur that we should=
 take =

James' proposed approach and disable iwd's roaming logic if the flag is set.

> Yes, this was what I experienced when the firmware roamed by itself.
> Since we rely on iwd to handle the 4-Way Handshake, I instead worked on
> getting roaming to work with roam offload disabled. But I didn't think
> to go back and submit some iwd patches to handle the original failure
> case - my bad.
> =


No worries, I was just confused how you were not hitting this case and wond=
ered =

whether you had more aggressive roaming thresholds so iwd roamed ahead of t=
he =

firmware.

>>
>>>
>>>> right if station reacts to CQM events. Plus station cannot even do
>>>> FT on these
>>>> cards anyways.
>>>
>>> Sure, and FT is a bit tricky.  But FT is not the only way to roam...
> =

> Right, and I naively hoped that I might be able to get FT roaming to
> work too. The latest news I have from our hardware vendor is that - in
> theory - the chip firmware supports sending reassoc/auth frames, but I
> have not received any documentation yet. As it stands, brcmfmac does not
> implement the relevant cfg80211 ops, so one must settle for non-FT
> roaming if one wishes to use iwd. That would change with the incoming
> support for 4-Way Handshake offload in iwd, in which case both things
> can be offloaded to the firmware.

Right.  This is also a problem for SAE and OWE.  We are also having trouble =

locating brcmfmac based hardware that is SAE/WPA3 or FT offload capable.  A=
ny =

pointers?

It may actually be nice if brcmfmac allowed us to do Authenticate/Associate =

without the offload.  I'm fairly certain 802.1X + offload still has many =

surprises in store for us...

> =

> Personally I am a bit distrustful of the firmware, so it seemed like a
> better use of my time to rest control of the entire roaming process away

Agreed.

> from the firmware and into the supplicant. The lack of FT support is
> disappointing though, so perhaps I should have just worked on 4-Way
> Handshake offload support for iwd instead. I'm not working on the FT
> stuff these days but I'll follow up when I have some time.

That'd be great.

<snip>

>> Yeah not sure on this one. I guess we just need to make a policy
>> decision here. If we always want to roam ourselves then we need a way
>> to prevent the FW from roaming. If we want to allow both we need to
>> disable our roaming logic for cards that do it on their own. Allowing
>> FW roaming plus our own roaming logic just seems like a logic
>> nightmare.
> =

> The simple answer is that it never worked for me until I disabled
> roaming in the firmware (roamoff=3D1).

May be academic at this point, but I'm still curious as to what actually fa=
iled?

Regards,
-Denis
--===============5906363637602929483==--

