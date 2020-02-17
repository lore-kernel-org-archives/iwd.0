Content-Type: multipart/mixed; boundary="===============5511237387649918372=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/6] frame-xchg: Try to call a handler only once per frame
Date: Mon, 17 Feb 2020 12:34:47 -0600
Message-ID: <4b0f5559-1d42-02ba-fd5b-7689d23484b2@gmail.com>
In-Reply-To: <20200215001748.20819-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5511237387649918372==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/14/20 6:17 PM, Andrew Zaborowski wrote:
> Try to better deduplicate the frame watches.  Until now we'd check if
> we'd already registered a given frame body prefix with the kernel, or a
> matching more general prefix (shorter).  Now also try to check if we
> have already have a watch with the same callback pointer and user_data
> value, and:
> =

>   * an identical or shorter (more general) prefix, in that case ignore
>     the new watch completely.
> =

>   * a longer (more specific) prefix, in that case forget the existing
>     watch.
> =

> The use case for this is when we have a single callback for multiple
> watches and multiple frame types, and inside that callback we're looking
> at the frame body again and matching it to frame types.  In that case
> we don't want that function to be called multiple times for one frame
> event.
> ---
>   src/frame-xchg.c | 70 +++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 64 insertions(+), 6 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============5511237387649918372==--

