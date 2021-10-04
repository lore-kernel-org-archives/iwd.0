Content-Type: multipart/mixed; boundary="===============5906416810133138097=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 04/12] handshake: add callback for extended key IDs
Date: Mon, 04 Oct 2021 14:43:36 -0500
Message-ID: <a4bcd8f8-da6e-a7e6-1282-6ce00cbb8b3a@gmail.com>
In-Reply-To: 20211004164902.2274318-4-prestwoj@gmail.com

--===============5906416810133138097==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/4/21 11:48 AM, James Prestwood wrote:
> The procedure for setting extended key IDs is different from the
> single PTK key. The key ID is toggled between 0 and 1 and the new
> key is set as RX only, then set to RX/TX after message 4/4 goes
> out.

So the problem is that we don't really know when the message actually goes =
out. =

  We know when we queue it, and CONTROL_PORT sort of helps with that.  But =
in =

the case of PAE socket, we only know we copied it over to the kernel buffer=
s, =

not that it has actually went out.

There's some sort of CMSG that the kernel sends when the message has been =

"transmitted" and acked.  There is now a similar mechanism for CONTROL_PORT =

messages now with CONTROL_PORT_TX_STATUS.  We could use this mechanism, but =

you'd really need an async callback for this as well.  Still, I'm not sure =
that =

waiting for the ack is what the spec intends here.

> =

> Since netdev needs to set this new key before message 4/4 a new
> callback has been added to accomplish this. The callback itself
> takes a callback so netdev can signal back to eapol that NEW_KEY

It might have been easier to just add a handshake_state_ext_key_toggled_to_=
rx or =

something.  But my main concern is that eapol.c isn't really meant to be =

re-entrant in the way you're proposing to do here.  I wonder what can of wo=
rms =

this opens up...

Do note that with CONTROL PORT over 80211, this is really not needed.  The =

control port messages will be transmitted in order given.  The only issue i=
s =

really use of legacy PAE sockets.  We can handle this in one of two ways:
   1.  Turn off EXT_KEY_ID if CONTROL_PORT isn't supported
   2.  Have netdev check whether an outstanding SET_KEY command is pending =
(to =

toggle the current TK to RX-only) and delay the send over PAE until that co=
mmand =

returns.

#2 might need to take some care, but overall I think this would be a better =

strategy than making eapol re-entrant.

> finished and message 4/4 can be sent.
> ---
>   src/handshake.c | 21 +++++++++++++++++++++
>   src/handshake.h | 12 ++++++++++++
>   2 files changed, 33 insertions(+)
> =


<snip>

> diff --git a/src/handshake.h b/src/handshake.h
> index e67e2c20..303cffbf 100644
> --- a/src/handshake.h
> +++ b/src/handshake.h
> @@ -78,11 +78,19 @@ typedef void (*handshake_install_igtk_func_t)(struct =
handshake_state *hs,
>   					const uint8_t *igtk, uint8_t igtk_len,
>   					const uint8_t *ipn, uint8_t ipn_len,
>   					uint32_t cipher);
> +typedef void (*handshake_install_rx_tk_cb_t)(bool success, void *user_da=
ta);
> +typedef void (*handshake_install_rx_tk_func_t)(struct handshake_state *h=
s,

I wonder if the naming should be different.  You're really setting the curr=
ent =

TK as read-only and not for transmission.  So something that conveys this =

meaning better would be nice.

> +					uint8_t key_idx,
> +					const uint8_t *tk,
> +					uint32_t cipher,
> +					handshake_install_rx_tk_cb_t callback,
> +					void *user_data);
>   =

>   void __handshake_set_get_nonce_func(handshake_get_nonce_func_t func);
>   void __handshake_set_install_tk_func(handshake_install_tk_func_t func);
>   void __handshake_set_install_gtk_func(handshake_install_gtk_func_t func=
);
>   void __handshake_set_install_igtk_func(handshake_install_igtk_func_t fu=
nc);
> +void __handshake_set_install_rx_tk_func(handshake_install_rx_tk_func_t f=
unc);
>   =

>   struct handshake_state {
>   	uint32_t ifindex;
> @@ -227,6 +235,10 @@ size_t handshake_state_get_kek_len(struct handshake_=
state *s);
>   const uint8_t *handshake_state_get_kek(struct handshake_state *s);
>   void handshake_state_install_ptk(struct handshake_state *s);
>   =

> +void handshake_state_install_rx_ptk(struct handshake_state *s,
> +					uint8_t key_idx,
> +					handshake_install_rx_tk_cb_t callback,
> +					void *user_data);
>   void handshake_state_install_gtk(struct handshake_state *s,
>   					uint16_t gtk_key_index,
>   					const uint8_t *gtk, size_t gtk_len,
> =


Regards,
-Denis
--===============5906416810133138097==--

