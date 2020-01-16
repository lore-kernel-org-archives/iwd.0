Content-Type: multipart/mixed; boundary="===============7465780542933899789=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] rrm: Switch to new frame watch API
Date: Thu, 16 Jan 2020 11:39:06 -0600
Message-ID: <57761d83-91f5-bfed-3740-66d098429a6c@gmail.com>
In-Reply-To: <20200116024100.18371-2-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7465780542933899789==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 1/15/20 8:40 PM, Andrew Zaborowski wrote:
> ---
>   src/rrm.c | 16 +++++++++++-----
>   1 file changed, 11 insertions(+), 5 deletions(-)
> =


<snip>

> @@ -794,6 +794,12 @@ static void rrm_netdev_watch(struct netdev *netdev,
>   		rrm_new_state(netdev);
>   		return;
>   	case NETDEV_WATCH_EVENT_DEL:
> +		/*
> +		 * We're triggered on L80211_CMD_DEL_INTERFACE and RTM_DELLINK which
> +		 * also cause all frame watches to be unregistered so we don't have
> +		 * to do this here.
> +		 */
> +

I reflowed / edited this comment a bit since it was going > 80 chars.

>   		rrm =3D l_queue_remove_if(states, match_ifindex,
>   						L_UINT_TO_PTR(ifindex));
>   		if (rrm) {
> =


Patches 1-4 all applied, thanks.

Regards,
-Denis
--===============7465780542933899789==--

