Content-Type: multipart/mixed; boundary="===============5812172750006500425=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: Unsupported finite cyclic group
Date: Mon, 23 May 2022 11:24:14 -0700
Message-ID: <0d8942b2e6636465556d9c8b0f863f5e2f116ae2.camel@gmail.com>
In-Reply-To: CACsRnHXwiVWBBx9k--3j4XWkPX=cwhBDQr81w9a98BjAa-E85A@mail.gmail.com

--===============5812172750006500425==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, 2022-05-20 at 17:56 +0100, Michael Johnson wrote:
> Hi Denis,
> =

> I'm fairly sure it was doing FT as it is set up for that and I don't
> see a 4 way handshake in the log. I do see
> `station_fast_transition_cb` being called as well so I guess it was
> trying FT?
> ```
> May 19 16:16:11.696848 r2-19105 iwd[462]:
> src/station.c:station_fast_transition_cb() 5, result: 2
> ```
> The AP hasn't changed for a while now so I don't think it is directly
> that however it could be that the error it is giving is complete
> nonsense. A second prior to the "finite cycle group" error it does
> also say there was an "Invalid authentication" from the same client so
> maybe it is a red herring if it doesn't make sense in the context.
> =

> Looking more into the difference between 1.21 and master clients,
> oddly I actually see the failure to roam in both (looking for the
> station_fast_transition with result 2) however the AP only reports
> errors for the clients running master. Odd.
> =

> The other two errors which happen after this on master don't happen on
> 1.21. In that case iwd performs a passive scan (same) and then
> connects fine without any "Error sending CMD_ASSOCIATE (-2)" error.
> Likewise the neighbor report is fine in 1.21 but not master.
> =

> Sorry, I think I'm missing some hidden variable here so I'll see if I
> can create a better bug report. I'll set up a capture of iwmon logging
> to get more solid data to go on and narrow down what is happening in
> what version.

This should be fixed in upstream now with:
 =

https://git.kernel.org/pub/scm/network/wireless/iwd.git/commit/?id=3D7104e1=
2667a37cac9790918a5c6a67e529dcd5ba

It ended up being that you're AP was setting a bit IWD did not expect,
but was totally within the spec so we relaxed that check a bit.

> =

> Regards,
> Michael
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============5812172750006500425==--

