Content-Type: multipart/mixed; boundary="===============6996813797135043461=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/10] station: Don't call network_rank_update with NULL
 network
Date: Mon, 17 Aug 2020 10:12:57 -0500
Message-ID: <7e281671-a6d6-f7bf-f0c5-fab8e6fa92c2@gmail.com>
In-Reply-To: <20200817100647.338184-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6996813797135043461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/17/20 5:06 AM, Andrew Zaborowski wrote:
> Move the update of station->networks_sorted order to before we set
> station->connected_network NULL to avoid a crash when we attempt to
> use the NULL pointer.
> ---
>   src/station.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Patches 1-9 applied, thanks.

Regards,
-Denis

--===============6996813797135043461==--

