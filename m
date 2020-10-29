Content-Type: multipart/mixed; boundary="===============6789192724235216838=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 11:40:51 -0700
Message-ID: <a18cbbefd1ae73487f3bb79127aa9b11d7ce5b83.camel@gmail.com>
In-Reply-To: <CAOq732K01DA7_9iWTJAw2-x96ESj9996HZQd_8fmSKx-eWA9ww@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6789192724235216838==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 2020-10-29 at 19:05 +0100, Andrew Zaborowski wrote:
> Hi James!
> =

> On Thu, 29 Oct 2020 at 17:37, James Prestwood <prestwoj@gmail.com>
> wrote:
> > This seems to happen occationally with testAP (potentially others).
> > The invalid read appears to happen when the frame_xchg_tx_cb
> > detects
> > an early status and no ACK. In this particular case there is no
> > retry interval so we reach the retry limit and 'done' the frame.
> > This frees the 'fx' data all before the destroy callback can get
> > called.
> =

> frame_xchg_done() should result in l_genl_family_cancel(fx-
> >tx_cmd_id)
> which would call the destroy callback before 'fx' is freed so there
> should be some other reason this is happening.
> =

> One possibility is that we passed a wrong id to
> l_genl_family_cancel(), can you check that it returns true?

So it looks like frame-xchg has got some order of operations backwards.
Every single call to l_genl_family_cancel fails. And this isn't really
surprising because in normal case we are canceling after we are already
in the callback so there is really nothing to cancel right?

Maybe you had a better idea of how to handle this but I think zero'ing
the command ID in the callback is still the right thing to do. That way
l_genl_family_cancel won't get called unless we are actually canceling
a still in-flight frame.

Here is with some prints added [*]:

[*]src/frame-xchg.c:frame_xchg_tx_retry() Sending frame with ID 83
src/station.c:station_netdev_event() Associating
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/frame-xchg.c:frame_xchg_mlme_notify() Received an ACK
src/frame-xchg.c:frame_xchg_tx_cb() err 0
AP Authentication frame 2 ACKed by STA
src/wiphy.c:wiphy_radio_work_done() Work item 10 done
[*]src/frame-xchg.c:frame_xchg_reset() Canceling ID 83
[*]src/frame-xchg.c:frame_xchg_reset() Failed to cancel 83

And this is true for every single frame from what I can tell. I was
also able to reproduce this reliably by adding 'hwsim_medium=3Dno' to
testAP/main.conf if you care to give it a spin (with --valgrind as
well).

Thanks,
James

> =

> By the way do you use the usb passthrough to trigger this?  I don't
> think hwsim has the "early status" quirk.
> =

> Best regards

--===============6789192724235216838==--

