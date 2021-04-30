Content-Type: multipart/mixed; boundary="===============5306984453287696680=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 08:57:23 -0700
Message-ID: <41866af323fb5d52f6ac8194f5d1859d4ac32f9d.camel@gmail.com>
In-Reply-To: <867f64de-d259-050a-2e76-602e954094ab@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5306984453287696680==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-04-30 at 10:50 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 4/30/21 10:43 AM, James Prestwood wrote:
> > Hi Denis,
> > =

> > <snip>
> > > > +	if (info->cb)
> > > > +		info->cb(netdev, 0, info->super.aa, info-
> > > > >user_data);
> > > > +
> > > =

> > > Do you need to set a flag of some sort to indicate that the info
> > > has
> > > been filled
> > > successfully?
> > =

> > As long as station behaves and doesn't try and roam prior to a
> > successful the action frame callback I think we can guarantee it
> > has
> =

> Always err on the side of paranoia :)
> =

> > been parsed. But in the future when we do multiple concurrent
> > action
> > frames we would need something to distinguish them in the queue, so
> > I'll add a flag.
> > =

> =

> Also, are you resetting netdev->ft_ds_info once CMD_Associate has
> been sent?

No, and actually I think it can be reset right
inside netdev_fast_transition_over_ds. Once the handshake has been set-
up it isn't needed.

> =

> Regads,
> -Denis

--===============5306984453287696680==--

