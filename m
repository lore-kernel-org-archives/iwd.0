Content-Type: multipart/mixed; boundary="===============3373428843067347934=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/6] dpp: add timeout for auth/config protocols
Date: Mon, 20 Dec 2021 18:16:15 -0600
Message-ID: <3cee42e8-412e-5fd4-063a-c373b614591e@gmail.com>
In-Reply-To: 20211221000747.56696-1-prestwoj@gmail.com

--===============3373428843067347934==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/20/21 18:07, James Prestwood wrote:
> This also allows the card to re-issue ROC if it ends in the middle of
> authenticating or configuring as well as add a maximum timeout for
> auth/config protocols.
> =

> IO errors were also handled as these sometimes can happen with
> certain drivers but are not fatal.
> ---
>   src/dpp.c | 48 ++++++++++++++++++++++++++++++++++++++----------
>   1 file changed, 38 insertions(+), 10 deletions(-)
> =

> v2:
>   * Moved timeout cleanup into this patch
> =


All applied, thanks.

Regards,
-Denis

--===============3373428843067347934==--

