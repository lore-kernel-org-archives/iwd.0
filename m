Content-Type: multipart/mixed; boundary="===============8208249000636237622=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sae: remove unneeded NULL pointer check
Date: Mon, 21 Oct 2019 17:15:07 -0500
Message-ID: <6c34c98c-f4af-9928-e3de-e62ca733c851@gmail.com>
In-Reply-To: <20191021220250.12908-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8208249000636237622==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/21/19 5:02 PM, James Prestwood wrote:
> The frame was already validated, and mmpdu_body will never return
> a NULL pointer.
> ---
>   src/sae.c | 5 -----
>   1 file changed, 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============8208249000636237622==--

