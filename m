Content-Type: multipart/mixed; boundary="===============4961752349626587852=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH] network: reply to pending messages on network_unregister
Date: Fri, 17 Sep 2021 18:13:46 -0500
Message-ID: <83b423c9-6a99-d7d1-1989-b6d5d70e5bcc@gmail.com>
In-Reply-To: 20210917231610.27853-1-prestwoj@gmail.com

--===============4961752349626587852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/17/21 6:16 PM, James Prestwood wrote:
> If there is a connect_after_* message for ANQP or OWE hidden networks
> reply to these before unregistering the network.
> ---
>   src/network.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4961752349626587852==--

