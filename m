Content-Type: multipart/mixed; boundary="===============2608517659584052085=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simauth: check driver for NULL before canceling request
Date: Mon, 16 Nov 2020 17:04:55 -0600
Message-ID: <e6269916-c05c-d449-a938-83b0f47da6a5@gmail.com>
In-Reply-To: <20201116222218.3486513-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2608517659584052085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/16/20 4:22 PM, James Prestwood wrote:
> If the ofono modem got removed before it was fully initialized this
> could cause a crash.
> ---
>   src/simauth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2608517659584052085==--

