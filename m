Content-Type: multipart/mixed; boundary="===============7894291938011658038=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] rrm: fix bad sign for calculating RCPI
Date: Fri, 13 Dec 2019 08:35:35 +0100
Message-ID: <C316F6D0-A90C-40A2-9501-4280635EB91C@holtmann.org>
In-Reply-To: <20191213000407.22427-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7894291938011658038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> The first if case should be -10950, not 10950. Without the negative
> this first case would get hit every time since signal strength values
> are always negative.
> ---
> src/rrm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

--===============7894291938011658038==--

