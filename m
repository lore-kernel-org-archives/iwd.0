Content-Type: multipart/mixed; boundary="===============3355023303111926879=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Failing to resolve after roams
Date: Thu, 12 Aug 2021 09:40:54 -0500
Message-ID: <d8ffff0a-17c8-9edd-7064-be62af96317b@gmail.com>
In-Reply-To: <CACsRnHXdDCfnRVgJ4UiWKqTmoEDcFfCPzkFN6v4rrRR9GX29Hg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3355023303111926879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/12/21 9:30 AM, Michael Johnson wrote:
> Hi Denis,
> =

> `systemd-networkd` isn't managing the wireless interface but still
> needs to run for wired connections (or at least shouldn't be). I'm not

Okay.  Not sure we tested such a setup here...

> sure why it still prints connected/disconnect states. How does `iwd`
> interact with `systemd-resolved`?

iwd uses systemd-resolved dbus API to set up certain information obtained f=
rom =

DHCP (DNS, hostname, etc).  See [1].

You can poke around in src/resolve.c in iwd tree for more details.  Right n=
ow =

iwd assumes that no IP configuration details change on a roam (which is wha=
t =

802.11 says).  There may be networks where this assumption breaks, but we =

haven't seen any yet.  So at the moment, the resolved settings are left =

untouched between roams.

It might help to spy on the resolved dbus interface using dbus-monitor and =
see =

if we can learn something useful from that.

[1] https://www.freedesktop.org/software/systemd/man/org.freedesktop.resolv=
e1.html
--===============3355023303111926879==--

