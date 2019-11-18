Content-Type: multipart/mixed; boundary="===============7511505079753975200=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] rrm: remove use of floating point math
Date: Mon, 18 Nov 2019 12:52:54 -0600
Message-ID: <61d7ec56-e2f4-71aa-50e6-5e0eb73c62d3@gmail.com>
In-Reply-To: <20191118183554.25648-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7511505079753975200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/18/19 12:35 PM, James Prestwood wrote:
> The RCPI value was using floating point values as per the spec. But inste=
ad
> we can just use the signal strength coming from the kernel in mili mdm and
> scale the hard coded values by a factor of 100.
> ---
>   src/rrm.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7511505079753975200==--

