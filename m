Content-Type: multipart/mixed; boundary="===============1679328379184408157=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] dpp: parse configuration request values
Date: Thu, 06 Jan 2022 18:03:55 -0600
Message-ID: <28f20c58-d770-12b1-0fd5-ac40d00a0ed6@gmail.com>
In-Reply-To: 20220106230205.571804-1-prestwoj@gmail.com

--===============1679328379184408157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 1/6/22 17:02, James Prestwood wrote:
> With better JSON support the configuration request object
> can now be fully parsed. As stated in the previous comment
> there really isn't much use from the configurator side apart
> from verifying mandatory values are included.
> =

> This patch also modifies the configuration result to handle
> sending non 'OK' status codes in case of JSON parsing errors.
> ---
>   src/dpp.c | 76 ++++++++++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 58 insertions(+), 18 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============1679328379184408157==--

