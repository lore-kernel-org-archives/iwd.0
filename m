Content-Type: multipart/mixed; boundary="===============4010585502487372174=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] eapol: zero entire buffer when creating frame
Date: Mon, 28 Mar 2022 17:35:45 -0500
Message-ID: <78e2db51-562d-5fc4-6cb9-21b4968cc268@gmail.com>
In-Reply-To: 20220328223256.1683289-1-prestwoj@gmail.com

--===============4010585502487372174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/28/22 17:32, James Prestwood wrote:
> Since l_malloc is used the frame contents are not zero'ed automatically
> which could result in random bytes being present in the frame which were
> expected to be zero. This poses a problem when calculating the MIC as the
> crypto operations are done on the entire frame with the expectation of
> the MIC being zero.
> ---
>   src/eapol.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4010585502487372174==--

