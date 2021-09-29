Content-Type: multipart/mixed; boundary="===============6210061429054736581=="
MIME-Version: 1.0
From: Andrew Zaborowski <andrew.zaborowski at intel.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: Move netconfig_reset() to common path
Date: Thu, 30 Sep 2021 00:20:16 +0200
Message-ID: <CAOq732L75EHicj1NQQuE_6YLUTcFHP7vo1u0RNXLPBrOKR2W+g@mail.gmail.com>
In-Reply-To: 2e596fd9-c849-e3b2-f296-6fffadef29af@gmail.com

--===============6210061429054736581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Sept 2021 at 00:12, Denis Kenzior <denkenz(a)gmail.com> wrote:
> On 9/29/21 5:05 PM, Andrew Zaborowski wrote:
> > On Wed, 29 Sept 2021 at 22:06, Denis Kenzior <denkenz(a)gmail.com> wrot=
e:
> >> On 9/29/21 11:42 AM, Andrew Zaborowski wrote:
> >>> Move the netconfig_reset calls to inside
> >>> station_reset_connection_state() instead of having each caller do
> >>
> >> This is on purpose.  There should be no need to call netconfig_reset if
> >> netconfig_configure wasn't called in the first place.
> >
> > In this case it *was* called, then for some reason the driver
> > deauthenticated when we requested a scan (from_ap is false), netdev
>
> That would be useful info and should be in the commit description ;)
>
> > emitted a NETDEV_EVENT_DISCONNECT_BY_SME and we end up in
> > station_connect_cb.  You're right in that station_connect_cb also
>
> Then that sounds like a bug or another side-effect of delaying the CONNEC=
TED
> state until netconfig is done.    NETDEV_EVENT_DISCONNECT_BY_SME should r=
esult
> in station_disassociated() and not station_connect_cb()

I don't remember what the reasoning was, but station_connect_cb does
handle some mechanisms that seem desirable here also, like trying the
next bss from the autoconnect list immediately and blacklisting BSSes.
In this case it seems the problem was triggered by a driver problem
(or our misunderstanding on when the radio is free for scanning) but
if a specific BSS always fails during netconfig then we should
blacklist it.

Best regards
--===============6210061429054736581==--

