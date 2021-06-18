Content-Type: multipart/mixed; boundary="===============6270795996005157328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] station: Stop periodic scan when netdev connected
Date: Fri, 18 Jun 2021 10:05:36 -0500
Message-ID: <3334d49c-c269-c398-9cf7-4a4a6ca903bd@gmail.com>
In-Reply-To: <20210618073324.67095-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6270795996005157328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 6/18/21 2:33 AM, Andrew Zaborowski wrote:
> For consistency call periodic_scan_stop() right after netdev signals
> connected even if station stays in the CONNECTING state because it's
> waiting for netconfig to finish.

Hmm, why is this needed?  We should be calling periodic_scan_stop as soon a=
s we =

transition to CONNECTING/CONNECTING_AUTO state.  In fact, even the =

periodic_scan_stop on transition to CONNECTED seems suspicious now.

Might be helpful to include an actual log of the issue you're fixing in the =

commit description?

> ---
>   src/station.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Regards,
-Denis
--===============6270795996005157328==--

