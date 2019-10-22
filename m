Content-Type: multipart/mixed; boundary="===============8403990014097238207=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 04/11] eapol: Move the EAP event handler to handshake state
Date: Mon, 21 Oct 2019 23:11:15 -0500
Message-ID: <348b0c98-10f7-feb5-4f1f-60870d66b8f2@gmail.com>
In-Reply-To: <20191021135510.12657-4-balrogg@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8403990014097238207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 10/21/19 8:55 AM, Andrew Zaborowski wrote:
> From: Andrew Zaborowski <andrew.zaborowski@intel.com>
> =

> Move the storage of the eapol event callback from the eapol_sm struct to
> the handshake_state struct.  Rename from eapol event to eap event as the
> callback is only used to relay eap-specific event in eapol.c.

Hmm, I'd be tempted to use handshake_state_set_event_func() for this as =

well.  Especially given that wsc.c already subscribes to handshake =

events.  Only problem is getting the eap event type and data to the =

event func.  I wonder if variadic functions work through pointers...

> =

> This is allows the handler to be set before calling
> netdev_connect/netdev_connect_wsc.  It's also in theory more type-safe
> because don't need the cast in netdev_connect_wsc anymore.
> =

> Note that eapol_sm_set_user_data is now unused.  I'm not sure if it
> should be removed on its own, the user_data that it sets will also
> affect rekey_offload callbacks.  However rekey_offload's user_data
> parameter is not used by the only implementation of that callback, so
> both could be removed together.

I'd imagine they can be reworked to act like netdev_set_tk, etc. =

Removing set_user_data is a good idea regardless.

> ---
>   src/eapol.c     | 10 +++-------
>   src/eapol.h     |  1 -
>   src/handshake.c |  8 ++++++++
>   src/handshake.h | 10 +++++++++-
>   src/netdev.c    |  6 ++++--
>   5 files changed, 24 insertions(+), 11 deletions(-)
> =


Regards,
-Denis
--===============8403990014097238207==--

