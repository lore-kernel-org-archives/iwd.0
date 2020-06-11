Content-Type: multipart/mixed; boundary="===============4919931035734756244=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH 1/4] station: add ANQP state watch API
Date: Thu, 11 Jun 2020 14:38:00 -0700
Message-ID: <ec139f6e3ac0b9ab6acc2ada0079591a906482f4.camel@gmail.com>
In-Reply-To: <ab8a1b39-29a1-6668-f184-9eaf5ccf5bd2@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4919931035734756244==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 16:30 -0500, Denis Kenzior wrote:
> Hi James,
> =

> On 6/11/20 12:26 PM, James Prestwood wrote:
> > This is to allow network to watch for ANQP activity in order to
> > fix the race condition between scanning finishing and ANQP
> > finishing.
> > Without this it is possible for a DBus Connect() to come in before
> > ANQP has completed and causing the network to return NotConfigured,
> > when its actually in the process of obtaining all the network info.
> > =

> > The watch was made globally in station due to network not having
> > a station object until each individual network is created. Adding a
> > watch during network creation would result in many watchers as well
> > as a lot of removal/addition as networks are found and lost.
> > ---
> >   src/station.c | 21 +++++++++++++++++++++
> >   src/station.h | 13 +++++++++++++
> >   2 files changed, 34 insertions(+)
> > =

> =

> <snip>
> =

> >   struct station {
> >   	enum station_state state;
> > @@ -489,6 +490,9 @@ static void station_anqp_response_cb(enum
> > anqp_result result,
> >   request_done:
> >   	l_queue_remove(station->anqp_pending, entry);
> >   =

> > +	WATCHLIST_NOTIFY(&anqp_watches, station_anqp_watch_func_t,
> > +				STATION_ANQP_FINISHED, network);
> > +
> =

> So you don't want to delay until all anqp requests finish?  Will the
> kernel =

> cancel all the anqp work items nicely in this case?

Yeah good point. We could do one of two things:

 - Wait until all ANQP requets come back, then notify each network of
changes, or

 - Notify as they come in and cancel any pending requests if a connect
comes in.

And no the kernel doesn't do any of this for us, I see ANQP responses
coming in after we start doing a Connect() in my auto tests.

> =

> >   	/* If no more requests, resume scanning */
> >   	if (!l_queue_isempty(station->anqp_pending))
> >   		return;
> =

> Regards,
> -Denis

--===============4919931035734756244==--

