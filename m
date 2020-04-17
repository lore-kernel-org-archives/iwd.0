Content-Type: multipart/mixed; boundary="===============4243619447633473858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 07/17] p2p: Add the Scan Phase
Date: Fri, 17 Apr 2020 12:27:16 -0500
Message-ID: <87505399-a76e-284e-fff6-e74eab717750@gmail.com>
In-Reply-To: <20200403161430.14168-7-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4243619447633473858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/3/20 11:14 AM, Andrew Zaborowski wrote:
> Add some of the Device Discovery logic and the DBus API.  Device
> Discovery is documented as having three states: the Scan Phase, the Find
> Phase and the Listen State.
> =

> This patch adds the Scan Phase and the next patch adds the Listen State,
> which will happen sequentially in a loop until discovery is stopped.
> =

> The Find Phase, which is documented as happening at the beginning of the
> Discovery Phase, is incorporated into the Scan Phases.  The difference
> between the two is that Find Phase scans all of the supported channels
> while the Scan Phase only scans the three "social" channels.  In
> practical terms the Find Phase would discover existing groups, which may
> operate on any channel, while the Scan Phase will only discover P2P
> Devices -- peers that are not in a group yet.  To cover existing groups,
> we add a few "non-social" channels to each of our active scans
> implementing the Scan Phases.
> ---
>   src/p2p.c | 460 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 460 insertions(+)

LGTM.

Regards,
-Denis

--===============4243619447633473858==--

