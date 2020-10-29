Content-Type: multipart/mixed; boundary="===============3893859721666562802=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Fri, 30 Oct 2020 00:33:00 +0100
Message-ID: <CAOq732JrWNncQJceok3mH5uCUsMRrTFocwTePdnF=2t_T5WHLw@mail.gmail.com>
In-Reply-To: <a18cbbefd1ae73487f3bb79127aa9b11d7ce5b83.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3893859721666562802==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Oct 2020 at 19:40, James Prestwood <prestwoj@gmail.com> wrote:
> On Thu, 2020-10-29 at 19:05 +0100, Andrew Zaborowski wrote:
> > frame_xchg_done() should result in l_genl_family_cancel(fx-
> > >tx_cmd_id)
> > which would call the destroy callback before 'fx' is freed so there
> > should be some other reason this is happening.
> >
> > One possibility is that we passed a wrong id to
> > l_genl_family_cancel(), can you check that it returns true?
>
> So it looks like frame-xchg has got some order of operations backwards.
> Every single call to l_genl_family_cancel fails. And this isn't really
> surprising because in normal case we are canceling after we are already
> in the callback so there is really nothing to cancel right?

Oh okay, that's why it's not cancelling the destroy callback.  I
definitely think there should be a way to make ell forget the genl
command at any phase including in the callback.  So I'd be in favour
of changing l_genl_family_cancel to do this.  Denis, what do you think
is better?

>
> Maybe you had a better idea of how to handle this but I think zero'ing
> the command ID in the callback is still the right thing to do. That way
> l_genl_family_cancel won't get called unless we are actually canceling
> a still in-flight frame.

The destroy callback would still be called though.  Or if we drop it
like in the patch, we'd have to manually do: fx->tx_cmd_id =3D 0 every
time we cancel tx_cmd_id or free nl80211.

>
> Here is with some prints added [*]:
>
> [*]src/frame-xchg.c:frame_xchg_tx_retry() Sending frame with ID 83
> src/station.c:station_netdev_event() Associating
> src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
> src/frame-xchg.c:frame_xchg_mlme_notify() Received an ACK
> src/frame-xchg.c:frame_xchg_tx_cb() err 0
> AP Authentication frame 2 ACKed by STA
> src/wiphy.c:wiphy_radio_work_done() Work item 10 done
> [*]src/frame-xchg.c:frame_xchg_reset() Canceling ID 83
> [*]src/frame-xchg.c:frame_xchg_reset() Failed to cancel 83
>
> And this is true for every single frame from what I can tell. I was
> also able to reproduce this reliably by adding 'hwsim_medium=3Dno' to
> testAP/main.conf if you care to give it a spin (with --valgrind as
> well).

I wasn't able to reproduce the invalid read yet, but I do get
occasional failures in test_connection_success.
--===============3893859721666562802==--

