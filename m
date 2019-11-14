Content-Type: multipart/mixed; boundary="===============4930601191512639954=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: fail if trying to scan while connecting
Date: Thu, 14 Nov 2019 15:23:44 -0600
Message-ID: <5882ec0d-952f-7aa2-2a4a-2fdae2a8c9ab@gmail.com>
In-Reply-To: <20191114185959.24875-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4930601191512639954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/14/19 12:59 PM, James Prestwood wrote:
> If a scan is requested during the middle of a connection we should
> return busy instead of attempting the scan. The kernel ends up coming
> back with not supported in this case, which is misleading and
> difficult to debug.
> ---
>   src/station.c | 3 +++
>   1 file changed, 3 insertions(+)
> =


Applied, thanks.

Regards,
-Denis

--===============4930601191512639954==--

