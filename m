Content-Type: multipart/mixed; boundary="===============5471192707035592443=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] station: replace old BSS with 'best_bss' on roam scan
Date: Tue, 08 Mar 2022 11:37:49 -0600
Message-ID: <6313a7f9-b153-70e9-ee79-265d94c77fd7@gmail.com>
In-Reply-To: 20220304212419.3534676-1-prestwoj@gmail.com

--===============5471192707035592443==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/4/22 15:24, James Prestwood wrote:
> The logic here assumed any BSS's in the roam scan were identical to ones
> in station's bss_list with the same address. Usually this is true but,
> for example, if the BSS changed frequency the one in station's list is
> invalid.
> =

> Intead when a match is found remove the old BSS and re-insert the new one.

Fixed this typo and...

> ---
>   src/station.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============5471192707035592443==--

