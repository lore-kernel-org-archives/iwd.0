Content-Type: multipart/mixed; boundary="===============3394745147589768269=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [RFCv3] Document P2P dbus interfaces
Date: Fri, 15 Nov 2019 16:10:57 +0100
Message-ID: <CAOq732JU_+kDbH0FD3AxRscBn8CUpi8Cntf7GycymCSgVJzgfg@mail.gmail.com>
In-Reply-To: <73ee28b9-9336-f547-cf2b-1246181c9dde@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3394745147589768269==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Nov 2019 at 15:53, Denis Kenzior <denkenz@gmail.com> wrote:
> >> I think about this differently.  You have 2 phases:
> >>     1. Simple Configuration (WiFi Direct flavor) which involves the gr=
oup
> >> formation and wsc negotiation
> >
> > Well, it simply isn't part of WSC, but ok.
> >
>
> P2P in the end just took WSC and changed the discovery bits a bit.
> Fundamentally its still WSC in the end.  But I guess depends on how you
> think about it...
>
> >>     2. Actual connection establishment
> >>
> >> I don't see why Disconnect can't just affect 2 without affecting 1.  T=
he
> >> operations are on different interfaces after all.
> >
> > We just don't need 2 methods and I already have Disconnect working
> > this way (consistent with Station.Disconnect) so it'd mean just
> > artificially crippling it, also adding a race where your Cancel call
> > may work or not.
>
> Station.Disconnect does not affect WSC state FYI.  It can't since
> Station doesn't even know about the ongoing WSC process until after
> station_connect_network is invoked.  So in that respect we'd be
> completely consistent.

What I meant is that Disconnect() can cancel your station connection
attempt at any point, while with Peer.Disconnect() you're going to
have to be more careful for no reason.

>
> >
> > (Tecnically provisioning and the connection are both on the P2P_CLIENT
> > interface)
> >
>
> Same as Station/WSC today...

I was just noting they're not happening on different interfaces.

Best regards
--===============3394745147589768269==--

