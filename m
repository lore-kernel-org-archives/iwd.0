Content-Type: multipart/mixed; boundary="===============6848325743794575048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Cannot connect to SAE protected AP with iwd 1.16 and beyond
Date: Fri, 27 Aug 2021 21:42:38 -0500
Message-ID: <25c80bed-e1f6-6e18-2516-779f0750cbc7@gmail.com>
In-Reply-To: <20210827080530.2802.3544@ml01.vlan13.01.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6848325743794575048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jesus,

On 8/27/21 3:05 AM, Jesus Gonzalez wrote:
> First of all: I looked around and found no dedicated bug tracker. if this=
 is not the place to report bugs, please excuse me, and I would be glad to =
be pointed in the correct direction. Thank you!

This is the correct place.

> =

> Starting with iwd 1.16 I am not able to connect to my home WLAN network. =
It is a WPA3 SAE protected access point running on a Netgear R7800 with Ope=
nWRT, in case it matters. Connecting to my WPA2 PSK AP on my phone as a tes=
t works just fine.

So I take it iwd 1.15 worked fine?  We've had a similar report just a few d=
ays =

ago with Google Nest APs.  With iwd 1.16 we started negotiating a higher le=
vel =

of key encryption size by default for SAE, and that exposed some issues in =
the =

protocol implementation of those APs.  This might be what is happening in y=
our =

case as well.

Can you tell us what version of hostapd your OpenWRT router is running?  ho=
stapd =

releases are not very frequent, so a build date or commit date would be ide=
al, =

or any info which can help us determine that.

Also, have you tried upgrading the AP firmware?

> =

> The connection log from the client: https://pastebin.com/48umPPzh
> =

> The only but decisive log entry in the AP: https://pastebin.com/W7JsH1kY
> =

> It seems after iwd 1.16 the client tries to associate before it is correc=
tly authenticated. Maybe a race condition, and iwd got too fast for the rou=
ter?

Any chance you can run iwd standalone without NM and capture a trace for us?

See https://iwd.wiki.kernel.org/debugging

Regards,
-Denis
--===============6848325743794575048==--

