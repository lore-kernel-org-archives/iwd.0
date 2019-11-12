Content-Type: multipart/mixed; boundary="===============7699056186272054717=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] peap: Adjust V0 not to close tunnel on Success of
 Phase2
Date: Mon, 11 Nov 2019 18:29:28 -0600
Message-ID: <db0b059e-37ca-d6d9-0a43-cb3d7ea2fb54@gmail.com>
In-Reply-To: <20191112001921.1752-1-tim.a.kourt@linux.intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7699056186272054717==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tim,

On 11/11/19 6:19 PM, Tim Kourt wrote:
> Despite that PEAPv0 spec indicates that TLS tunnel needs to be torn
> down after the transmission of a secure Result response, some servers
> treat this TLS close alert as a failure. This patch changes the above
> behavior to explicitly torn the tunnel only in the case of
> authentication failure and leave it open after the success.
> ---
>   src/eap-peap.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-denis

--===============7699056186272054717==--

