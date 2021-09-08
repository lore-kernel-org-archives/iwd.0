Content-Type: multipart/mixed; boundary="===============7098040023341028188=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/7] sae: fix a spec violation with duplicate commits
Date: Wed, 08 Sep 2021 14:20:34 -0500
Message-ID: <cabd7c78-cc5d-6473-c291-cef383d7c31c@gmail.com>
In-Reply-To: <20210908181904.84594-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7098040023341028188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 1:18 PM, James Prestwood wrote:
> If a commit is received while in an accepted state the spec states
> the scalar should be checked against the previous commit and if
> equal the message should be silently dropped.
> ---
>   src/sae.c | 28 +++++++++++++++++++++++++---
>   1 file changed, 25 insertions(+), 3 deletions(-)
> =

> v2:
>   * Changed to check the scalar rather than always ignore.
> =


Applied, thanks.

Regards,
-Denis

--===============7098040023341028188==--

