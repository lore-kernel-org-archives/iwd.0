Content-Type: multipart/mixed; boundary="===============3030655856815667581=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 11:52:25 -0700
Message-ID: <ce52e43f72c0ca30d6a289b169eda61b072bf8c6.camel@gmail.com>
In-Reply-To: <b615766b-f307-46c0-40df-6710c813b0e5@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3030655856815667581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-12 at 13:44 -0500, Denis Kenzior wrote:
> On 6/12/20 1:01 PM, James Prestwood wrote:
> > Hi Denis,
> > =

> > > Sorry I couldn't make up my mind yesterday as to which way to go
> > > in
> > > canceling
> > > remaining ANQP requests on connect or not.
> > > =

> > > This series looks good, but I'm not sure why you'd treat
> > > 'connect_after_anqp'
> > > differently than a regular connect request over d-bus.  Those can
> > > come in during
> > > autoconnect phase and can still get stuck in the 'agent limbo'...
> > > =

> > > By the way, it might also warrant a WARN_ON if we ever hit the
> > > =

> > > +	if (network->connect_after_anqp)
> > > +		return -EALREADY;
> > > +
> > > =

> > > condition inside network_autoconnect().  Since it really
> > > shouldn't
> > > happen and is
> > > likely a bug in station if it did.
> > =

> > So this behavior is actually happening with my new ANQP delay
> > autotest:
> >   - During scan callback ANQP is started
> >   - Connect() comes in before ANQP is done.
> >   - ANQP finishes and notifies network, which resumes the
> > Connect(). But
> > we need to now do an agent request.
> >   - Then autoconnect comes in and attempts to connect, but we are
> > missing secrets so it then closes the network settings
> >   - Agent request comes back and settings have been destroyed out
> > from
> > under it so we fail with NotConfigured.
> > =

> > Maybe instead we could have network disable autoconnect when we are
> > in
> > this limbo state of an agent request? And/or while waiting for ANQP
> > to
> > finish.
> =

> But this behavior is not related to anqp itself.  Hence why I'm
> asking why =

> you're trying to treat the 'connect while in anqp and then needing
> secrets' =

> different from 'connect while in autoconnect and needing secrets'
> =

> Maybe we should simply not close settings if agent requests are
> pending in =

> network_autoconnect.

Really not do *anything* in network_autoconnect if agent requests are
pending. Ill replace my network->connect_after_anqp check with network-
>agent_request instead.

> =

> Regards,
> -Denis

--===============3030655856815667581==--

