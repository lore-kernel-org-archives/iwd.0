Content-Type: multipart/mixed; boundary="===============7701320652153880015=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/1] client: fix colors to make grey really grey
Date: Wed, 16 Mar 2022 09:57:14 -0500
Message-ID: <83acb067-edb8-92dd-2d74-c0f6d83d52b4@gmail.com>
In-Reply-To: 20220316090633.13369-2-vladimir@tango-dj.cz

--===============7701320652153880015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vladim=C3=ADr,

On 3/16/22 04:06, Vladim=C3=ADr Dudr wrote:
> \e[1;30m is bold black, often, but not always displayed bright black or
> bold bright black. In case it is displayed as real black it is
> invisible. \e[1;90m is explicit bold bright black.
> =

> \e[37m is white, therefore it is not suitable to be labeled as GREY,
> which is \e[90m
> ---
>   client/display.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks!

Regards,
-Denis

--===============7701320652153880015==--

