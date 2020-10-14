Content-Type: multipart/mixed; boundary="===============2198681370733018163=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] station: Fix .Scanning being reset early
Date: Wed, 14 Oct 2020 13:02:31 -0500
Message-ID: <716808da-9944-084c-398d-c86479839afc@gmail.com>
In-Reply-To: <20201014123520.1245755-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2198681370733018163==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/14/20 7:35 AM, Andrew Zaborowski wrote:
> periodic_scan_stop is called whenever we exit the autoscan state but a
> periodic scan may not be running at the time.  If we have a
> user-triggered scan running, or the autoconnect_quick scan, and we reset
> Scanning to false before that scan finished, a client could en up
> calling GetOrderedNetwork too early and not receiving the scan results.
> ---
>   src/station.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2198681370733018163==--

