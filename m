Content-Type: multipart/mixed; boundary="===============8593273828762607423=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 08/16] eapol: Move the EAP events to handshake event
 handler
Date: Wed, 30 Oct 2019 14:27:18 -0500
Message-ID: <0e1f7903-0198-36d1-1516-6066bfa91c5e@gmail.com>
In-Reply-To: <20191028140508.13518-8-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8593273828762607423==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/28/19 9:05 AM, Andrew Zaborowski wrote:
> On EAP events, call the handshake_event handler with the new event type
> HANDSHAKE_EVENT_EAP_NOTIFY isntead of the eapol_event callback.
> =

> This allows the handler to be set before calling
> netdev_connect/netdev_connect_wsc.  It's also in theory more type-safe
> because we don't need the cast in netdev_connect_wsc anymore.
> ---
>   src/eapol.c     |  6 ++----
>   src/handshake.h |  1 +
>   src/station.c   |  1 +
>   src/wsc.c       | 27 +++++++++++++++++----------
>   4 files changed, 21 insertions(+), 14 deletions(-)
> =


Patch 8 and 9 applied, thanks.

Regards,
-Denis


--===============8593273828762607423==--

