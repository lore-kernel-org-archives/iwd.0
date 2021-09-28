Content-Type: multipart/mixed; boundary="===============4028503952692232739=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/3] util: surround MAC_STR array access with ()
Date: Mon, 27 Sep 2021 19:34:00 -0500
Message-ID: <a35f0d10-b387-ab2c-4389-495d16d877df@gmail.com>
In-Reply-To: 20210927224136.312226-1-prestwoj@gmail.com

--===============4028503952692232739==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/27/21 5:41 PM, James Prestwood wrote:
> This allows printing from pointer offsets, for example:
> =

> MAC_STR(buf + 10)
> ---
>   src/util.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


All applied, thanks.

Regards,
-Denis

--===============4028503952692232739==--

