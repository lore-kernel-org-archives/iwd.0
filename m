Content-Type: multipart/mixed; boundary="===============7382522948853033292=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH v2 1/2] hwsim: allow concurrent radio creations
Date: Tue, 15 Feb 2022 11:53:02 -0600
Message-ID: <f90c8063-e741-cf8d-b83f-bb50b0e9687e@gmail.com>
In-Reply-To: 20220215165242.1086346-1-prestwoj@gmail.com

--===============7382522948853033292==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/15/22 10:52, James Prestwood wrote:
> Currently CreateRadio only allows a single outstanding DBus message
> until the radio is fully created. 99% of the time this is just fine
> but in order to test dual phy cards there needs to be support for
> phy's appearing at the same time.
> =

> This required storing the pending DBus message inside the radio object
> rather than a single static variable.
> =

> To handle things a bit cleaner the radio info is now created when
> CreateRadio is called. The name is now a required arugment which allows

arugment->argument

> the NEW_RADIO event to lookup. This removes the duplicate code in the
> NEW_RADIO ack callback and leaves only error handling.
> ---
>   tools/hwsim.c | 147 +++++++++++++++++++++++++-------------------------
>   1 file changed, 73 insertions(+), 74 deletions(-)
> =


Yes, this looks much better now.

> v2:
>   * Removed creating the radio in multiple places. Instead only create
>     in the NEW_RADIO event.
> =


<snip>

> @@ -603,17 +611,18 @@ static void get_radio_callback(struct l_genl_msg *m=
sg, void *user_data)
>   	struct l_genl_attr attr;
>   	uint16_t type, len;
>   	const void *data;
> -	const char *name =3D NULL;
> +	_auto_(l_free) char *name =3D NULL;
>   	const uint32_t *id =3D NULL;
>   	size_t name_len =3D 0;
>   	struct radio_info_rec *rec;
>   	uint8_t file_buffer[128];
>   	int bytes, consumed;
>   	unsigned int uintval;
> -	bool old;
> +	bool old =3D false;
>   	struct radio_info_rec prev_rec;
>   	bool name_change =3D false;
>   	const char *path;
> +	struct l_dbus_message *reply;
>   =

>   	if (!l_genl_attr_init(&attr, msg))
>   		return;
> @@ -628,8 +637,7 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
>   			break;
>   =

>   		case HWSIM_ATTR_RADIO_NAME:
> -			name =3D data;
> -			name_len =3D len;
> +			name =3D l_strndup(data, len);

So why the strndup here?

>   			break;
>   		}
>   	}
> @@ -637,8 +645,13 @@ static void get_radio_callback(struct l_genl_msg *ms=
g, void *user_data)
>   	if (!id || !name)
>   		return;
>   =

> -	rec =3D l_queue_find(radio_info, radio_info_match_id, L_UINT_TO_PTR(*id=
));
> -	if (rec) {
> +	/*
> +	 * If the radio info exists without a pending dbus message this is a
> +	 * name change. Otherwise if the radio is not found something external
> +	 * created it, not hwsim.
> +	 */
> +	rec =3D l_queue_find(radio_info, radio_info_match_name, name);

If this is a name change, then how would this work?  I think you do need to =

match by id or by name.  This may be easier done with l_queue_get_entries s=
tyle =

for loop.

For a radio that is 'in flight', we may want to set the id to something =

non-sensical like -1.

> +	if (rec && !rec->pending) {
>   		old =3D true;
>   		memcpy(&prev_rec, rec, sizeof(prev_rec));
>   =

> @@ -647,13 +660,9 @@ static void get_radio_callback(struct l_genl_msg *ms=
g, void *user_data)
>   			name_change =3D true;
>   =

>   		l_free(rec->name);
> -	} else {
> -		old =3D false;
> -		rec =3D l_new(struct radio_info_rec, 1);
> -		rec->id =3D *id;
> -	}
> -
> -	rec->name =3D l_strndup(name, name_len);
> +		rec->name =3D l_strndup(name, name_len);

so either l_strndup _only_ here or l_stealptr if you already did that above=
. =

Assuming name isn't being used below.

> +	} else if (!rec)
> +		return;

This part seems suspicious.  What if the radio is being created outside hws=
im?

>   =

>   	l_genl_attr_init(&attr, msg);
>   =


Regards,
-Denis
--===============7382522948853033292==--

