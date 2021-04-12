Content-Type: multipart/mixed; boundary="===============1242288627309677022=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: remove rates requirement for fmac cards
Date: Mon, 12 Apr 2021 14:17:12 -0500
Message-ID: <1a3848d1-323e-9657-6012-a490d4b08e7d@gmail.com>
In-Reply-To: <20210412182245.1555350-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1242288627309677022==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/12/21 1:22 PM, James Prestwood wrote:
> It was seen that some full mac cards/drivers do not include any
> rate information with the NEW_STATION event. This was causing
> the NEW_STATION event to be ignored, preventing AP mode from
> working on these cards.
> =

> Since the full mac path does not even require sta->rates the
> parsing can be removed completely.
> ---
>   src/ap.c | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> =


Applied, thanks.

Salahaldeen, can you check whether this fixes your issue?

Regards,
-Denis

--===============1242288627309677022==--

