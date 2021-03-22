Content-Type: multipart/mixed; boundary="===============0702458765869065101=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: prevent crash with open networks
Date: Mon, 22 Mar 2021 17:46:33 -0500
Message-ID: <bd922127-bb18-f283-4f0e-3c0b11c9c474@gmail.com>
In-Reply-To: <20210322222052.424191-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0702458765869065101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 3/22/21 5:20 PM, James Prestwood wrote:
> The SAE offload changes assumed a handshake object would
> exist in netdev, which is not the case for open networks.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0702458765869065101==--

