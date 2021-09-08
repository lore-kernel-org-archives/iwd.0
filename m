Content-Type: multipart/mixed; boundary="===============3908571275649547402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 2/7] sae: don't send commit/confirm in confirmed state
Date: Wed, 08 Sep 2021 14:25:57 -0500
Message-ID: <b358707b-63a1-58b1-3ce1-06e68609053f@gmail.com>
In-Reply-To: <20210908181904.84594-2-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3908571275649547402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 9/8/21 1:18 PM, James Prestwood wrote:
> This works around a hostapd bug (described more in the TODO comment)
> that deaths IWD if the initial commit is not acked. This behavior

Also kernel re-transmit behavior is a bit aggressive which is a big contrib=
uting =

factor.  It is definitely not what the spec describes.

> has been identified in consumer access points and likely won't ever
> be patched for older devices. Because of this IWD must work around
> the problem which can be eliminated by not sending out this commit
> message.
> =

> This bug was reported to the hostapd ML:
> =

> https://lists.infradead.org/pipermail/hostap/2021-September/039842.html
> =

> This change should not cause any compatibility problems to non-hostapd
> access points and is identical to how wpa_supplicant treats this
> scenario.
> ---
>   src/sae.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> =

> v2:
>   * Changed to simply drop the message. Sending only a confirm is pointle=
ss
>     since it would not verify without a commit. Also remove sc++ since th=
is
>     should only be incremented when a confirm is sent.
> =

> diff --git a/src/sae.c b/src/sae.c
> index c14b646f..de2e0e0a 100644
> --- a/src/sae.c
> +++ b/src/sae.c
> @@ -1163,14 +1163,26 @@ static int sae_verify_confirmed(struct sae_sm *sm=
, uint16_t trans,
>   	 * transmit its Commit and Confirm (with the new Sc value) messages.
>   	 */
>   	sm->sync++;

So why do we sync in this case?

I would actually do something like:

/* Due to kernel retransmit behavior on missing acks + hostapd using incorr=
ect =

behavior, the following sequence can happen:
   < seq >

For this reason, in station mode, we ignore any Commit messages in the Conf=
irmed =

state as they're likely caused by retransmissions.
*/

if (!sm->handshake->authenticator)
	return -EBADMSG;

> -	sm->sc++;
> -
> -	sae_send_commit(sm, true);
>   =

> -	if (!sae_send_confirm(sm))
> -		return -EPROTO;
> +	/*
> +	 * TODO: There is a bug in hostapd which deaths stations if a commit
> +	 * is received in an Accepted SAE state. This can be triggered if the
> +	 * STA's commit is not acked, which triggers a re-transmission, and
> +	 * ultimated causes the AP to death IWD.
> +	 *
> +	 * Since this bug is present in production APs out in the wild we must
> +	 * work around it by going against the spec (802.11-2020 12.4.8.6.5) and
> +	 * simply drop the message.
> +	 *
> +	 * sm->sc++;
> +	 *
> +	 * sae_send_commit(sm, true);
> +	 *
> +	 * if (!sae_send_confirm(sm))
> +	 *         return -EPROTO;
> +	 */
>   =

> -	return -EAGAIN;
> +	return -EBADMSG;
>   }
>   =

>   /*
> =


Regards,
-Denis
--===============3908571275649547402==--

