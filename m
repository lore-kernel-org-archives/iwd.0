Content-Type: multipart/mixed; boundary="===============6069668995477276045=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/3] ap: Drop struct ap_config in favor of l_settings
Date: Wed, 28 Apr 2021 11:26:13 -0500
Message-ID: <b9f63d9b-616f-eb45-c7a4-c6442cc04741@gmail.com>
In-Reply-To: <20210426233408.775576-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6069668995477276045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 4/26/21 6:34 PM, Andrew Zaborowski wrote:
> Change ap_start to load all of the AP configuration from a struct
> l_settings, moving the 6 or so parameters from struct ap_config members
> to the l_settings groups and keys.  This extends the ap profile concept
> used for the DHCP settings.  ap_start callers create the l_settings
> object and fill the values in it or read the settings in from a file.
> =

> Since ap_setup_dhcp and ap_load_profile_and_dhcp no longer do the
> settings file loading, they needed to be refactored and some issues were
> fixed in their logic, e.g. l_dhcp_server_set_ip_address() was never
> called when the "IP pool" was used.  Also the IP pool was previously only
> used if the ap->config->profile was NULL and this didn't match what the
> docs said:
> "If [IPv4].Address is not provided and no IP address is set on the
> interface prior to calling StartProfile the IP pool will be used."
> ---
>   src/ap.c  | 547 ++++++++++++++++++++++++++++++++----------------------
>   src/ap.h  |  19 +-
>   src/p2p.c |  53 ++++--
>   3 files changed, 359 insertions(+), 260 deletions(-)
> =


All applied, thanks.

Regards,
-Denis

--===============6069668995477276045==--

