Content-Type: multipart/mixed; boundary="===============5015530841534207391=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] wiphy: set neighbor report capability flag
Date: Tue, 03 Aug 2021 10:02:02 -0500
Message-ID: <1ee52ba7-3c20-d73c-20e1-065595ae9e1c@gmail.com>
In-Reply-To: <20210803141907.33819-1-mjohnson459@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5015530841534207391==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On 8/3/21 9:19 AM, Michael Johnson wrote:
> As we send a neighbor report request after joining a network we should
> be setting the flag in the radio measurement capabilities.
> =

> This is required by some Meraki access points.

Ugh, I'm not sure Meraki is doing the right thing here...?

802.11-2020:

"A STA sets the Neighbor Report Capability Enabled field to 1 when =

dot11RMNeighborReportActivated is true and sets it to 0 otherwise."

11.10.10.1:
"An AP in which dot11RMNeighborReportActivated is false shall not transmit =
a =

Fine Timing Measurement Range request. An AP in which =

dot11RMNeighborReportActivated is false should not ..."

11.10.10.3:
"If dot11RMNeighborReportActivated is true, an AP receiving a neighbor repo=
rt =

request shall respond with a Neighbor Report Response frame containing zero=
 or =

more Neighbor Report elements."

"If dot11RMNeighborReportActivated is false in an AP receiving a neighbor r=
eport =

request, it shall ignore the request."

There are no other mentions of this config value in non-AP context.

How does Meraki behave if this capability isn't set?  Likely we can safely =
set =

this, but I'd want a comment explaining why this was done.

> ---
>   src/wiphy.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> =


Regards,
-Denis
--===============5015530841534207391==--

