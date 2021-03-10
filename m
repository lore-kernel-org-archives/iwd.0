Content-Type: multipart/mixed; boundary="===============2791877848515746374=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 6/6] station: disable roaming logic for auto-roaming cards
Date: Wed, 10 Mar 2021 13:48:24 -0800
Message-ID: <03cb5e401c98ac6387b0a81b8b5f49cd98be9dc2.camel@gmail.com>
In-Reply-To: <a5901a8f-9970-b381-1932-3362849e14b6@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2791877848515746374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2021-03-10 at 15:27 -0600, Denis Kenzior wrote:
> Hi James,
> =

> > > Hmm, isn't this completely opposite to the intent of adding this
> > > capability to
> > > brcmfmac?
> > =

> > Unless there is a way to disable FW roaming we cannot allow station
> > to roam =

> =

> Hm, why not?  Isn't the worst case that we run our roam logic as
> well?  In =

> theory we could set the CQM threshold to be more aggressive and
> attempt roams =

> before the firmware does...

Yes worst case is we get the CQM event, do a roam scan, and try to
roam. Then the FW decides its going to roam and CMD_ROAM comes in
during our own roam. I have no idea what that would even mean, I
suspect ultimately we would just get disconnected.

I could try grabbing Alvins patches and trying this. If we could roam
prior to the FW that should work. The problem is we have literally no
idea when or how the FW is going to roam. On these cards it really
seems like the intent is to let the hardware do it on its own. Maybe
Alvin's patches actually change the threshold in the FW?

> =

> > based on CQM events. We don't have any control when the FW roams so
> > for cards =

> > like this I figured it was needed to disable this roaming logic.
> > =

> > I've only tested this on my single brcmfmac card, which definitely
> > will not work =

> =

> What fails?

So as things stand now we get CMD_ROAM and then we just sit there and
don't do anything. This results in the 4-way timing out and a
disconnect.

> =

> > right if station reacts to CQM events. Plus station cannot even do
> > FT on these =

> > cards anyways.
> =

> Sure, and FT is a bit tricky.  But FT is not the only way to roam...
> =

> > Maybe Alvin has some insight to this?
> > =

> =

> Yeah, I'm actually curious why we haven't heard of any
> NL80211_CMD_ROAM related =

> issues ?  I believe I remember Alvin reporting that iwd was working
> fine on his =

> brcmfmac hardware + cqm reporting enabled kernel...

Yeah not sure on this one. I guess we just need to make a policy
decision here. If we always want to roam ourselves then we need a way
to prevent the FW from roaming. If we want to allow both we need to
disable our roaming logic for cards that do it on their own. Allowing
FW roaming plus our own roaming logic just seems like a logic
nightmare.

> =

> Regards,
> -Denis

--===============2791877848515746374==--

