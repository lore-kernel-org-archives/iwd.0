Content-Type: multipart/mixed; boundary="===============4597077073019552719=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: [PATCH v2 2/4] network: delay connect if ANQP has not completed
Date: Fri, 12 Jun 2020 11:01:27 -0700
Message-ID: <02637a099750f4104d077f8b37d1983be3ca90ac.camel@gmail.com>
In-Reply-To: <ff93aa8e-3606-e02d-6a16-e24e1c4a5e12@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4597077073019552719==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Sorry I couldn't make up my mind yesterday as to which way to go in
> canceling =

> remaining ANQP requests on connect or not.
> =

> This series looks good, but I'm not sure why you'd treat
> 'connect_after_anqp' =

> differently than a regular connect request over d-bus.  Those can
> come in during =

> autoconnect phase and can still get stuck in the 'agent limbo'...
> =

> By the way, it might also warrant a WARN_ON if we ever hit the
> =

> +	if (network->connect_after_anqp)
> +		return -EALREADY;
> +
> =

> condition inside network_autoconnect().  Since it really shouldn't
> happen and is =

> likely a bug in station if it did.

So this behavior is actually happening with my new ANQP delay autotest:
 - During scan callback ANQP is started
 - Connect() comes in before ANQP is done.
 - ANQP finishes and notifies network, which resumes the Connect(). But
we need to now do an agent request.
 - Then autoconnect comes in and attempts to connect, but we are
missing secrets so it then closes the network settings
 - Agent request comes back and settings have been destroyed out from
under it so we fail with NotConfigured.

Maybe instead we could have network disable autoconnect when we are in
this limbo state of an agent request? And/or while waiting for ANQP to
finish.

> =

> Regards,
> -Denis

--===============4597077073019552719==--

