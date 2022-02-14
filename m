Content-Type: multipart/mixed; boundary="===============5705899417020025227=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz at gmail.com>
To: iwd at lists.01.org
Subject: Re: [PATCH 2/3] hwsim: allow concurrent radio creations
Date: Mon, 14 Feb 2022 16:19:56 -0600
Message-ID: <548ed05d-7ccb-d1a9-2fe4-8df7350878be@gmail.com>
In-Reply-To: 20220214203439.989936-2-prestwoj@gmail.com

--===============5705899417020025227==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 2/14/22 14:34, James Prestwood wrote:
> Currently CreateRadio only allows a single outstanding DBus message
> until the radio is fully created. 99% of the time this is just fine
> but in order to test dual phy cards there needs to be support for
> phy's appearing at the same time.
> =

> This required storing the pending DBus message inside the radio object
> rather than a single static variable.
> ---
>   tools/hwsim.c | 77 +++++++++++++++++++++++++++------------------------
>   1 file changed, 41 insertions(+), 36 deletions(-)
> =

> diff --git a/tools/hwsim.c b/tools/hwsim.c
> index f74dd82e..87e5db57 100644
> --- a/tools/hwsim.c
> +++ b/tools/hwsim.c
> @@ -415,6 +415,7 @@ struct radio_info_rec {
>   	uint8_t addrs[2][ETH_ALEN];
>   	char *name;
>   	bool ap_only;
> +	struct l_dbus_message *pending;
>   };
>   =

>   struct interface_info_rec {
> @@ -428,13 +429,13 @@ struct interface_info_rec {
>   static struct l_queue *radio_info;
>   static struct l_queue *interface_info;
>   =

> -static struct l_dbus_message *pending_create_msg;
> -static uint32_t pending_create_radio_id;
> -
>   static void radio_free(void *user_data)
>   {
>   	struct radio_info_rec *rec =3D user_data;
>   =

> +	if (rec->pending)
> +		l_dbus_message_unref(rec->pending);
> +
>   	l_free(rec->name);
>   	l_free(rec);
>   }
> @@ -512,12 +513,6 @@ static const char *interface_get_path(const struct i=
nterface_info_rec *rec)
>   	return path;
>   }
>   =

> -static struct l_dbus_message *dbus_error_busy(struct l_dbus_message *msg)
> -{
> -	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".InProgress",
> -					"Operation already in progress");
> -}
> -
>   static struct l_dbus_message *dbus_error_failed(struct l_dbus_message *=
msg)
>   {
>   	return l_dbus_message_new_error(msg, HWSIM_SERVICE ".Failed",
> @@ -610,7 +605,7 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
>   	uint8_t file_buffer[128];
>   	int bytes, consumed;
>   	unsigned int uintval;
> -	bool old;
> +	bool old =3D false;
>   	struct radio_info_rec prev_rec;
>   	bool name_change =3D false;
>   	const char *path;
> @@ -637,8 +632,15 @@ static void get_radio_callback(struct l_genl_msg *ms=
g, void *user_data)
>   	if (!id || !name)
>   		return;
>   =

> +	/*
> +	 * If the radio info exists without a pending dbus message this is a
> +	 * name change. If the radio info exists with a pending message a
> +	 * minimal radio was created in order to save the DBus message. This
> +	 * can be handled nearly identical to if 'rec' is NULL by initializing
> +	 * the object now.
> +	 */
>   	rec =3D l_queue_find(radio_info, radio_info_match_id, L_UINT_TO_PTR(*i=
d));
> -	if (rec) {
> +	if (rec && !rec->pending) {
>   		old =3D true;
>   		memcpy(&prev_rec, rec, sizeof(prev_rec));
>   =

> @@ -647,8 +649,7 @@ static void get_radio_callback(struct l_genl_msg *msg=
, void *user_data)
>   			name_change =3D true;
>   =

>   		l_free(rec->name);
> -	} else {
> -		old =3D false;
> +	} else if (!rec) {
>   		rec =3D l_new(struct radio_info_rec, 1);
>   		rec->id =3D *id;
>   	}
> @@ -758,12 +759,12 @@ static void get_radio_callback(struct l_genl_msg *m=
sg, void *user_data)
>   	}
>   =

>   	/* Send pending CreateRadio reply */
> -	if (pending_create_msg && pending_create_radio_id =3D=3D rec->id) {
> +	if (rec->pending) {
>   		struct l_dbus_message *reply =3D
> -			l_dbus_message_new_method_return(pending_create_msg);
> +			l_dbus_message_new_method_return(rec->pending);
>   =

>   		l_dbus_message_set_arguments(reply, "o", path);
> -		dbus_pending_reply(&pending_create_msg, reply);
> +		dbus_pending_reply(&rec->pending, reply);
>   	}
>   =

>   	return;
> @@ -772,9 +773,9 @@ err_free_radio:
>   	if (!old)
>   		radio_free(rec);
>   =

> -	if (pending_create_msg && pending_create_radio_id =3D=3D *id)
> -		dbus_pending_reply(&pending_create_msg,
> -					dbus_error_failed(pending_create_msg));
> +	if (rec->pending)
> +		dbus_pending_reply(&rec->pending,
> +					dbus_error_failed(rec->pending));
>   }
>   =

>   static bool radio_ap_only(struct radio_info_rec *rec)
> @@ -1642,6 +1643,7 @@ static void unicast_handler(struct l_genl_msg *msg,=
 void *user_data)
>   static void radio_manager_create_callback(struct l_genl_msg *msg,
>   						void *user_data)
>   {
> +	struct l_dbus_message *message =3D user_data;
>   	struct l_dbus_message *reply;
>   	struct l_genl_attr attr;
>   	struct radio_info_rec *radio;
> @@ -1658,28 +1660,38 @@ static void radio_manager_create_callback(struct =
l_genl_msg *msg,
>   	if (err < 0)
>   		goto error;
>   =

> -	pending_create_radio_id =3D err;
> -
>   	/*
>   	 * If the NEW_RADIO event has been received we'll have added the
>   	 * radio to radio_info already but we can send the method return
>   	 * only now that we know the ID returned by our command.
>   	 */
>   	radio =3D l_queue_find(radio_info, radio_info_match_id,
> -				L_UINT_TO_PTR(pending_create_radio_id));
> -	if (radio && pending_create_msg) {
> +				L_UINT_TO_PTR(err));
> +	if (radio) {
>   		const char *path =3D radio_get_path(radio);
>   =

> -		reply =3D l_dbus_message_new_method_return(pending_create_msg);
> +		reply =3D l_dbus_message_new_method_return(message);
>   		l_dbus_message_set_arguments(reply, "o", path);
> -		dbus_pending_reply(&pending_create_msg, reply);
> +		dbus_pending_reply(&message, reply);
> +	} else {
> +		/*
> +		 * NEW_RADIO has not happened but in order to allow concurrent
> +		 * radio creations we must save away the message now. This means
> +		 * creating this minimal radio object in order to look up in
> +		 * the NEW_RADIO callback and reply.
> +		 */
> +		radio =3D l_new(struct radio_info_rec, 1);
> +		radio->id =3D err;
> +		radio->pending =3D message;
> +
> +		l_queue_push_tail(radio_info, radio);
>   	}
>   =

>   	return;
>   =

>   error:
> -	reply =3D dbus_error_failed(pending_create_msg);
> -	dbus_pending_reply(&pending_create_msg, reply);
> +	reply =3D dbus_error_failed(message);
> +	dbus_pending_reply(&message, reply);

This all seems even messier than before.  Maybe we should just always creat=
e the =

radio info structure in radio_manager_create and just set the =

pending_genl_cmd_id and dbus_message accordingly?  That way you're not crea=
ting =

the structure all over the place.

>   }
>   =

>   static struct l_dbus_message *radio_manager_create(struct l_dbus *dbus,

<snip>

> @@ -1753,10 +1762,9 @@ static struct l_dbus_message *radio_manager_create=
(struct l_dbus *dbus,
>   	}
>   =

>   	l_genl_family_send(hwsim, new_msg, radio_manager_create_callback,
> -				pending_create_msg, NULL);
> +				message, NULL);

Nit: You probably should be using the destroy callback here.  Otherwise the =

messages won't be cleaned up properly.

>   =

> -	pending_create_msg =3D l_dbus_message_ref(message);
> -	pending_create_radio_id =3D 0;
> +	l_dbus_message_ref(message);
>   =

>   	return NULL;
>   =


<snip>

Regards,
-Denis
--===============5705899417020025227==--

