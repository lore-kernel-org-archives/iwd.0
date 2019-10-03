Content-Type: multipart/mixed; boundary="===============2122702290095808529=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] crypto: fix copy size causing overruns/crashing
Date: Thu, 03 Oct 2019 12:28:24 -0500
Message-ID: <be4298eb-420d-412d-a033-16a2acd78ded@gmail.com>
In-Reply-To: <20191003171851.31807-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2122702290095808529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 10/3/19 12:18 PM, Will Dietz wrote:
> num_ad is already accounted for in `sizeof(iov)`
> as iov has size `sizeof(struct iovec) * (num_ad+1)`.
> ---
>   src/crypto.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============2122702290095808529==--

