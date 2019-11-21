Content-Type: multipart/mixed; boundary="===============9138957885310813905=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v6] rrm: add packed struct for beacon reports
Date: Thu, 21 Nov 2019 16:34:36 -0600
Message-ID: <e4afa26d-d92f-a1f7-59d5-4acb2206c908@gmail.com>
In-Reply-To: <20191121213631.28834-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9138957885310813905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/21/19 3:36 PM, James Prestwood wrote:
> build_report_for_bss was refactored to use this packed structure rather
> than l_put_* APIs.
> ---
>   src/rrm.c | 64 ++++++++++++++++++++++++++++++++++---------------------
>   1 file changed, 40 insertions(+), 24 deletions(-)
> =

> -v6:
>   * Used L_CPU_TO_LE* macros
> =


Applied, thanks.

Regards,
-Denis

--===============9138957885310813905==--

