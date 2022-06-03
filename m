Content-Type: multipart/mixed; boundary="===============7041601036507912295=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/2] auto-t: remove ifconfig call from testScan
Date: Fri, 03 Jun 2022 11:59:37 -0500
Message-ID: <bd2271eb-4b3e-c2a0-571e-a2663faa5b97@gmail.com>
In-Reply-To: 20220603170554.183478-1-prestwoj@gmail.com

--===============7041601036507912295==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 6/3/22 12:05, James Prestwood wrote:
> ifconfig isn't available by default in several linux distros
> so instead use 'ip' which seems to be much more widespread.
> ---
>   autotests/testScan/remove_iface_test.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Both applied, thanks.

Regards,
-Denis

--===============7041601036507912295==--

