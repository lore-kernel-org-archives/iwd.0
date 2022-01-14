Content-Type: multipart/mixed; boundary="===============4882890728428596344=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [Feature discussion] Allow overriding of network-specific options
 globally
Date: Fri, 14 Jan 2022 12:55:52 -0600
Message-ID: <a1de824d-e923-11d4-96c7-bba662c70843@gmail.com>
In-Reply-To: CAGTBY+s4jDG-34n83r=x32S5EwSFFR-vdfnExX2vyLw4BQKkgw@mail.gmail.com

--===============4882890728428596344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rhys,

On 1/14/22 04:14, Rhys Perry wrote:
> `Hi,
> =

> I use IWD as the network manager on my laptop, also utilising it's
> inbuilt DHCP client. One of the things that gets on my nerves about
> this is that there is no way to override the DNS server globally, only
> per-network. This becomes rather annoying on a device like a laptop,
> where I am regularly connecting to new networks.
> =


Sure, I can see how this would be useful.

> I am proposing the ability to override network specific options (ones
> documented in `iwd.network`) globally. This would be implemented by

I suspect only a subset of these options would make sense to be global.  DN=
S =

would be one of them.

> having another configuration file (something like
> `/etc/iwd/network-overrides.conf`), where any network-specific options
> can be set, but globally. Of course, it is still useful to be able to
> set per-network options, so any options in the per-network configs
> (`/var/lib/iwd/*`) should take precedence over the global options.

I'm not sure that adding yet another config file is worthwhile.  We already=
 have =

some network configuration related options in main.conf.  MulticastDNS for =

example.  So I'd start by adding global DNS preference settings there first.

Regards,
-Denis
--===============4882890728428596344==--

