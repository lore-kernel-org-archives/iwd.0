Content-Type: multipart/mixed; boundary="===============1511057286238422048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: what is your 5GHz rank modifier?
Date: Thu, 06 May 2021 15:06:00 -0500
Message-ID: <af8e8bac-104d-6f5e-07a3-a52df514768d@gmail.com>
In-Reply-To: <e490f3f35be676156906f9710c64848c47515a03.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1511057286238422048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> As we have suggested others, it seems most appropriate to modify IWD's
> 5GHz ranking specifically to handle this scenario. By default the 5Ghz
> rank modifier is unused (set to 1.0). I would like to know if anyone
> else has been playing with [Rank].BandModifier5Ghz, and found values

Sort of.  BandModifier5Ghz is a blunt tool, mostly there to blindly force 5=
G or not.

> that work for them as we are considering changing the default to better
> handle the average user.

I don't think changing the default is a good idea since it doesn't take =

throughput into account.  Have you looked into tweaking the =

RANK_MAX_SUPPORTED_RATE_FACTOR and RANK_MIN_SUPPORTED_RATE_FACTOR (or reall=
y the =

spread between them)?

Just looking at the base rssi, the formula weighs the network with -43db ab=
out =

2x higher than at -71db.  That is a pretty significant difference to overco=
me. =

As you say, rssi might need to be given less weight or taken out of the equ=
ation =

entirely and have everything be based on the expected throughput.

Still, -71db is below our roaming threshold, so that is also something to c=
onsider.

Regards,
-Denis
--===============1511057286238422048==--

