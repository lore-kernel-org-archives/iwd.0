Content-Type: multipart/mixed; boundary="===============5157326636901336369=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] offchannel: introduce new offchannel module
Date: Tue, 30 Nov 2021 09:51:46 -0800
Message-ID: <9a2d4cf8c927d8a0e241d28a549973c0a1691fc7.camel@gmail.com>
In-Reply-To: bea60ca3-b6bb-5b6d-c06a-63a35111745a@molgen.mpg.de

--===============5157326636901336369==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Tue, 2021-11-30 at 08:29 +0100, Paul Menzel wrote:
> Dear James,
> =

> =

> Am 30.11.21 um 00:16 schrieb James Prestwood:
> > ---
> > =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> > =C2=A0 src/offchannel.c | 338
> > +++++++++++++++++++++++++++++++++++++++++++++++
> > =C2=A0 src/offchannel.h |=C2=A0 29 ++++
> > =C2=A0 3 files changed, 368 insertions(+)
> > =C2=A0 create mode 100644 src/offchannel.c
> > =C2=A0 create mode 100644 src/offchannel.h
> =

> [=E2=80=A6]
> =

> Excuse my ignorance, but what does the module do? Is there some =

> documentation?

Its basically a wrapper around NL80211_CMD_[CANCEL_]REMAIN_ON_CHANNEL.
i.e. telling the driver to go onto a frequency/channel for some
duration.

No docs since its not something part of a public API, but as far as the
two APIs they are very simple. Go offchannel for some duration, and a
way to cancel it.

I can put some details in the commit description for next versions.

Thanks,
James

> =

> =

> Kind regard,
> =

> Paul


--===============5157326636901336369==--

