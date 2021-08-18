Content-Type: multipart/mixed; boundary="===============7851792731589982260=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] auto-t: scan as many times as needed to find networks
Date: Wed, 18 Aug 2021 16:56:09 -0500
Message-ID: <90ff503d-ec60-88a6-9cda-7b48c40322ce@gmail.com>
In-Reply-To: <20210818174634.267270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7851792731589982260==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 8/18/21 12:46 PM, James Prestwood wrote:
> Certain autotests coupled with slower test machines can result in lost
> beacons and "Network not found" errors. In attempt to help with this
> the test can just rescan (30 seconds max) until the network is found.
> ---
>   autotests/util/iwd.py | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============7851792731589982260==--

