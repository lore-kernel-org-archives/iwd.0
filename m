Content-Type: multipart/mixed; boundary="===============4016977579302626087=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/2] offchannel: always use -ECANCELED for cancelation
Date: Thu, 16 Dec 2021 12:21:24 -0600
Message-ID: <643253de-8c9f-320f-fc89-b2cb70e1babf@gmail.com>
In-Reply-To: 20211216180003.38883-2-prestwoj@gmail.com

--===============4016977579302626087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/16/21 12:00, James Prestwood wrote:
> info->error gets reset to zero on a successful ROC callback
> which was getting used for cancelation.
> ---
>   src/offchannel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4016977579302626087==--

