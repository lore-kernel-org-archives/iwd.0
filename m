Content-Type: multipart/mixed; boundary="===============1459357309590506636=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 1/7] ft: rework ft_parse_ies
Date: Fri, 30 Apr 2021 10:09:10 -0500
Message-ID: <876220f5-81bc-e220-a7f0-34f1d8e82078@gmail.com>
In-Reply-To: <20210429230841.222368-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1459357309590506636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/29/21 6:08 PM, James Prestwood wrote:
> This adds the RSNE verification to ft_parse_ies which will
> be common between over-Air and over-DS. The MDE check was
> also factored out into its own minimal function as to
> retain the spec comment but allow reuse elsewhere.
> ---
>   src/ft.c | 125 +++++++++++++++++++++++++++++--------------------------
>   1 file changed, 66 insertions(+), 59 deletions(-)
> =

> v4:
>   * Moved MDE check into its own function to avoid duplicate
>     comments
> =


I took the first 4 patches from this series.

Regards,
-Denis
--===============1459357309590506636==--

