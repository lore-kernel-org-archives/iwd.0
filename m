Content-Type: multipart/mixed; boundary="===============5068035886661383630=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v6 1/3] ap: add support for DHCPv4 server
Date: Tue, 27 Oct 2020 16:20:12 -0500
Message-ID: <1cc70635-4273-ddc9-f8ea-92642ac1f475@gmail.com>
In-Reply-To: <20201027195749.2266686-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5068035886661383630==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/27/20 2:57 PM, James Prestwood wrote:
> The DHCP server can be enabled by enabling network configuration
> with [General].EnableNetworkConfiguration. If an IP is not set
> on the interface before the AP is started a valid IP range must
> also be provided under [General].APRanges in IP prefix format e.g.
> =

> [General]
> EnableNetworkConfiguration=3Dtrue
> APRanges=3D192.168.1.1/24
> =

> Each AP started will get assigned a new subnet within the range
> specified by APRanges as to not conflict with other AP interfaces.
> If there are no subnets left in the pool when an AP is started
> it will fail with -EEXIST. Any AP's that are stopped will release
> their subnet back into the pool to be used with other APs.
> =

> The DHCP IP pool will be automatically chosen by the ELL DHCP
> implementation (+1 the AP's IP to *.254). The remaining DHCP
> settings will be defaults chosen by ELL (DNS, lease time, etc).
> ---
>   src/ap.c | 281 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 275 insertions(+), 6 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============5068035886661383630==--

