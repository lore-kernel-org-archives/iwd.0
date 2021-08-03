Content-Type: multipart/mixed; boundary="===============4372640132380733723=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/3] station: network: rework ERP/FILS code path
Date: Tue, 03 Aug 2021 16:36:34 -0500
Message-ID: <32423aeb-6b09-26ec-2cb5-92072ca1192e@gmail.com>
In-Reply-To: <20210803214045.153011-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4372640132380733723==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/3/21 4:40 PM, James Prestwood wrote:
> This refactors some code to eliminate getting the ERP entry twice
> by simply returning it from network_has_erp_identity (now renamed
> to network_get_erp_cache). In addition this code was moved into
> station_build_handshake_rsn and properly cleaned up in case there
> was an error or if a FILS AKM was not chosen.
> ---
>   src/network.c | 16 +++++++++-------
>   src/network.h |  3 ++-
>   src/station.c | 33 +++++++++++++++++++--------------
>   3 files changed, 30 insertions(+), 22 deletions(-)
> =

> v4:
>   * Called erp_cache_put if cache entry needs to be removed
> =


Ok, all applied and I fixed up the linker-errors that resulted from these c=
hanges.

Regards,
-Denis

--===============4372640132380733723==--

