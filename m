Content-Type: multipart/mixed; boundary="===============7278950714725122461=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] adhoc: fix missing call to va_end
Date: Mon, 08 Feb 2021 15:17:00 -0600
Message-ID: <b5a3237a-5b59-d622-4c7e-f1e5c7649b80@gmail.com>
In-Reply-To: <20210208210725.611632-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7278950714725122461==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 3:07 PM, James Prestwood wrote:
> Since only one switch case uses this, va_start/end were just
> moved into that case specifically.
> ---
>   src/adhoc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7278950714725122461==--

