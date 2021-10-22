Content-Type: multipart/mixed; boundary="===============0755715005259601169=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 02/12] netconfig: Cache the IPv6 l_rtnl_address object
Date: Fri, 22 Oct 2021 12:14:28 -0500
Message-ID: <1ead53fc-e7f9-eb13-bcdc-9b0bb1ba6f12@gmail.com>
In-Reply-To: 20211021085041.294524-2-andrew.zaborowski@intel.com

--===============0755715005259601169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/21 3:50 AM, Andrew Zaborowski wrote:
> For symmetry with netconfig->v4_address add a netconfig->v6_address
> so that we can track what the current address is at any time.
> ---
>   src/netconfig.c | 44 ++++++++++++++++++++++++++++++++------------
>   1 file changed, 32 insertions(+), 12 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0755715005259601169==--

