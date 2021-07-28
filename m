Content-Type: multipart/mixed; boundary="===============3451868205798175121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] netdev: fix RoamThreshold5G
Date: Wed, 28 Jul 2021 10:07:06 -0500
Message-ID: <3abab8f4-444a-1fad-5e29-8ee7f60754de@gmail.com>
In-Reply-To: <20210727225023.36586-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3451868205798175121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 7/27/21 5:50 PM, James Prestwood wrote:
> The RoamThreshold5G was never honored because it was being
> set prior to any connections. This caused the logic inside
> netdev_cqm_rssi_update to always choose the 2GHz threshold
> (RoamThreshold) due to netdev->frequency being zero at this time.
> =

> Instead call netdev_cqm_rssi_update in all connect/transition
> calls after netdev->frequency is updated. This will allow both
> the 2G and 5G thresholds to be used depending on what frequency
> the new BSS is.
> =

> The call to netdev_cqm_rssi_update in netdev_setup_interface
> was also removed since it serves no purpose, at least now
> that there are two thresholds to consider.
> ---
>   src/netdev.c | 192 +++++++++++++++++++++++++--------------------------
>   1 file changed, 96 insertions(+), 96 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3451868205798175121==--

