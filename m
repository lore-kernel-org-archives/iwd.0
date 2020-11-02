Content-Type: multipart/mixed; boundary="===============5467137447929929776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] ap: fixup incorrect return
Date: Mon, 02 Nov 2020 14:24:15 -0600
Message-ID: <f003c316-d56a-da48-cfde-cf67d65e7b19@gmail.com>
In-Reply-To: <20201102201752.2585008-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5467137447929929776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/2/20 2:17 PM, James Prestwood wrote:
> If an RTNL address change fails -EIO should be returned, not
> false (aka "success").
> ---
>   src/ap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks

Regards,
-Denis

--===============5467137447929929776==--

