Content-Type: multipart/mixed; boundary="===============6626941799772283281=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Thu, 30 Sep 2021 00:05:37 +0200
Message-ID: <CAOq732KHRh4HvDnGaKXqe4SPH=K=Hju=GJ-i9OJwap=jXQcKGA@mail.gmail.com>
In-Reply-To: a85148df-d206-87d6-a3dd-9105ecc013ee@gmail.com

--===============6626941799772283281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Wed, 29 Sept 2021 at 22:06, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 9/29/21 11:42 AM, Andrew Zaborowski wrote:
> > Move the netconfig_reset calls to inside
> > station_reset_connection_state() instead of having each caller do
>
> This is on purpose.  There should be no need to call netconfig_reset if
> netconfig_configure wasn't called in the first place.

In this case it *was* called, then for some reason the driver
deauthenticated when we requested a scan (from_ap is false), netdev
emitted a NETDEV_EVENT_DISCONNECT_BY_SME and we end up in
station_connect_cb.  You're right in that station_connect_cb also
handles failures before the netconfig_configure call, so if you want
to avoid the potentially unneeded netconfig_reset() I can move it
inside station_disconnect_event to avoid bigger changes.

Best regards
--===============6626941799772283281==--

