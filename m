Content-Type: multipart/mixed; boundary="===============0158207846694019709=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: iwd problems on Arch Linux
Date: Mon, 19 Oct 2020 09:04:56 +0200
Message-ID: <20201019070456.3gtp7mjkur6ikkr4@beryllium.lan>
In-Reply-To: <695a2b81-db6f-b22f-3be0-e4476275f39b@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0158207846694019709==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Fri, Oct 16, 2020 at 11:00:32AM -0500, Denis Kenzior wrote:
> So iwd is built to scan the least amount possible, since scanning interru=
pts
> your link (radio has to physically switch off the channel, so your packets
> are lost in the meantime).  We scan only when in 'Autoconnect' state and
> when signal strength gets so low we need to try and roam.  If the network
> supports neighbor reports or other advanced BSS mangement features, we use
> those to minimize the set of channels we scan.

Okay, that explains the behavior Keith is reporting.

> In Autoconnect mode (and only in Autoconnect mode when we're not connected
> anywhere else) iwd scans periodically.  If a network is marked
> AutoConnect=3Dfalse, then that network is not considered as a candidate in
> this stage.
> =

> Station.Disconnect tells iwd to disconnect from whatever it is connected =
to
> and not enter into its Autoconnect mode.  This is essentially used to tell
> iwd that some external application wants to control how scanning  &
> autoconnect logic is performed.
> =

> In general, I would encourage using iwd's autoconnect logic since it can
> optimize the scan parameters and reconnect quickly.  This is why you see =
iwd
> re-connect to networks about 10x faster than NM+wpa_s.

I get your point and it totally makes sense if you only consider only
one uplink (technology). I would even go further and say, don't use
ConnMan if you only want to use WiFi.

But it gets a bit more tricky for the use case: use WiFi if possible and
fallback to cellular network if it's not available. Maybe it is possible
to enable the autoconnect mode. I haven't really thought it through yet.

At least I know now why we have these problems.

Thanks,
Daniel
--===============0158207846694019709==--

