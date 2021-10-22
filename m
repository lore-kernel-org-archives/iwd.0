Content-Type: multipart/mixed; boundary="===============3024215173822291157=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 01/12] treewide: Parse EnableNetworkConfiguration in one
 place
Date: Fri, 22 Oct 2021 12:14:05 -0500
Message-ID: <2c2e3e54-007d-b731-e23a-c06847906ea5@gmail.com>
In-Reply-To: 20211021085041.294524-1-andrew.zaborowski@intel.com

--===============3024215173822291157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/21 3:50 AM, Andrew Zaborowski wrote:
> Add netconfig_get_enabled() and use that in all places that want to know

So I renamed this to netconfig_enabled() since that better reflects the int=
ent =

of this API.

> whether network configuration is enabled.  Drop the enable_network_config
> deprecated setting, which was only being handled in one of these 5 or so
> places.
> ---
>   src/ap.c        | 11 +++--------
>   src/ip-pool.c   | 11 ++---------
>   src/main.c      |  8 ++------
>   src/netconfig.c |  9 +++++++++
>   src/netconfig.h |  2 ++
>   src/resolve.c   | 12 ++----------
>   src/station.c   | 10 ++--------
>   7 files changed, 22 insertions(+), 41 deletions(-)
> =


I also refactored main.c D-Bus API implementation slightly in a follow-on =

commit.  Please review.

Regards,
-Denis
--===============3024215173822291157==--

