Content-Type: multipart/mixed; boundary="===============2163913303586877544=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] watchlist: Save the watchlist pointer in
 WATCHLIST_NOTIFY_*
Date: Fri, 01 May 2020 11:40:29 -0500
Message-ID: <a8cd3ad7-1868-2632-f329-0668136caa6d@gmail.com>
In-Reply-To: <20200430134847.62234-3-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2163913303586877544==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/30/20 8:48 AM, Andrew Zaborowski wrote:
> Save the value of the watchlist pointer at the beginning of the
> WATCHLIST_NOTIFY_* macros as if it was a function.  This will fix a
> frame-xchg.c scenario in which one of the watch callback removes the
> frame watch group and the memory where the watchlist pointer was
> becomes unallocated but the macro still needs to access it ones or
> twice while it destroys the watchlist.  Another option would be for
> the pointer to be copied in frame-xchg.c itself.
> ---
>   src/watchlist.h | 45 ++++++++++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 21 deletions(-)
> =


Patch 3 & 4 applied, thanks.

Regards,
-Denis

--===============2163913303586877544==--

