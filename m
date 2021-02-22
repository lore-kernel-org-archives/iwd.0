Content-Type: multipart/mixed; boundary="===============5296952688605077982=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: quick connect path may never update the frequency cache
Date: Mon, 22 Feb 2021 14:17:08 -0600
Message-ID: <97f06d73-6462-c52e-e812-27432bd89f50@gmail.com>
In-Reply-To: <20210222195757.2871.25651@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5296952688605077982==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jolan,

On 2/22/21 1:57 PM, iwd(a)jolan.org wrote:
> Hi,
> =

> I was deploying some new access points and reconfigured all the 5GHz chan=
nels on the old access points to spread out the spectrum usage.  When I res=
tarted my iwd-using computers, I noticed they all came up on 2.4GHz instead=
 of 5GHz. I quickly realized that this is because the quick path is reducin=
g the scan to only the known frequencies in the cache.  I left iwd running =
and figured it would eventually find the old APs on their new frequencies b=
ut it never did.  Looking through the code, I see why this is.  The quick c=
onnect/roam path will only do a full scan if it can't connect at all, so it=
 will happily stay associated at lower bandwidth indefinitely.

Yes, you're correct.  iwd tries pretty hard not to scan, unless asked to, s=
o we =

can certainly end up in the situation you describe.  However, there are sev=
eral =

paths out of this condition which normally happen:

- A user requests a full scan via D-Bus, which should update the cache.
- A failed roam or quick scan that fails to find any candidates will trigge=
r a =

full frequency scan
- If Neighbor Reports are supported, then any neighbor frequencies will als=
o get =

added.  iwd will ask for a neighbor report shortly after connecting.  APs c=
an =

also send these unsolicited.
- If band steering is supported on the AP, AP can ask iwd to move to anothe=
r =

channel.

> =

> I can think of some other situations where this behavior may not be desir=
ed:
> =

> - AP is using a DFS channel, AP detects radar and falls over to a non-DFS=
 channel
> - a new frequency is deployed (Wi-FI 6E)
> =

> I tried to find a quick, easy way to forcibly full scan and cache but the=
re really wasn't good place to do so except on start up so I've resorted to=
 deleting the cache on boot-up until I've finalized WLAN configuration.

Somewhat of a large hammer, but fair enough.

> =

> I haven't been following iwd development much until now so maybe this has=
 already been discussed. Perhaps the cache needs to be a little less naive =
and take other factors into account like cache creation time, the BSS/frequ=
ency of the last connection, or perhaps all BSS/frequencies so a quick scan=
 result could be checked to see how complete it is compared to the fully ca=
ched BSS/frequency list and fall back to a full scan if the current network=
 topology varies greatly from the cached result.
> =


Agreed.  I definitely think there's room for improvement here.  The devil i=
s in =

the details though, so concrete proposals / ideas are definitely welcome.

Do note that running a full scan would defeat the purpose of getting connec=
ted =

quickly, which is what quick_scan state does.  We value getting connected f=
aster =

over picking the 'optimal' bss in hopes that the network will steer us to t=
he =

right AP if iwd's initial choice is wrong.  Admittedly, many networks aren'=
t =

that smart yet.

One thing we could explore is to be more aggressive in roaming if new BSSes=
 in =

the ESS are detected.  Right now we are conservative and only do this if th=
e =

signal is getting low.

> Thank you for your work on iwd and your time/consideration,
> =


Regards,
-Denis
--===============5296952688605077982==--

