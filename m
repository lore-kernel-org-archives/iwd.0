Content-Type: multipart/mixed; boundary="===============0834416783449555033=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 08:43:34 -0700
Message-ID: <5c24f37ffef628a67a1acc8143549191161f0c19.camel@gmail.com>
In-Reply-To: <3472a3f0-9857-32b5-7c7f-744f124e3af0@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0834416783449555033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

<snip>
> > +	if (info->cb)
> > +		info->cb(netdev, 0, info->super.aa, info->user_data);
> > +
> =

> Do you need to set a flag of some sort to indicate that the info has
> been filled =

> successfully?

As long as station behaves and doesn't try and roam prior to a
successful the action frame callback I think we can guarantee it has
been parsed. But in the future when we do multiple concurrent action
frames we would need something to distinguish them in the queue, so
I'll add a flag.

Thanks,
James

> =

> Regards,
> -Denis

--===============0834416783449555033==--

