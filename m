Content-Type: multipart/mixed; boundary="===============7804560855120113633=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] station: fix segfault due to roaming before connected
Date: Mon, 04 May 2020 21:17:05 +0000
Message-ID: <138e8b62-72d3-75de-2e8a-2cf4c31d4bed@gmail.com>
In-Reply-To: <20200504201553.5246-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7804560855120113633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 5/4/20 3:15 PM, James Prestwood wrote:
> In this situation the kernel is sending a low RSSI event which netdev
> picks up, but since we set netdev->connected so early the event is
> forwarded to station before IWD has fully connected. Station then
> tries to get a neighbor report, which may fail and cause a known
> frequency scan. If this is a new network the frequency scan tries to
> get any known frequencies in network_info which will be unset and
> cause a segfault.

Hmm, maybe netdev should not send any RSSI events until =

netdev->operational is true instead.

Regards,
-Denis
--===============7804560855120113633==--

