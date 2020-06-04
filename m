Content-Type: multipart/mixed; boundary="===============8368757227633459265=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] frame-xchg: fix bug when starting new xchg from callback
Date: Thu, 04 Jun 2020 09:43:25 -0500
Message-ID: <5641066d-0c0f-f9bf-ddcf-af7eac9d1020@gmail.com>
In-Reply-To: <20200601200340.12976-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8368757227633459265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/1/20 3:03 PM, James Prestwood wrote:
> This bug is caused by the following behavior:
> =

>   1. Start a frame-xchg, wait for callback
>   2. From callback start a new frame-xchg, same prefix.
> =

> The new frame-xchg request will detect that there is a duplicate watch,
> which is correct behavior. It will then remove this duplicate from the
> watchlist. The issue here is that we are in the watchlist notify loop
> from the original xchg. This causes that loop to read from the now
> freed watchlist item, causing an invalid read.
> =

> Instead of freeing the item immediately, check if the notify loop is in
> progress and only set 'id' to zero and 'stale_items' to true. This will
> allow the notify loop to finish, then the watchlist code will prune out
> any stale items. If not in the notify loop the item can be freed as it
> was before.
> ---
>   src/frame-xchg.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis
--===============8368757227633459265==--

