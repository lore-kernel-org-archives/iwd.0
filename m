Content-Type: multipart/mixed; boundary="===============7690346106849885592=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [RFC 4/6] frame-xchg: refactor to work with offchannel module
Date: Mon, 22 Jun 2020 13:01:18 -0700
Message-ID: <7cf16a2fc43591bb0355c07fed2b004a20f444a4.camel@gmail.com>
In-Reply-To: <643d015a-71f2-56bd-2dc6-38afd13a533d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7690346106849885592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-22 at 14:55 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 6/17/20 12:56 PM, James Prestwood wrote:
> > In order to first integrate frame-xchg some refactoring needed to
> > be done. First it is useful to allow queueing frames up rather than
> > requiring the module (p2p, anqp etc) to wait for the last frame to
> > finish. This can be aided by offchannel but frame-xchg needed some
> > refactoring as well.
> > =

> > First was getting rid of this fx pointer re-use. It looks like this
> > was done to save a bit of memory but things get pretty complex
> > needed to check if the pointer is stale or has been reset. Instead
> > of this we now just allocate a new pointer each frame-xchg. This
> > allows for the module to queue multiple requests as well as removes
> > the complexity of needed to check if the fx pointer is stale.
> > =

> > Next was adding the ability to track frame-xchgs by ID. If a module
> > can queue up multiple requests it also needs to be able to cancel
> > them individually vs per-wdev. This comes free with offchannel
> > since
> > it returns an ID which can be given directly to the caller.
> > =

> > Then offchannel was simply piped in by adding the push/done APIs
> > as well as some minor modification to internal frame-xchg APIs for
> > destroy functionality.
> > ---
> >   src/frame-xchg.c | 97 +++++++++++++++++++++--------------------
> > -------
> >   src/frame-xchg.h |  6 +--
> >   src/p2p.c        |  9 +++--
> >   3 files changed, 51 insertions(+), 61 deletions(-)
> > =

> =

> <snip>
> =

> > -void frame_xchg_stop(uint64_t wdev_id);
> > +void frame_xchg_stop(uint64_t wdev_id, uint32_t id);
> =

> Do we even need the wdev_id here now? Also, should this be _cancel?

It just made the lookup easier, but yeah we could iterate each queue in
the phy list. And yeah, I could change that to _cancel.

> =

> Regards,
> -Denis

--===============7690346106849885592==--

