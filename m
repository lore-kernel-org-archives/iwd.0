Content-Type: multipart/mixed; boundary="===============1031328656702616821=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] ap: Pass vendor IEs between frames and the user
Date: Thu, 18 Feb 2021 11:01:31 -0600
Message-ID: <43a4d084-47b0-085b-f382-3f695149a323@gmail.com>
In-Reply-To: <20210205234651.139105-1-andrew.zaborowski@intel.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1031328656702616821==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 2/5/21 5:46 PM, Andrew Zaborowski wrote:
> Add API for the ap.h users to add extra vendor IEs to outgoing
> management frames (beacons, etc.).  Pass the string IEs from the
> incoming STA association frames to the user in the AP event data.

This patch seems to be doing 2 separate things, no?  If so, it should reall=
y be =

two commits.  Especially since patch 3 only cares about the latter part.

> =

> I drop ap_event_station_added_data.rsn_ie because that probably
> wasn't going to ever be useful and the RSN IE is included in the
> assoc_ies array in any case.
> ---
>   src/ap.c | 233 ++++++++++++++++++++++++++++++++++++++++---------------
>   src/ap.h |  15 +++-
>   2 files changed, 186 insertions(+), 62 deletions(-)
> =


<snip>

> @@ -463,11 +474,51 @@ static void ap_set_rsn_info(struct ap_state *ap, st=
ruct ie_rsn_info *rsn)
>   	rsn->group_cipher =3D ap->group_cipher;
>   }
>   =

> +static size_t ap_get_vendor_ies_len(struct ap_state *ap,
> +					enum mpdu_management_subtype type)
> +{
> +	const struct l_queue_entry *entry;
> +	size_t len =3D 0;
> +
> +	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
> +			entry =3D entry->next) {
> +		struct ap_vendor_ie_writer *writer =3D entry->data;
> +
> +		len +=3D writer->get_len_func(type, writer->user_data);
> +	}
> +
> +	return len;
> +}
> +
> +static size_t ap_write_vendor_ies(struct ap_state *ap,
> +					enum mpdu_management_subtype type,
> +					uint8_t *out_buf)
> +{
> +	const struct l_queue_entry *entry;
> +	size_t len =3D 0;
> +
> +	for (entry =3D l_queue_get_entries(ap->sta_states); entry;
> +			entry =3D entry->next) {
> +		struct ap_vendor_ie_writer *writer =3D entry->data;
> +
> +		len +=3D writer->write_func(type, out_buf + len,
> +						writer->user_data);
> +	}
> +
> +	return len;
> +}
> +

I sort of wonder why you go through all these lengths when p2p is the only =

external user of this and registers the same user data object.

<snip>

> @@ -53,6 +57,10 @@ struct ap_event_registration_success_data {
>   };
>   =

>   typedef void (*ap_stopped_func_t)(void *user_data);
> +typedef size_t (*ap_get_vendor_ie_len)(enum mpdu_management_subtype type,
> +					void *user_data);
> +typedef size_t (*ap_write_vendor_ie)(enum mpdu_management_subtype type,
> +					uint8_t *out_buf, void *user_data);
>   =

>   struct ap_config {
>   	char *ssid;
> @@ -83,6 +91,11 @@ void ap_shutdown(struct ap_state *ap, ap_stopped_func_=
t stopped_func,
>   			void *user_data);
>   void ap_free(struct ap_state *ap);
>   =

> +void ap_add_vendor_ie_writer(struct ap_state *ap,
> +				ap_get_vendor_ie_len get_len_func,
> +				ap_write_vendor_ie write_func,
> +				void *user_data);
> +

This part would likely look better as an .ops structure...

Taking a step back here though, it feels like this API is really incomplete:

- There's no way for an external observer to grab an ap_state object in ord=
er =

for them to add a vendor IE (for example, some vendor plugin might want to =

advertise extra IEs or something).

- There's no way for an observer to react to any events since they're handl=
ed by =

the singleton 'handle_event' operation passed in to ap_start.  This part is =

particularly asymmetric with how ap_add_vendor_ie_writer() is meant to be u=
sed.

So what is the end goal for 'struct ap_state' APIs?  Should they be externa=
lly =

observable like station?  In that case you may want to add watchlists and s=
uch =

for this.

If they're meant only to be used by the P2P subclass, then you might as wel=
l =

move all these details into 'ap_ops' instead.

Also, you may consider flipping things around and instead of using a 'pull' =

mechanism, using a 'push' mechanism instead.  Add a couple of new events to =

signal that vendor IEs need to be updated (beaconing, association response,=
 etc) =

and have the clients invoke a function to write the new IEs.  This may be m=
ore =

flexible and would allow you hide some implementation details (i.e. add a =

growable buffer instead of a variable-length stack buffer, something which =
we =

probably should not use in this instance)

>   bool ap_station_disconnect(struct ap_state *ap, const uint8_t *mac,
>   				enum mmpdu_reason_code reason);
>   =

> =


Regards,
-Denis
--===============1031328656702616821==--

