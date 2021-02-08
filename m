Content-Type: multipart/mixed; boundary="===============3075654205231395846=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] display: use l_strlcpy to avoid potential overflow
Date: Mon, 08 Feb 2021 14:26:11 -0600
Message-ID: <8ac30a3a-9c94-e99f-cfa4-c68763e3b435@gmail.com>
In-Reply-To: <20210208201958.607049-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3075654205231395846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/8/21 2:19 PM, James Prestwood wrote:
> If 'entry' exceeds the length of 'line' we could overflow. Instead
> use l_strlcpy and pass in the remaining amount of data left in
> the buffer.
> ---
>   client/display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Patches 1,2,4,5 applied, thanks.

Regards,
-Denis

--===============3075654205231395846==--

