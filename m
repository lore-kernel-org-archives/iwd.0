Content-Type: multipart/mixed; boundary="===============8888311808719575364=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: what is your 5GHz rank modifier?
Date: Thu, 06 May 2021 13:11:52 -0700
Message-ID: <0c8cf70209c589c481c8fccdf04ebb8e5f3b257c.camel@gmail.com>
In-Reply-To: <af8e8bac-104d-6f5e-07a3-a52df514768d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8888311808719575364==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2021-05-06 at 15:06 -0500, Denis Kenzior wrote:
> Hi James,
> =

> > As we have suggested others, it seems most appropriate to modify
> > IWD's
> > 5GHz ranking specifically to handle this scenario. By default the
> > 5Ghz
> > rank modifier is unused (set to 1.0). I would like to know if
> > anyone
> > else has been playing with [Rank].BandModifier5Ghz, and found
> > values
> =

> Sort of.=C2=A0 BandModifier5Ghz is a blunt tool, mostly there to blindly
> force 5G or not.
> =

> > that work for them as we are considering changing the default to
> > better
> > handle the average user.
> =

> I don't think changing the default is a good idea since it doesn't
> take =

> throughput into account.=C2=A0 Have you looked into tweaking the =

> RANK_MAX_SUPPORTED_RATE_FACTOR and RANK_MIN_SUPPORTED_RATE_FACTOR (or
> really the =

> spread between them)?

I did play around with those but I found that the calculated 2.4 rate
was close enough that these values needed to change more drastically
than what I was expecting. But I didn't look too deep into this either.
I think you're right, the spread between them may need to increase to
give the effect we want.

> =

> Just looking at the base rssi, the formula weighs the network with -
> 43db about =

> 2x higher than at -71db.=C2=A0 That is a pretty significant difference to
> overcome. =

> As you say, rssi might need to be given less weight or taken out of
> the equation =

> entirely and have everything be based on the expected throughput.
> =

> Still, -71db is below our roaming threshold, so that is also
> something to consider.

Yeah, this occurred to me as well. The roam threshold should probably
be tweaked for 5Ghz.
> =

> Regards,
> -Denis


--===============8888311808719575364==--

