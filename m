Content-Type: multipart/mixed; boundary="===============1147003965014479274=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 2/2] netdev: Pass a reason code with
 NETDEV_EVENT_DISCONNECT_BY_*
Date: Tue, 11 May 2021 23:56:57 +0200
Message-ID: <CAOq732Jtd25r9dL7qsqNHeLHLHxJMw14wFQi3Gvch--Aj6XpMA@mail.gmail.com>
In-Reply-To: <71fc7943-1909-5d5f-ecd5-225df4206de0@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1147003965014479274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 11 May 2021 at 18:36, Denis Kenzior <denkenz@gmail.com> wrote:
> On 5/10/21 5:12 AM, Andrew Zaborowski wrote:
> > Station callbacks expect a reason code (as opposed to status codes) with
> > this event type.  This shouldn't matter a lot because
> > station_disconnect_event() only actually looks at the value during
>
> I'm not sure why station is written this way.  I'm pretty sure that calli=
ng
> station_disconnect_event() for NETDEV_EVENT_DISCONNECT_BY_SME() is the wr=
ong
> thing to do.

That is currently the only use of that function though.

>
> > connection establishment so usually the "result" parameter is going to
> > be HANDSHAKE_FAILED meaning that we'd already be getting a reason code
> > in status_or_reason, but there could be corner cases where we got a
> > different "result".
>
> That is correct for AP disconnections during handshaking, but that is sig=
naled
> by NETDEV_EVENT_DISCONNECT_BY_AP...
>
> > ---
> >   src/netdev.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/src/netdev.c b/src/netdev.c
> > index 4fbe813a..6c063df5 100644
> > --- a/src/netdev.c
> > +++ b/src/netdev.c
> > @@ -771,10 +771,15 @@ static void netdev_connect_failed(struct netdev *=
netdev,
> >
> >       if (connect_cb)
> >               connect_cb(netdev, result, &status_or_reason, connect_dat=
a);
> > -     else if (event_filter)
> > +     else if (event_filter) {
> > +             /* NETDEV_EVENT_DISCONNECT_BY_SME expects a reason code */
> > +             if (result !=3D NETDEV_RESULT_HANDSHAKE_FAILED)
> > +                     status_or_reason =3D MMPDU_REASON_CODE_UNSPECIFIE=
D;
> > +
>
>  From what I remember, the only time we can get here is if a rekey somehow
> fails, or setting keys during a rekey fails.  Are there other cases?

In theory you can pass a null connect_cb to netdev_connect_common(),
but in practice we don't do this so you could trigger this only for:

NETDEV_RESULT_HANDSHAKE_FAILED,
NETDEV_RESULT_KEY_SETTING_FAILED,
NETDEV_RESULT_ABORTED.

I realize I was confused, I thought that netdev_connect_failed() was
actually sending NETDEV_EVENT_DISCONNECT_BY_SME to station and
triggering my autoconnect loop, but actually it was
netdev_disconnect_event() which always calls netdev->event_filter and
never uses netdev->connect_cb.  Perhaps netdev_disconnect_event()
should use netdev_connect_failed() instead.

>
> >               event_filter(netdev, NETDEV_EVENT_DISCONNECT_BY_SME,
> >                               &status_or_reason,
> >                               connect_data);
> > +     }
> >   }
> >
> >   static void netdev_disconnect_cb(struct l_genl_msg *msg, void *user_d=
ata)
> >
>
> Anyway, I applied this with a modified commit description.

Thanks.

Best regards
--===============1147003965014479274==--

