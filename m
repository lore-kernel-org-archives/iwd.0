Content-Type: multipart/mixed; boundary="===============7921431442407823854=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] manager: move debug print in dump callback
Date: Mon, 04 May 2020 18:09:22 +0000
Message-ID: <ad7beb1c-1e52-864e-d1c1-2ca666b06b8c@gmail.com>
In-Reply-To: <20200504152420.27210-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7921431442407823854==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/4/20 10:24 AM, James Prestwood wrote:
> This callback gets called way to many times to have a debug print
> in the location that it was. Instead only print if a NEW wiphy is
> found, and also print the name/id.
> ---
>   src/manager.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

All applied, thanks.

Regards,
-Denis

--===============7921431442407823854==--

