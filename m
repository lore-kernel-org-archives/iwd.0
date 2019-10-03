Content-Type: multipart/mixed; boundary="===============5744306285676670398=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: record dependency on netconfig module
Date: Thu, 03 Oct 2019 12:31:09 -0500
Message-ID: <2017ceb0-1347-fe19-f4dd-76117162134b@gmail.com>
In-Reply-To: <20191003172534.1148-1-w@wdtz.org>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5744306285676670398==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Will,

On 10/3/19 12:25 PM, Will Dietz wrote:
> The netconfig module must be initialized (netconfig_list, for example)
> before station module can be used, record this to ensure that happens.
> ---
>   src/station.c | 1 +
>   1 file changed, 1 insertion(+)
> =


Applied, thanks.

Regards,
-Denis
--===============5744306285676670398==--

