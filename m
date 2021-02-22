Content-Type: multipart/mixed; boundary="===============8568065513087639465=="
MIME-Version: 1.0
From: iwd@jolan.org
Subject: quick connect path may never update the frequency cache
Date: Mon, 22 Feb 2021 19:57:57 +0000
Message-ID: <20210222195757.2871.25651@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8568065513087639465==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I was deploying some new access points and reconfigured all the 5GHz channe=
ls on the old access points to spread out the spectrum usage.  When I resta=
rted my iwd-using computers, I noticed they all came up on 2.4GHz instead o=
f 5GHz. I quickly realized that this is because the quick path is reducing =
the scan to only the known frequencies in the cache.  I left iwd running an=
d figured it would eventually find the old APs on their new frequencies but=
 it never did.  Looking through the code, I see why this is.  The quick con=
nect/roam path will only do a full scan if it can't connect at all, so it w=
ill happily stay associated at lower bandwidth indefinitely.

I can think of some other situations where this behavior may not be desired:

- AP is using a DFS channel, AP detects radar and falls over to a non-DFS c=
hannel
- a new frequency is deployed (Wi-FI 6E)

I tried to find a quick, easy way to forcibly full scan and cache but there=
 really wasn't good place to do so except on start up so I've resorted to d=
eleting the cache on boot-up until I've finalized WLAN configuration.

I haven't been following iwd development much until now so maybe this has a=
lready been discussed. Perhaps the cache needs to be a little less naive an=
d take other factors into account like cache creation time, the BSS/frequen=
cy of the last connection, or perhaps all BSS/frequencies so a quick scan r=
esult could be checked to see how complete it is compared to the fully cach=
ed BSS/frequency list and fall back to a full scan if the current network t=
opology varies greatly from the cached result.

Thank you for your work on iwd and your time/consideration,

- Jolan
--===============8568065513087639465==--

