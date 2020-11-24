Content-Type: multipart/mixed; boundary="===============0347911572807575386=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netconfig: fix freeing invalid pointer
Date: Mon, 23 Nov 2020 23:30:13 -0600
Message-ID: <2c25345e-e900-c46b-b745-73dbbd0a876e@gmail.com>
In-Reply-To: <20201123230554.4119658-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0347911572807575386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/23/20 5:05 PM, James Prestwood wrote:
> If l_rtnl_ifaddr4_extract does not set the values they would
> get freed. Instead initialize to NULL so the cleanup free is
> a no op.
> ---
>   src/netconfig.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0347911572807575386==--

