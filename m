Content-Type: multipart/mixed; boundary="===============1718329670430987397=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/6] ap: Add authorized_macs parameter
Date: Tue, 04 Aug 2020 10:44:52 -0500
Message-ID: <a5688bc3-2712-8bd9-5a14-18adf51362f4@gmail.com>
In-Reply-To: <20200804145303.151878-6-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1718329670430987397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 8/4/20 9:53 AM, Andrew Zaborowski wrote:
> ---
>   src/ap.c | 31 ++++++++++++++++++++++++++++++-
>   src/ap.h |  1 +
>   2 files changed, 31 insertions(+), 1 deletion(-)
> =


<snip>

> diff --git a/src/ap.h b/src/ap.h
> index 2da0596f..b007b657 100644
> --- a/src/ap.h
> +++ b/src/ap.h
> @@ -47,6 +47,7 @@ typedef void (*ap_stopped_func_t)(void *user_data);
>   =

>   struct ap_state *ap_start(struct netdev *netdev, const char *ssid,
>   				const char *psk, int channel, bool no_cck_rates,
> +				const uint8_t **authorized_macs,
>   				ap_event_func_t event_func, void *user_data);

By the way, you're pretty much at the limit of sane number of arguments her=
e. =

If you decide to add any more, I suggest a struct ap_config object of some =
sort =

with a nice set/get api that ap_start could take ownership of.

>   void ap_shutdown(struct ap_state *ap, ap_stopped_func_t stopped_func,
>   			void *user_data);
> =


Regards,
-Denis
--===============1718329670430987397==--

