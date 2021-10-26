Content-Type: multipart/mixed; boundary="===============1392231484792796052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] netdev: add SA Query delay with OCV enabled
Date: Tue, 26 Oct 2021 17:24:00 -0500
Message-ID: <efe70da2-2e33-ff57-f298-4486c3e2aba0@gmail.com>
In-Reply-To: 20211026222427.1264435-1-prestwoj@gmail.com

--===============1392231484792796052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/26/21 5:24 PM, James Prestwood wrote:
> The way a SA Query was done following a channel switch was slightly
> incorrect. One because it is only needed when OCVC is set, and two
> because IWD was not waiting a random delay between 0 and 5000us as
> lined out by the spec. This patch fixes both these issues.
> ---
>   src/netdev.c | 32 +++++++++++++++++++++++++++++++-
>   1 file changed, 31 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============1392231484792796052==--

