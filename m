Content-Type: multipart/mixed; boundary="===============7389853987435282305=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] eapol: IP Allocation KDE support
Date: Mon, 14 Sep 2020 11:46:16 -0500
Message-ID: <7fc7ee8b-fa8a-024f-dbed-3e4343a0ce5f@gmail.com>
In-Reply-To: <20200914135120.463623-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7389853987435282305==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 9/14/20 8:51 AM, Andrew Zaborowski wrote:
> Support IP allocation during the 4-Way Handshake as defined in the P2P
> spec.  This is the supplicant side implementation.
> =

> The API requires the user to set hs->support_ip_allocation true before
> eapol_start().  On HANDSHAKE_EVENT_COMPLETE, if this same flag is still
> set, we've received the IP lease, the netmask and the authenticator's
> IP from the authenticator and there's no need to start DHCP.  If the
> flag is cleared, the user needs to use DHCP.
> ---
> I can split this into two flags if preferred.
> ---
>   src/eapol.c     | 76 +++++++++++++++++++++++++++++++++++++++++++------
>   src/handshake.h |  9 +++++-
>   2 files changed, 76 insertions(+), 9 deletions(-)
> =


Patches 1-3, 5 applied.  4 Doesn't apply.

Regards,
-Denis

--===============7389853987435282305==--

