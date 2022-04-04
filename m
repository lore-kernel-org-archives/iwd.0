Content-Type: multipart/mixed; boundary="===============0581463298392122871=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] test-runner: fix kernel panic on exit for UML
Date: Mon, 04 Apr 2022 11:14:57 -0500
Message-ID: <d7b42aba-40e4-624d-f657-b87b3d5bb896@gmail.com>
In-Reply-To: 20220401221639.704786-1-prestwoj@gmail.com

--===============0581463298392122871==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 4/1/22 17:16, James Prestwood wrote:
> UML requires RB_POWER_OFF rather than RB_AUTOBOOT (Qemu) in order
> to avoid a kernel panic from killing init.
> ---
>   tools/runner.py | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============0581463298392122871==--

