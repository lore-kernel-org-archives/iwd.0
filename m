Content-Type: multipart/mixed; boundary="===============8299497099526919445=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Tue, 03 Aug 2021 11:19:08 -0500
Message-ID: <39c22b3d-8ac1-62ee-0e10-28b483681ae4@gmail.com>
In-Reply-To: <CACsRnHXJT_mrei=4LXFr_8nW4JeJFg+xBSpWaQED3PVrYZkpyw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8299497099526919445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/3/21 11:07 AM, Michael Johnson wrote:
> Hi Denis,
> =

> Sorry I realise that I made an erroneous assumption about what
> "correct" behavior is in this context.
> My current use case for iwd is a linux-based robot that roams heavily.
> In most cases we use Meraki access points.
> =


Very cool :)

> When it comes to roaming, there are multiple issues I am seeing with
> support for 802.11k and 802.11v that I expect
> are caused by ambiguity in the standard but unfortunately I don't
> personally have access to check. This specific issue
> is the first time we send a neighbor report, the AP responds with a
> correct response. However subsequent requests
> either get a blank response or no response at all.
> =


Hmm, I wonder if we have a different bug here.  This gives me a few ideas t=
o =

look into, let me poke around and I'll get back to you.

What other problems are you having?

> The Meraki support engineer blamed the lack of setting this flag using
> these links as supporting evidence
> " This mismatch is causing a few artifacts. The awkward or bad
> behaviors will be highlighted in bold.
> =

>      The client device does not communicate it supports 802.11k
>          **The device engages in 802.11k frames despite specified support=
**
>      The Meraki AP does not categorize the client as 802.11k capable as
> the client never stated it was capable
>          **The Meraki AP still responds to the AP Neighborship Report
> with incomplete information**
> "
> https://mrncciew.com/2014/09/11/cwsp-802-11k-ap-assisted-roaming/

This link shows an Association Request with 'neighbor report' capability ze=
ro-d =

out.  See 'Frame 41'

> https://www.cisco.com/c/en/us/td/docs/wireless/controller/8-1/Enterprise-=
Mobility-8-1-Design-Guide/Enterprise_Mobility_8-1_Deployment_Guide/Chapter-=
11.html#Assisted_Roaming_with_802.11k

This link says:
"The presence of all three of these IEs signifies that this SSID is configu=
red =

to provide a neighbor list on request. For this release we send neighbor li=
st =

based on the request from the client and not on the neighbor list capabilit=
y of =

the client in the IE. "

I have seen traces where other devices set this bit in the Association Requ=
est =

(From memory, so may be incorrect: Apple and a Samsung Android device), but=
 the =

spec is really fuzzy here.  And I don't see how Meraki could interpret the =
spec =

in a way that makes this a required capability bit on the client.

> =

> To be completely open, I did some packet captures both with and
> without this patch and the Meraki behavior
> was equally broken in both cases. In submitting this PR I assumed it
> was either part of the standard or at least
> a common extension and that it was therefore valuable regardless of
> Meraki support. However if that is not the
> case then maybe it shouldn't be merged. I was going by online
> resources of varying quality that it was
> "correct" and I'm no longer convinced it is.

It could be that Meraki really does want this, but I suspect something else=
 is =

the real culprit.  Lets get to the bottom of this.

> =

> Regards,
> Michael

Regards,
-Denis
--===============8299497099526919445==--

