Content-Type: multipart/mixed; boundary="===============8893351227076845029=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH 1/3] wsc: Split out enrollee state machine to own object
Date: Wed, 15 Jan 2020 02:23:24 +0100
Message-ID: <CAOq732Le12r6LjdZppay4U0agPHCzHgNmjeJ-WfwsE05ay1JNQ@mail.gmail.com>
In-Reply-To: <9cfe570e-16f2-f9a6-b3d2-48baed9ff6cb@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8893351227076845029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, 13 Jan 2020 at 19:49, Denis Kenzior <denkenz@gmail.com> wrote:
> >>>        case -ECANCELED:
> >>> -             dbus_pending_reply(&wsc->pending,
> >>> +             if (wsc->pending)
> >>> +                     dbus_pending_reply(&wsc->pending,
> >>>                                        dbus_error_aborted(wsc->pendin=
g));
> >>
> >> Hmm, why the if ()?
> >
> > In some scenario we're sending a not_available reply so this is a
> > mechanism to override the specific reply.
>
> This happens only on wsc_free, and I think you should be bypassing
> calling wsc_enrollee_cancel in that case.  The netdev is likely already
> gone by then anyway.

wsc_free may happen because the netdev is going away or because iwd is
shutting down, or we're switching modes.  In those cases if we have a
WSC negotiation running we should try to send the disconnect, although
I think this is automatically triggered at some lower layer too.  But
we also use netdev_disconnect to sort of make sure we never get
another connect callback from netdev and I don't think skipping it is
a good idea (we'd need to analyse a few code paths and add comments
and we might end up getting it wrong anyway).  This is why I think
station_free does it and I don't think it's wrong.

Best regards
--===============8893351227076845029==--

