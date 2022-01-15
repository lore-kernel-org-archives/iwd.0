Content-Type: multipart/mixed; boundary="===============5485341162443412955=="
MIME-Version: 1.0
From: Rhys Perry <rhysperry111 at gmail.com>
To: iwd at lists.01.org
Subject: Re: [Feature discussion] Allow overriding of network-specific options
 globally
Date: Sat, 15 Jan 2022 16:24:19 +0000
Message-ID: <CAGTBY+ucQ_kWfzxrZaaeL233-Xp28Cq9Kyor_Y+NeCNbGqDqcA@mail.gmail.com>
In-Reply-To: a1de824d-e923-11d4-96c7-bba662c70843@gmail.com

--===============5485341162443412955==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Jan 2022 at 18:55, Denis Kenzior <denkenz(a)gmail.com> wrote:
> > I am proposing the ability to override network specific options (ones
> > documented in `iwd.network`) globally. This would be implemented by
>
> I suspect only a subset of these options would make sense to be global.  =
DNS
> would be one of them.

Yeah, that's fair. I kinda thought that'd be the case, but wasn't sure
what the people over here's thoughts would be

> I'm not sure that adding yet another config file is worthwhile.  We alrea=
dy have
> some network configuration related options in main.conf.  MulticastDNS for
> example.  So I'd start by adding global DNS preference settings there fir=
st.

Right- My programming skills aren't the best, but I'll give it a go
:). Where do you think the DNS option should go in the main config
file? Something like `DNSv4` and `DNSv6` in the `Network` section, or
should the `IPv4` and `IPv6` sections be added, each with their own
respective `DNS` entries?

Also, apologies to Denis for accidentally doing a reply instead of a
reply-all initially, I don't participate in mailing lists that often.

Rhys
--===============5485341162443412955==--

