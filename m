Content-Type: multipart/mixed; boundary="===============6634268393410403056=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v4 5/7] ft: netdev: refactor FT-over-DS into two stages
Date: Fri, 30 Apr 2021 09:02:26 -0700
Message-ID: <30c4a65973f3e5833d64f18e3e7e13eec2507ad9.camel@gmail.com>
In-Reply-To: <ec2716cd-6631-f1ab-da4a-bddc08f98336@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6634268393410403056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2021-04-30 at 10:59 -0500, Denis Kenzior wrote:
> Hi James,
> =

> > > Also, are you resetting netdev->ft_ds_info once CMD_Associate has
> > > been sent?
> > =

> > No, and actually I think it can be reset right
> > inside netdev_fast_transition_over_ds. Once the handshake has been
> > set-
> > up it isn't needed.
> > =

> =

> OK, but it should be reset in all cases, including if we do a FT-
> over-Air.

Ah ok makes sense. Any other connection *should* reset it via
netdev_connect_free, but yes we could do over Air after a failed over
DS action frame.

> =

> Regards,
> -Denis

--===============6634268393410403056==--

