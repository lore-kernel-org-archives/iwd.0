Content-Type: multipart/mixed; boundary="===============7954869348789319548=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3] ft: set OCVC false for FT-over-DS
Date: Tue, 28 Sep 2021 11:52:14 -0500
Message-ID: <966a4069-fa56-30f5-6a4b-e227935cf01c@gmail.com>
In-Reply-To: 20210928164553.2856733-1-prestwoj@gmail.com

--===============7954869348789319548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/28/21 11:45 AM, James Prestwood wrote:
> FT-over-DS cannot use OCV due to how the kernel works. This means
> we could connect initially with OCVC set, but a FT-over-DS attempt
> needs to unset OCVC. Set OCVC false when rebuilding the RSNE for
> reassociation.
> ---
>   src/ft.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============7954869348789319548==--

