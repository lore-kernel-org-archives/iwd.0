Content-Type: multipart/mixed; boundary="===============4410784690640953843=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Don't pass NULL as src to memcpy, even when zero len.
Date: Mon, 28 Oct 2019 14:59:38 -0500
Message-ID: <d65fc0cf-519b-5adb-9126-7bca33a3c922@gmail.com>
In-Reply-To: <20191028194201.12372-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4410784690640953843==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 10/28/19 2:42 PM, Will Dietz wrote:
> Skip the memcpy when len =3D 0, definitely don't ignore attempt
> to copy X bytes from NULL where X !=3D 0 :).
> ---
>   monitor/main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============4410784690640953843==--

