Content-Type: multipart/mixed; boundary="===============8783916328955129939=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] unit: add larger object test
Date: Fri, 10 Dec 2021 18:07:53 -0600
Message-ID: <6497b72b-80ab-ac12-4772-e39d8de2d5f8@gmail.com>
In-Reply-To: 20211211002137.2104598-1-prestwoj@gmail.com

--===============8783916328955129939==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 12/10/21 6:21 PM, James Prestwood wrote:
> This tests the previous JSON bug fix removing % sizeof(jsmntok_t)
> Objects with more than 10 (sizeof(jsmntok_t)) would not parse
> correctly.
> ---
>   unit/test-json.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============8783916328955129939==--

