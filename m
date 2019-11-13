Content-Type: multipart/mixed; boundary="===============7675644529823327639=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] resolve: fix runtime error if netconfig is not enabled
Date: Wed, 13 Nov 2019 18:52:52 +0100
Message-ID: <9C8A7533-FA63-4CF0-AC08-B97B4B926453@holtmann.org>
In-Reply-To: <20191113174536.15680-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7675644529823327639==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

> If the resolve module was not enabled in the config file, IWD fails
> to start since resolve_init was returning -EINVAL. Since netconfig
> is optional, we just return successfully here.
> ---
> src/resolve.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied.

Regards

Marcel

--===============7675644529823327639==--

