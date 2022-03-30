Content-Type: multipart/mixed; boundary="===============7238282680241092089=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/4] p2p: Fix Device Address updates from Probe Requests
Date: Wed, 30 Mar 2022 14:44:10 -0500
Message-ID: <9ffda1df-4a3a-c322-b594-fd14e499f94c@gmail.com>
In-Reply-To: 20220330173400.259961-1-andrew.zaborowski@intel.com

--===============7238282680241092089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 3/30/22 12:33, Andrew Zaborowski wrote:
> p2p_peer_update_existing may be called with a scan_bss struct built from
> a Probe Request frame so it can't access bss->p2p_probe_resp_info even
> if peer->bss was built from a Probe Response.  Check the source frame
> type of the scan_bss struct before updating the Device Address.
> =

> This fixes one timing issue that would make the autotest fail often.
> ---
>   src/p2p.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============7238282680241092089==--

