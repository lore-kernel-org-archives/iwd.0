Content-Type: multipart/mixed; boundary="===============4421927998678720896=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] netdev: fix segfault due to roaming before connected
Date: Mon, 04 May 2020 21:53:27 +0000
Message-ID: <59e71637-ab28-cb26-a0c5-a44c9ec70a59@gmail.com>
In-Reply-To: <20200504213055.8330-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4421927998678720896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/4/20 4:30 PM, James Prestwood wrote:
> In this situation the kernel is sending a low RSSI event which netdev
> picks up, but since we set netdev->connected so early the event is
> forwarded to station before IWD has fully connected. Station then
> tries to get a neighbor report, which may fail and cause a known
> frequency scan. If this is a new network the frequency scan tries to
> get any known frequencies in network_info which will be unset and
> cause a segfault.
> =

> This can be avoided by only sending RSSI events when netdev->operational
> is set rather than netdev->connected.
> ---
>   src/netdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

applied, thanks.

Regards,
-Denis

--===============4421927998678720896==--

