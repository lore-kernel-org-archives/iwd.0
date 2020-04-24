Content-Type: multipart/mixed; boundary="===============6659167928639070788=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/19] p2p: Add the Scan Phase
Date: Fri, 24 Apr 2020 11:55:50 -0500
Message-ID: <d884c9d9-3ea9-521b-4903-b148b1ae02b0@gmail.com>
In-Reply-To: <20200423162447.15750-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6659167928639070788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/23/20 11:24 AM, Andrew Zaborowski wrote:
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
>   src/p2p.c | 464 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 464 insertions(+)

Applied, thanks.

Regards,
-Denis

--===============6659167928639070788==--

