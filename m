Content-Type: multipart/mixed; boundary="===============1865320795051078829=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] scan: Address uninitialized scalars reported by coverity
Date: Wed, 16 Oct 2019 16:35:28 -0500
Message-ID: <d9218949-ecae-a0c5-3b7e-a76abac9b303@gmail.com>
In-Reply-To: <20191015174019.13088-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1865320795051078829==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 10/15/19 12:40 PM, Tim Kourt wrote:
> ---
>   src/scan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

I fixed this slightly differently, see commit =

269377c92f96a7e127694fd0f659262463426edf.  Please review.

Regards,
-Denis

--===============1865320795051078829==--

