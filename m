Content-Type: multipart/mixed; boundary="===============5348840032806945813=="
MIME-Version: 1.0
From: Michael Johnson <mjohnson459@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Tue, 03 Aug 2021 17:07:00 +0100
Message-ID: <CACsRnHXJT_mrei=4LXFr_8nW4JeJFg+xBSpWaQED3PVrYZkpyw@mail.gmail.com>
In-Reply-To: <1ee52ba7-3c20-d73c-20e1-065595ae9e1c@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5348840032806945813==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Sorry I realise that I made an erroneous assumption about what
"correct" behavior is in this context.
My current use case for iwd is a linux-based robot that roams heavily.
In most cases we use Meraki access points.

When it comes to roaming, there are multiple issues I am seeing with
support for 802.11k and 802.11v that I expect
are caused by ambiguity in the standard but unfortunately I don't
personally have access to check. This specific issue
is the first time we send a neighbor report, the AP responds with a
correct response. However subsequent requests
either get a blank response or no response at all.

The Meraki support engineer blamed the lack of setting this flag using
these links as supporting evidence
" This mismatch is causing a few artifacts. The awkward or bad
behaviors will be highlighted in bold.

    The client device does not communicate it supports 802.11k
        **The device engages in 802.11k frames despite specified support**
    The Meraki AP does not categorize the client as 802.11k capable as
the client never stated it was capable
        **The Meraki AP still responds to the AP Neighborship Report
with incomplete information**
"
https://mrncciew.com/2014/09/11/cwsp-802-11k-ap-assisted-roaming/
https://www.cisco.com/c/en/us/td/docs/wireless/controller/8-1/Enterprise-Mo=
bility-8-1-Design-Guide/Enterprise_Mobility_8-1_Deployment_Guide/Chapter-11=
.html#Assisted_Roaming_with_802.11k

To be completely open, I did some packet captures both with and
without this patch and the Meraki behavior
was equally broken in both cases. In submitting this PR I assumed it
was either part of the standard or at least
a common extension and that it was therefore valuable regardless of
Meraki support. However if that is not the
case then maybe it shouldn't be merged. I was going by online
resources of varying quality that it was
"correct" and I'm no longer convinced it is.

Regards,
Michael

On Tue, 3 Aug 2021 at 16:18, Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Michael,
>
> On 8/3/21 9:19 AM, Michael Johnson wrote:
> > As we send a neighbor report request after joining a network we should
> > be setting the flag in the radio measurement capabilities.
> >
> > This is required by some Meraki access points.
>
> Ugh, I'm not sure Meraki is doing the right thing here...?
>
> 802.11-2020:
>
> "A STA sets the Neighbor Report Capability Enabled field to 1 when
> dot11RMNeighborReportActivated is true and sets it to 0 otherwise."
>
> 11.10.10.1:
> "An AP in which dot11RMNeighborReportActivated is false shall not transmi=
t a
> Fine Timing Measurement Range request. An AP in which
> dot11RMNeighborReportActivated is false should not ..."
>
> 11.10.10.3:
> "If dot11RMNeighborReportActivated is true, an AP receiving a neighbor re=
port
> request shall respond with a Neighbor Report Response frame containing ze=
ro or
> more Neighbor Report elements."
>
> "If dot11RMNeighborReportActivated is false in an AP receiving a neighbor=
 report
> request, it shall ignore the request."
>
> There are no other mentions of this config value in non-AP context.
>
> How does Meraki behave if this capability isn't set?  Likely we can safel=
y set
> this, but I'd want a comment explaining why this was done.
>
> > ---
> >   src/wiphy.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> >
>
> Regards,
> -Denis
--===============5348840032806945813==--

