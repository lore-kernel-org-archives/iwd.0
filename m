Content-Type: multipart/mixed; boundary="===============5562467547927013157=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netconfig: Don't clear IPv6 addresses on shutdown
Date: Wed, 09 Oct 2019 17:53:42 -0500
Message-ID: <8e196056-50f5-aa7a-db7a-673c4ca21b74@gmail.com>
In-Reply-To: <20191009224333.28884-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5562467547927013157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/9/19 5:43 PM, Tim Kourt wrote:
> Unlike IPv4, the IPv6 address are removed by the kernel.
> ---
>   src/netconfig.c | 3 ---
>   1 file changed, 3 deletions(-)

Applied, thanks.

Regards,
-Denis

--===============5562467547927013157==--

