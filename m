Content-Type: multipart/mixed; boundary="===============2861840370198438749=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: Permanent disconnect when AP changes frequency
Date: Fri, 04 Mar 2022 11:00:56 -0600
Message-ID: <dbabf9fb-7fd0-56e8-a52d-0eee8cf86566@gmail.com>
In-Reply-To: CACsRnHUCQkB5e3SG9kNCEWuggdfkKX1zLLayTFK3594ehduvZA@mail.gmail.com

--===============2861840370198438749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 3/4/22 09:44, Michael Johnson wrote:
> Hi all,
> =

> I just hit a problem today where my iwd clients were getting
> permanently disconnected from a network after the AP changed it's
> frequency.

Can you elaborate?  Normally change in frequency is mostly transparent to u=
ser =

space.  We should get an event from the driver/kernel telling us that this =

happened, but overall it should not cause us to roam?

> The first time the client tries to FT roam to the changed AP it gets a

Why is the roam being triggered?  This seems to be missing from your log.

> result: 1 (authentication failed?). After that when it tries to
> reconnect to another BSS in the same network but this time gets a
> result: 2 (association failure?) and critically blacklists the BSS. It
> tries to connect to all available BSS and gets the same error until

Do you have an iwmon trace?

> there are none left. This leaves the client permanently disconnected.
> I'm guessing that changing the frequency wiped the auth from the AP
> which explains why the initial FT roam fails but I'm not sure what
> would be causing the subsequent failures.
> =

> Looking at `src/station.c:station_retry_with_status` would it make
> sense to clean whatever auth data we have for FT if the status is an
> AUTH failure?

It is being wiped out anyway since we're no longer associated when the FT f=
ails. =

  Subsequent connections are being done the 'slow' way.  We'd need to see i=
wmon =

traces to understand why these associations fail.

Regards,
-Denis
--===============2861840370198438749==--

