Content-Type: multipart/mixed; boundary="===============0394158445840599416=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 1/8] netconfig: Track the IPv6 route add netlink command
Date: Wed, 29 Sep 2021 15:00:21 -0500
Message-ID: <f6871c79-1af2-4f5a-1e76-c59bc0f3aa79@gmail.com>
In-Reply-To: 20210925011153.25195-1-andrew.zaborowski@intel.com

--===============0394158445840599416==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/24/21 8:11 PM, Andrew Zaborowski wrote:
> For symmetry with IPv4, save the command id for this netlink command so
> we can later add logic to the callback as well as be able to cancel the
> command.  No functional change in this commit alone.
> ---
>   src/netconfig.c | 31 +++++++++++++++++++++++++++----
>   1 file changed, 27 insertions(+), 4 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0394158445840599416==--

