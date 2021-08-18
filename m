Content-Type: multipart/mixed; boundary="===============0112924036592244315=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/4] network: handle NULL/hotspot networks when
 removing secrets
Date: Wed, 18 Aug 2021 16:58:50 -0500
Message-ID: <2a01feed-cfc8-e461-4597-107b32704fd4@gmail.com>
In-Reply-To: <20210818215028.294978-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0112924036592244315==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/18/21 4:50 PM, James Prestwood wrote:
> The hotspot case can actually result in network being NULL which
> ends up crashing when accessing "->secrets". In addition any
> secrets on this network were never removed for hotspot networks
> since everything happened in network_unset_hotspot.
> ---
>   src/network.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> =


All applied, thanks.

Regards,
-Denis
--===============0112924036592244315==--

