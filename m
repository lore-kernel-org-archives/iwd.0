Content-Type: multipart/mixed; boundary="===============1342166272157816872=="
MIME-Version: 1.0
From: carbonchauvinist@protonmail.ch
Subject: Re: Issue with iwd 1.3 + systemd-resolved + iwd's built-in network
 configuration not adding DNS servers
Date: Mon, 16 Dec 2019 21:37:15 +0000
Message-ID: <20191216213715.2770.68692@ml01.vlan13.01.org>
In-Reply-To: <20191216074839.2770.41114@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1342166272157816872==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I've run into this issue as well with 1.3. I'm using iwd + systemd-resolved=
 (using iwd to manage the network, i.e. no systemd-networkd at play here).

From what I can tell it's due to the fact that commit 930528e35 appends dom=
ain names as routing-only domains (i.e. prepends with "~"). I have "lan" as=
 the domain value in my router and this is in turn added as "~lan" when vie=
wing the output with resolvectl status. This changes the way  systemd-resol=
ved sets the "DefaultRoute" value and causes it to be false instead of true.

Currently I can either manually, and non-permanently, set the DefaultRoute =
to true on the link in order to get name resolution (i.e.: `# resolvectl de=
fault-route wlan0 1`) or I can remove the domain designation from my router=
/dhcp server.

I wonder if the goal was to add the domains as routing-only domains instead=
 of search-domains? (https://www.freedesktop.org/software/systemd/man/syste=
md.network.html#Domains=3D)

Because I'm not using systemd-networkd I don't know/see a way to override t=
he DefaultRoute value permanently, though I obviously could be missing some=
thing.
--===============1342166272157816872==--

