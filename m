Content-Type: multipart/mixed; boundary="===============0163306047733985492=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix invalid read
Date: Thu, 29 Oct 2020 11:17:29 -0700
Message-ID: <5cb01c7985e9b6d62a432ae5fc6a80b36d0a61ac.camel@gmail.com>
In-Reply-To: <CAOq732K01DA7_9iWTJAw2-x96ESj9996HZQd_8fmSKx-eWA9ww@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0163306047733985492==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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

Yeah, Ill check this.

> =

> By the way do you use the usb passthrough to trigger this?  I don't
> think hwsim has the "early status" quirk.

No I've just been running testAP in test-runner. It doesnt happen all
the time but I've seen it now a few times.

I also noticed another issue (could be related) where the STA isnt
ACK'ing the probe response:

AP Probe Request from 02:00:00:00:03:00
src/wiphy.c:wiphy_radio_work_insert() Inserting work item 8
src/wiphy.c:wiphy_radio_work_next() Starting work item 8
src/frame-xchg.c:frame_xchg_tx_cb() err 0
src/netdev.c:netdev_mlme_notify() MLME notification Frame TX Status(60)
src/frame-xchg.c:frame_xchg_mlme_notify() Received no ACK
src/frame-xchg.c:frame_xchg_wait_cancel() =

Frame tx retry limit reached
AP Probe Response received no ACK
src/wiphy.c:wiphy_radio_work_done() Work item 8 done

But this doesn't always result in the invalid read, and could be
completely unrelated. I have 'fixed' this by adding a response timeout
to frame_xchg_start but had to go up to 200ms to get testAP to pass
reliably. Even a 100ms timeout resulted in occational un-acked probe
responses.

Thanks,
James

> =

> Best regards

--===============0163306047733985492==--

