Content-Type: multipart/mixed; boundary="===============3185505885938060656=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v3 01/13] wiphy: change wiphy_control_port_capable ->
 enabled
Date: Fri, 08 Oct 2021 08:48:03 -0500
Message-ID: <a6bfada4-ada4-1245-e111-8d0a30c13e51@gmail.com>
In-Reply-To: 20211007204957.3745985-1-prestwoj@gmail.com

--===============3185505885938060656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/7/21 3:49 PM, James Prestwood wrote:
> Move the reading of ControlPortOverNL80211 into wiphy itself and
> renamed wiphy_control_port_capable to wiphy_control_port_enabled.
> This makes things easier for any modules interested in control
> port support since they will only have to check this one API rather
> than read the settings and check capability.
> ---
>   src/netdev.c |  7 +------
>   src/wiphy.c  | 16 +++++++++++++---
>   src/wiphy.h  |  2 +-
>   3 files changed, 15 insertions(+), 10 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============3185505885938060656==--

