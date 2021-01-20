Content-Type: multipart/mixed; boundary="===============8501259639262576378=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: remove unused roam_no_orig_ap state variable
Date: Wed, 20 Jan 2021 11:14:51 -0600
Message-ID: <cad511c8-e5a5-14ee-8b50-b931dc08a63a@gmail.com>
In-Reply-To: <20210120160654.2998911-1-alsi@bang-olufsen.dk>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8501259639262576378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alvin,

On 1/20/21 10:06 AM, Alvin =C5=A0ipraga wrote:
> Since commit 836beb1276d1bc77889462ae514f0c5b708a38d7 removed beacon
> loss handling, the roam_no_orig_ap variable has no use and is always set
> to false. This commit removes it.
> ---
>   src/station.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> =


Applied, thanks!

Regards,
-Denis

--===============8501259639262576378==--

