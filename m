Content-Type: multipart/mixed; boundary="===============6459266484593443052=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/18] p2p: Stop discovery after GO Negotiation Req error
Date: Mon, 13 Jul 2020 14:25:18 -0500
Message-ID: <3d623ecb-512e-9fa2-7cb4-3668a575d4e4@gmail.com>
In-Reply-To: <20200711010053.224223-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6459266484593443052==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 7/10/20 8:00 PM, Andrew Zaborowski wrote:
> If we were in discovery only to be able to receive the target peer's
> GO Negotiation Request (i.e. we have no users requesting discovery)
> and we've received the frame and decided that the connection has
> failed, exit discovery.
> ---
>   src/p2p.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> =


Patches 1-10 applied, thanks.

Regards,
-Denis

--===============6459266484593443052==--

