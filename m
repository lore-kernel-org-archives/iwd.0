Content-Type: multipart/mixed; boundary="===============0043532873156403966=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 10/16] wsc: Replace netdev_connect_wsc with netdev_connect
 usage
Date: Wed, 30 Oct 2019 14:36:50 -0500
Message-ID: <86c4da8b-44c5-afb3-4d8a-a69763bf1688@gmail.com>
In-Reply-To: <20191028140508.13518-10-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0043532873156403966==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/28/19 9:05 AM, Andrew Zaborowski wrote:
> netdev_connect can achieve the same effect as netdev_connect_wsc but is
> more flexible as it allows us to supply additional association IEs.  We
> will need this capability to make P2P connections.  This way we're also
> moving the WSC-specific bits to wsc.c from the crowded netdev.c.
> ---
>   src/netdev.c |  2 +-
>   src/wsc.c    | 46 +++++++++++++++++++++++++++++++++-------------
>   2 files changed, 34 insertions(+), 14 deletions(-)
> =


Patch 10 & 12 applied, thanks.

Regards,
-Denis

--===============0043532873156403966==--

