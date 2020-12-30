Content-Type: multipart/mixed; boundary="===============3453719128408181857=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] doc: move EnableIPv6 under Network
Date: Wed, 30 Dec 2020 11:35:50 -0600
Message-ID: <2bcc7986-92ab-752a-9e5c-0e698ed44e9d@gmail.com>
In-Reply-To: <20201227133425.2894.28091@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3453719128408181857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/27/20 7:34 AM, flokli(a)flokli.de wrote:
> Last time I checked, IPv6 RA weren't supported yet. Is this still the cas=
e? Also, why does it default to `false`?

Correct, IPV6 RAs are not yet supported.  And this is  the reason why IPV6 =
is =

disabled by default.

In iwd versions prior to 1.10 you could let iwd setup IPv4 aspects (using =

DHCPv4) and let the kernel handle RAs.  But, really, such a setup was broke=
n =

because:
   - kernel didn't know anything about route metrics to be used by iwd
   - details obtained from RAs, like DNS, host names, etc were not configur=
ed
   - Stateful (DHCPv6) configurations didn't work

Certain setups may have appeared to work, but it was just pure luck.  Given=
 the =

above, and the fact that iwd's IPv6 support is not yet complete, the safest =

option was to disable it by default.

Regards,
-Denis
--===============3453719128408181857==--

