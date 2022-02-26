Content-Type: multipart/mixed; boundary="===============4322262989380709583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 1/7] ie: update IE_AKM_IS_SAE to bitwise comparison
Date: Fri, 25 Feb 2022 18:02:03 -0600
Message-ID: <c3acf41f-8e4b-f854-e5d3-6c134b378bc8@gmail.com>
In-Reply-To: 20220225233251.2958102-1-prestwoj@gmail.com

--===============4322262989380709583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/25/22 17:32, James Prestwood wrote:
> All uses of this macro will work with a bitwise comparison which is
> needed for 6GHz checks and somewhat more flexible since it can be
> used to compare RSN info, not only single AKM values.
> ---
>   src/ie.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Patches 1-4 applied.  (6-7 were applied earlier).

Regards,
-Denis

--===============4322262989380709583==--

