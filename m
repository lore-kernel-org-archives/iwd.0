Content-Type: multipart/mixed; boundary="===============2284816584336974253=="
MIME-Version: 1.0
From: Rhys Perry <rhysperry111 at gmail.com>
To: iwd at lists.01.org
Subject: [Feature discussion] Allow overriding of network-specific options
 globally
Date: Fri, 14 Jan 2022 10:14:18 +0000
Message-ID: <CAGTBY+s4jDG-34n83r=x32S5EwSFFR-vdfnExX2vyLw4BQKkgw@mail.gmail.com>
In-Reply-To: CAGTBY+tVZixBJ3kpPBEYqETYt_-qwkTK4t8CYiu7tVENo9EL1w@mail.gmail.com

--===============2284816584336974253==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

`Hi,

I use IWD as the network manager on my laptop, also utilising it's
inbuilt DHCP client. One of the things that gets on my nerves about
this is that there is no way to override the DNS server globally, only
per-network. This becomes rather annoying on a device like a laptop,
where I am regularly connecting to new networks.

I am proposing the ability to override network specific options (ones
documented in `iwd.network`) globally. This would be implemented by
having another configuration file (something like
`/etc/iwd/network-overrides.conf`), where any network-specific options
can be set, but globally. Of course, it is still useful to be able to
set per-network options, so any options in the per-network configs
(`/var/lib/iwd/*`) should take precedence over the global options.

What do you think of this proposal? Admittedly, I am not familiar with
how IWD parses configs, nor the codebase in general, and my
programming skills do have a lot to be desired, so maybe I am
overlooking something.

Rhys Perry
--===============2284816584336974253==--

