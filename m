Content-Type: multipart/mixed; boundary="===============0076688376553970194=="
MIME-Version: 1.0
From: Jesus Gonzalez <jesusmgh@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Sun, 29 Aug 2021 15:06:26 +0000
Message-ID: <20210829150626.2787.36933@ml01.vlan13.01.org>
In-Reply-To: <25c80bed-e1f6-6e18-2516-779f0750cbc7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0076688376553970194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> This is the correct place.

Thank you!

> So I take it iwd 1.15 worked fine?  We've had a similar report just a few=
 days =

> ago with Google Nest APs.  With iwd 1.16 we started negotiating a higher =
level =

> of key encryption size by default for SAE, and that exposed some issues i=
n the =

> protocol implementation of those APs.  This might be what is happening in=
 your =

> case as well.

Indeed, 1.15 works perfectly fine. I tried running the latest git version b=
ecause of the SAE patches, but it showed the same behaviour.

> Can you tell us what version of hostapd your OpenWRT router is running?  =
hostapd =

> releases are not very frequent, so a build date or commit date would be i=
deal, =

> or any info which can help us determine that.

I run a very recent build from master, the versions are:
- OpenWrt SNAPSHOT r17443-90e167abaa
- hostapd v2.10-devel (2021-05-22-b102f19b-35)

So hostapd is not the latest git head, but also not that far behind, and at=
 a (quick and far from expert) glance most SAE activity doesn't seem relate=
d.

> Also, have you tried upgrading the AP firmware?

Already running latest firmware.

> Any chance you can run iwd standalone without NM and capture a trace for =
us?

Of course, here it is: https://pastebin.com/nJfpYcFA
I'll try with -d ASAP, quite busy ATM.

Thank you!

Best regards,
Jesus
--===============0076688376553970194==--

